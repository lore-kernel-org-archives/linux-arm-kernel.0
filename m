From: linux-arm@overkiz.com (Boris BREZILLON)
Date: Sat, 12 May 2012 10:53:53 +0200
Subject: [PATCH 0/5] ARM: at91: moving at91 to the common clk framework
Message-ID: <1336812838-3649-1-git-send-email-linux-arm@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements at91 pmc clks using the the common clk framework.
This implementation is only used for dt boards and is tightly linked
with device tree support (requires "DT clock binding support" patch).

What's missing : 
 * UTMI and USB (Host and Device) clk drivers.
 * Devce tree binding documentation
 * Atmel drivers port to the commonc clk framework:
   * use clk_prepare_enable instead of clk_enable.
   * use of_clk_get instead of clk_get when dt is enabled.

I'd like to have some feedback on the implementation and dt binding 
before adding the missing stuffs.

Best Regards,

Boris

Boris BREZILLON (5):
  at91: Add at91 PMC registers definitions.
  at91: Move at91 PMC clks to the common clk framework.
  at91: disable specific soc clock init function if COMMON_CLK is
    selected.
  at91: add pmc clks definition into device tree (at91sam9260, 9g20).
  at91: Modify board_dt init sequence to use PMC common clk
    implementation.

 arch/arm/boot/dts/at91sam9260.dtsi         |  299 ++++++++++++++++++++-
 arch/arm/boot/dts/at91sam9g20.dtsi         |   44 +++
 arch/arm/mach-at91/Kconfig                 |    1 +
 arch/arm/mach-at91/Makefile                |    5 +-
 arch/arm/mach-at91/at91sam9260.c           |    9 +-
 arch/arm/mach-at91/board-dt.c              |   72 ++++-
 arch/arm/mach-at91/include/mach/at91_pmc.h |    5 +
 arch/arm/mach-at91/pmc-master.c            |  401 ++++++++++++++++++++++++++++
 arch/arm/mach-at91/pmc-osc.c               |  165 ++++++++++++
 arch/arm/mach-at91/pmc-periph.c            |  111 ++++++++
 arch/arm/mach-at91/pmc-pll.c               |  371 +++++++++++++++++++++++++
 arch/arm/mach-at91/pmc-prog.c              |  194 ++++++++++++++
 arch/arm/mach-at91/pmc-sys.c               |   81 ++++++
 arch/arm/mach-at91/pmc.c                   |  260 ++++++++++++++++++
 arch/arm/mach-at91/pmc.h                   |   70 +++++
 arch/arm/mach-at91/setup.c                 |    8 +-
 16 files changed, 2087 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/mach-at91/pmc-master.c
 create mode 100644 arch/arm/mach-at91/pmc-osc.c
 create mode 100644 arch/arm/mach-at91/pmc-periph.c
 create mode 100644 arch/arm/mach-at91/pmc-pll.c
 create mode 100644 arch/arm/mach-at91/pmc-prog.c
 create mode 100644 arch/arm/mach-at91/pmc-sys.c
 create mode 100644 arch/arm/mach-at91/pmc.c
 create mode 100644 arch/arm/mach-at91/pmc.h

-- 
1.7.9.5
