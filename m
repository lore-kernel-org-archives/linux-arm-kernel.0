From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:42 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v4.10
Message-ID: <cover.1478251657.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC updates for v4.10.


The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v4.10

for you to fetch changes up to 9652623f8f019edc93a7a934a10b7d0b90421d5a:

  ARM: shmobile: r8a7779/marzen: Add board part number to DT bindings (2016-11-04 10:25:45 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v4.10

Enhancements:
* Basic support for r8a7743 SoC; only SoC code so far
* Select errata 798181 for SoCs with CA15 cores

Clean-up:
* Consolidate R8A7743 and R8A779[234] machine definitions

Documentation:
* Add Marzen, Gose and Alt board part numbers to DT bindings
* Document SK-RZG1M board

----------------------------------------------------------------
Geert Uytterhoeven (4):
      ARM: shmobile: Sort Kconfig selections
      ARM: shmobile: r8a7794/alt: Add board part number to DT bindings
      ARM: shmobile: r8a7793/gose: Add board part number to DT bindings
      ARM: shmobile: r8a7779/marzen: Add board part number to DT bindings

Laurent Pinchart (1):
      ARM: shmobile: Consolidate R8A7743 and R8A779[234] machine definitions

Sergei Shtylyov (2):
      ARM: shmobile: r8a7743: basic SoC support
      ARM: shmobile: document SK-RZG1M board

Simon Horman (2):
      ARM: shmobile: only call rcar_gen2_clocks_init() if present
      ARM: shmobile: select errata 798181 for SoCs with CA15 cores

 Documentation/devicetree/bindings/arm/shmobile.txt | 10 +++--
 arch/arm/mach-shmobile/Kconfig                     | 16 ++++++--
 arch/arm/mach-shmobile/Makefile                    |  3 --
 arch/arm/mach-shmobile/setup-r8a7792.c             | 35 -----------------
 arch/arm/mach-shmobile/setup-r8a7793.c             | 33 ----------------
 arch/arm/mach-shmobile/setup-r8a7794.c             | 33 ----------------
 arch/arm/mach-shmobile/setup-rcar-gen2.c           | 44 +++++++++++++++++++++-
 7 files changed, 63 insertions(+), 111 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/setup-r8a7792.c
 delete mode 100644 arch/arm/mach-shmobile/setup-r8a7793.c
 delete mode 100644 arch/arm/mach-shmobile/setup-r8a7794.c
