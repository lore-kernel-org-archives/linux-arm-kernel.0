From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:05:38 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v4.14
Message-ID: <cover.1501512320.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC updates for v4.14.


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v4.14

for you to fetch changes up to 84a1e84b95bb7b2596821578c3acc38d4e6e7a59:

  ARM: shmobile: Remove ARCH_SHMOBILE_MULTI (2017-07-27 17:31:12 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v4.14

* Add debug-ll support to RZ/G1M (r8a7743) SoC

  Chris Paterson says, "RZ/G1M uses SCIF0 for the debug console, like most
  of the R-Car Gen2 SoCs."

* Remove ARCH_SHMOBILE_MULTI

  Geert Uytterhoeven says, "The migration from ARCH_SHMOBILE_MULTI to
  ARCH_RENESAS has been completed in v4.12..."

* Correct arch timer frequency on RZ/G1M (r8a7743) SoC

  Geert Uytterhoeven says, "According to the datasheet, the frequency of
  the ARM architecture timer on RZ/G1E depends on the frequency of the ZS
  clock..."

* Add support for CPG/MSSR bindings

  Geert Uytterhoeven says, "When using the new CPG/MSSR bindings, there is
  no longer a "renesas,rcar-gen2-cpg-clocks" node, and the code to obtain
  the external clock crystal frequency falls back to a default of 20 MHz.
  While this is correct for all upstream R-Car Gen2 and RZ/G1 boards, this
  is not necessarily the case for out-of-tree third party boards.

  Add support for finding the external clock crystal oscillator on RZ/G1M,
  and on R-Car H2, M2-W, and M2-N using the new CPG/MSSR bindings, through
  the corresponding "renesas,r8a77xx-cpg-mssr" nodes."

* Obtain jump stub region from DT

  Geert Uytterhoeven says, "Add support for obtaining from DT the SRAM
  region to store the jump stub for CPU core bringup, according to the
  renesas,smp-sram DT bindings."

----------------------------------------------------------------
Chris Paterson (1):
      ARM: debug-ll: Add support for r8a7743

Geert Uytterhoeven (4):
      ARM: shmobile: rcar-gen2: Obtain jump stub region from DT
      ARM: shmobile: rcar-gen2: Add support for CPG/MSSR bindings
      ARM: shmobile: rcar-gen2: Correct arch timer frequency on RZ/G1E
      ARM: shmobile: Remove ARCH_SHMOBILE_MULTI

 arch/arm/Kconfig.debug                   |  9 +++++----
 arch/arm/mach-shmobile/Kconfig           |  4 ----
 arch/arm/mach-shmobile/pm-rcar-gen2.c    | 33 +++++++++++++++++++++++++++++---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 21 ++++++++++++++++----
 4 files changed, 52 insertions(+), 15 deletions(-)
