From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:18:11 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v4.18
Message-ID: <cover.1526639075.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC updates for v4.18.


The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v4.18

for you to fetch changes up to 086b399965a7ee7e50c3b3c57f2dba30ff0334b0:

  soc: renesas: r8a77990-sysc: Add workaround for 3DG-{A,B} (2018-05-16 10:57:44 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v4.18

* SoC
  - Change platform dependency to ARCH_RENESAS

    Geert Uytterhoeven says "The Renesas Fine Display Processor driver is
    used on Renesas R-Car SoCs only.  Since commit 9b5ba0df4ea4f940 ("ARM:
    shmobile: Introduce ARCH_RENESAS") is ARCH_RENESAS a more appropriate
    platform dependency than the legacy ARCH_SHMOBILE, hence use the
    former.

    This will allow to drop ARCH_SHMOBILE on ARM and ARM64 in the near
    future."

  - Add the to Kconfig RZ/N1D (r9a06g032) SoC

    In preparation for upstream support of this SoC

  - Identify R-Car E3 (r8a77990) SoC

  - Identify and add minimal support for RZ/G1C (r8a77470) SoC

* R-Car SYSC
  - Add support for R-Car E3 (r8a77990) SoC

    Shimoda-san says this adds:
    + "Cortex-A53 CPU{0,1}, Cortex-A53 SCU, Cortex-R7, A3VC,
       A2VC1 and 3DG-{A,B} power domain areas..."

    + "workaround for 3DG-{A,B} of R-Car E3 ES1.0 because
       the SoC has a restriction about the order."

  - Remove unused inclusion of <linux/sys_soc.h>,

  - Make r8a77995_areas[] const.

* R-Car Reset

  - Add support for R-Car E3 (r8a77990) SoC

    This driver is needed for the clock driver to work

* Debug-LL

  - Add support for RZ/G1C (r8a77470) SoC

    RZ/G1C uses SCIF1 for the debug console

----------------------------------------------------------------
Biju Das (5):
      soc: renesas: Identify RZ/G1C
      soc: renesas: rcar-rst: Add support for RZ/G1C
      soc: renesas: rcar-sysc: Add r8a77470 support
      ARM: shmobile: r8a77470: basic SoC support
      ARM: debug-ll: Add support for r8a77470

Geert Uytterhoeven (2):
      soc: renesas: r8a77995-sysc: Cleanups
      arm: shmobile: Change platform dependency to ARCH_RENESAS

Michel Pollet (2):
      ARM: shmobile: Add the RZ/N1 arch to the shmobile Kconfig
      arm: shmobile: Add the RZ/N1D (R9A06G032) to the shmobile Kconfig

Takeshi Kihara (4):
      soc: renesas: identify R-Car E3
      soc: renesas: Add r8a77990 SYSC PM Domain Binding Definitions
      soc: renesas: rcar-rst: Add support for R-Car E3
      soc: renesas: rcar-sysc: Add support for R-Car E3 power areas

Yoshihiro Shimoda (1):
      soc: renesas: r8a77990-sysc: Add workaround for 3DG-{A,B}

 Documentation/devicetree/bindings/arm/shmobile.txt |  2 +
 .../bindings/power/renesas,rcar-sysc.txt           |  2 +
 .../devicetree/bindings/reset/renesas,rst.txt      |  2 +
 arch/arm/Kconfig                                   |  2 +-
 arch/arm/Kconfig.debug                             | 13 ++++-
 arch/arm/Makefile                                  |  2 +-
 arch/arm/mach-shmobile/Kconfig                     | 13 +++++
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |  2 +
 drivers/soc/renesas/Kconfig                        | 13 ++++-
 drivers/soc/renesas/Makefile                       |  2 +
 drivers/soc/renesas/r8a77470-sysc.c                | 29 +++++++++
 drivers/soc/renesas/r8a77990-sysc.c                | 68 ++++++++++++++++++++++
 drivers/soc/renesas/r8a77995-sysc.c                |  3 +-
 drivers/soc/renesas/rcar-rst.c                     |  2 +
 drivers/soc/renesas/rcar-sysc.c                    |  6 ++
 drivers/soc/renesas/rcar-sysc.h                    |  2 +
 drivers/soc/renesas/renesas-soc.c                  | 16 +++++
 include/dt-bindings/power/r8a77470-sysc.h          | 22 +++++++
 include/dt-bindings/power/r8a77990-sysc.h          | 26 +++++++++
 19 files changed, 220 insertions(+), 7 deletions(-)
 create mode 100644 drivers/soc/renesas/r8a77470-sysc.c
 create mode 100644 drivers/soc/renesas/r8a77990-sysc.c
 create mode 100644 include/dt-bindings/power/r8a77470-sysc.h
 create mode 100644 include/dt-bindings/power/r8a77990-sysc.h
