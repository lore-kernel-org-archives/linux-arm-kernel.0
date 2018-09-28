From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:23:33 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Drivers Updates for v4.20
Message-ID: <cover.1538128711.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC drivers updates for v4.20.


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-drivers-for-v4.20

for you to fetch changes up to fae210bb5bfbd29118e18881f7108c6bd59293b9:

  dt-bindings: apmu: Document r8a7744 support (2018-09-24 17:21:12 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC Drivers Updates for v4.20

* Convert to SPDX identifiers
* R-Car V3M (r8a77970) and V3H (r8a77980): Document Timer Unit (TMU) bindings
* RZ/G1N (r8a7744) and RZ/G1C (r8a77470) SoCs:
  - Document APMU and SMP enable method
* RZ/G2M (r8a74a1), RZ/G1N (r8a7744) and RZ/G2E (r8a774c0) SoCs:
  - Add reset support
  - Add sysc support
* RZ/G2M (r8a774a1), RZ/G2E (r8a774c0) and RZ/A2M (r7s9210) SoCs:
  - Add support for identifying SoC
* RZ/A2M (r7s9210) SoC:
  - Add basic SoC setup support

----------------------------------------------------------------
Biju Das (10):
      soc: renesas: Identify RZ/G2M
      dt-bindings: power: Add r8a774a1 SYSC power domain definitions
      soc: renesas: rcar-sysc: Add r8a774a1 support
      soc: renesas: rcar-rst: Add support for RZ/G2M
      dt-bindings: power: rcar-sysc: Document r8a7744 SYSC binding
      dt-bindings: power: rcar-sysc: Add r8a7744 power domain index macros
      soc: renesas: rcar-sysc: Add r8a7744 support
      dt-bindings: reset: rcar-rst: Document r8a7744 reset module
      soc: renesas: rcar-rst: Add support for RZ/G1N
      dt-bindings: apmu: Document r8a7744 support

Chris Brandt (2):
      ARM: shmobile: Add basic RZ/A2 SoC support
      soc: renesas: identify RZ/A2

Fabrizio Castro (7):
      soc: renesas: Identify RZ/G2E
      dt-bindings: power: Add r8a774c0 SYSC power domain definitions
      dt-bindings: power: rcar-sysc: Document r8a774c0 sysc
      soc: renesas: rcar-sysc: Add r8a774c0 support
      dt-bindings: reset: rcar-rst: Document r8a774c0 rst
      soc: renesas: rcar-rst: Add support for RZ/G2E
      dt-bindings: apmu: Document r8a77470 support

Kuninori Morimoto (1):
      soc: renesas: convert to SPDX identifiers

Sergei Shtylyov (1):
      dt-bindings: timer: renesas: tmu: document R8A779{7|8}0 bindings

 .../devicetree/bindings/power/renesas,apmu.txt     |   2 +
 .../bindings/power/renesas,rcar-sysc.txt           |   3 +
 .../devicetree/bindings/reset/renesas,rst.txt      |   3 +
 .../devicetree/bindings/timer/renesas,tmu.txt      |   2 +
 arch/arm/mach-shmobile/Kconfig                     |   6 ++
 arch/arm/mach-shmobile/Makefile                    |   1 +
 arch/arm/mach-shmobile/setup-r7s9210.c             |  27 ++++++
 drivers/soc/renesas/Kconfig                        |  19 +++-
 drivers/soc/renesas/Makefile                       |   2 +
 drivers/soc/renesas/r8a7743-sysc.c                 |   5 +-
 drivers/soc/renesas/r8a7745-sysc.c                 |   5 +-
 drivers/soc/renesas/r8a774a1-sysc.c                |  45 ++++++++++
 drivers/soc/renesas/r8a774c0-sysc.c                |  68 ++++++++++++++
 drivers/soc/renesas/r8a7779-sysc.c                 |   5 +-
 drivers/soc/renesas/r8a7790-sysc.c                 |   5 +-
 drivers/soc/renesas/r8a7791-sysc.c                 |   5 +-
 drivers/soc/renesas/r8a7792-sysc.c                 |   5 +-
 drivers/soc/renesas/r8a7794-sysc.c                 |   5 +-
 drivers/soc/renesas/r8a7795-sysc.c                 |   5 +-
 drivers/soc/renesas/r8a7796-sysc.c                 |   5 +-
 drivers/soc/renesas/r8a77970-sysc.c                |   5 +-
 drivers/soc/renesas/r8a77995-sysc.c                |   5 +-
 drivers/soc/renesas/rcar-rst.c                     |  11 +--
 drivers/soc/renesas/rcar-sysc.c                    |  13 ++-
 drivers/soc/renesas/rcar-sysc.h                    |   9 +-
 drivers/soc/renesas/renesas-soc.c                  | 100 ++++++++++++++++-----
 include/dt-bindings/power/r8a7744-sysc.h           |  24 +++++
 include/dt-bindings/power/r8a774a1-sysc.h          |  31 +++++++
 include/dt-bindings/power/r8a774c0-sysc.h          |  25 ++++++
 29 files changed, 360 insertions(+), 86 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/setup-r7s9210.c
 create mode 100644 drivers/soc/renesas/r8a774a1-sysc.c
 create mode 100644 drivers/soc/renesas/r8a774c0-sysc.c
 create mode 100644 include/dt-bindings/power/r8a7744-sysc.h
 create mode 100644 include/dt-bindings/power/r8a774a1-sysc.h
 create mode 100644 include/dt-bindings/power/r8a774c0-sysc.h
