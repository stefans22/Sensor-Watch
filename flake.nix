{
  description = "Nix-flake-based development environment for sensor-watch";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
  };

  outputs = { nixpkgs ,... }: let
    # system should match the system you are running on
    system = "x86_64-linux";
    #system = "x86_64-darwin";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs {
        inherit system;
      };
    in pkgs.mkShell {
      name = "Sensorwatch development shell";
      packages = with pkgs; [
        gcc-arm-embedded
        python3
        emscripten
      ];

      shellHook = ''
        # prepare env
        mkdir -p /tmp/emcache
        export EM_CACHE=/tmp/emcache # https://github.com/NixOS/nixpkgs/issues/282509
        export COLOR=RED
      '';
    };
  };
}
