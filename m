From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 09 Apr 2013 17:48:52 +0200
Subject: [GIT PULL] Sunxi Cleanups for 3.10
Message-ID: <51643864.4050906@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is a pull request for the various cleanups for the sunXi platform
for 3.10.

It is based both on Mike Turquette's clk-for-3.10 branch and on the
branch clksrc/cleanup found in arm-soc

The following changes since commit 7c91d302ffe2ffac813c47d6ba2e7489a2ccb35f:

  Merge remote-tracking branch 'clk/clk-for-3.10' into sunxi/core-for-3.10 (2013-04-08 21:39:22 +0200)

are available in the git repository at:


  git://github.com/mripard/linux.git tags/sunxi-cleanup-for-3.10

for you to fetch changes up to bc34b5f27cd33f4213bc5c8df0099dd11408d29d:

  ARM: sunxi: Rework the restart code (2013-04-08 21:43:08 +0200)

----------------------------------------------------------------
Cleanups for Allwinner sunXi architecture:
  - Remove sunxi.dtsi
  - Switch to clocksource/irqchip device tree handlers
  - Cleanup the watchdog code

----------------------------------------------------------------
Maxime Ripard (6):
      clocksource: sunxi: Cleanup the timer code
      clocksource: sunxi: make use of CLKSRC_OF
      clocksource: sunxi: Rename sunxi to sun4i
      irqchip: sunxi: Make use of the IRQCHIP_DECLARE macro
      irqchip: sunxi: Rename sunxi to sun4i
      ARM: sunxi: Rework the restart code

 ...lwinner,sunxi-ic.txt => allwinner,sun4i-ic.txt} |    4 +-
 ...r,sunxi-timer.txt => allwinner,sun4i-timer.txt} |    4 +-
 .../watchdog/{sunxi-wdt.txt => sun4i-wdt.txt}      |    6 +-
 arch/arm/mach-sunxi/Kconfig                        |    5 +-
 arch/arm/mach-sunxi/sunxi.c                        |   74 ++++++----
 drivers/clocksource/Kconfig                        |    2 +-
 drivers/clocksource/Makefile                       |    2 +-
 .../clocksource/{sunxi_timer.c => sun4i_timer.c}   |   94 ++++++------
 drivers/irqchip/Makefile                           |    2 +-
 drivers/irqchip/irq-sun4i.c                        |  149 +++++++++++++++++++
 drivers/irqchip/irq-sunxi.c                        |  151 --------------------
 include/linux/irqchip/sunxi.h                      |   27 ----
 include/linux/sunxi_timer.h                        |   24 ----
 13 files changed, 249 insertions(+), 295 deletions(-)
 rename Documentation/devicetree/bindings/interrupt-controller/{allwinner,sunxi-ic.txt => allwinner,sun4i-ic.txt} (94%)
 rename Documentation/devicetree/bindings/timer/{allwinner,sunxi-timer.txt => allwinner,sun4i-timer.txt} (78%)
 rename Documentation/devicetree/bindings/watchdog/{sunxi-wdt.txt => sun4i-wdt.txt} (57%)
 rename drivers/clocksource/{sunxi_timer.c => sun4i_timer.c} (50%)
 create mode 100644 drivers/irqchip/irq-sun4i.c
 delete mode 100644 drivers/irqchip/irq-sunxi.c
 delete mode 100644 include/linux/irqchip/sunxi.h
 delete mode 100644 include/linux/sunxi_timer.h

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
