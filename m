From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Mar 2013 10:13:07 +0100
Subject: [PATCHv2 00/10] ARM: sunxi: Architecture cleanups and rework
Message-ID: <1364289198-11589-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset is a serie of various cleanups and reworks in the sunxi
architecture to prepare a clean landing for the next Allwinner SoC, the
A31 (sun6i).

The A31 is significantly different from the previous Allwinner SoC we
supported, the A10 and A13, to no longer make the generic sunxi prefix
we used in most compatible string relevant, while it should really have
been sun4i in the first place.

This set is also the occasion to cleanup the timer and irq code by
switching to the recently introduced clocksource and irqchip
infrastructures.

This set depends on the UART patches I sent previously.

Maxime

Changes from v1:
  - Rebased on top of Rob Herring's clksrc/cleanup branch
  - Updated the Documentation with the new compatible strings

Maxime Ripard (10):
  ARM: sunxi: dt: Reorganize the dtsi
  clocksource: sunxi: Cleanup the timer code
  clocksource: sunxi: make use of CLKSRC_OF
  clocksource: sunxi: Rename sunxi to sun4i
  ARM: sunxi: dt: Update timer compatible string
  irqchip: sunxi: Make use of the IRQCHIP_DECLARE macro
  irqchip: sunxi: Rename sunxi to sun4i
  ARM: sunxi: dt: Update interrupt controller compatible string
  ARM: sunxi: Rework the restart code
  ARM: sunxi: dt: Update watchdog compatible string

 ...lwinner,sunxi-ic.txt => allwinner,sun4i-ic.txt} |    4 +-
 ...r,sunxi-timer.txt => allwinner,sun4i-timer.txt} |    4 +-
 .../watchdog/{sunxi-wdt.txt => sun4i-wdt.txt}      |    6 +-
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         |    2 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts          |    2 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                   |  157 ++++++++++++++++++-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |    2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                   |  145 +++++++++++++++++-
 arch/arm/boot/dts/sunxi.dtsi                       |  159 --------------------
 arch/arm/mach-sunxi/Kconfig                        |    5 +-
 arch/arm/mach-sunxi/sunxi.c                        |   74 +++++----
 drivers/clocksource/Kconfig                        |    2 +-
 drivers/clocksource/Makefile                       |    2 +-
 .../clocksource/{sunxi_timer.c => sun4i_timer.c}   |   94 +++++-------
 drivers/irqchip/Makefile                           |    2 +-
 drivers/irqchip/{irq-sunxi.c => irq-sun4i.c}       |  116 +++++++-------
 include/linux/irqchip/sunxi.h                      |   27 ----
 include/linux/sunxi_timer.h                        |   24 ---
 18 files changed, 452 insertions(+), 375 deletions(-)
 rename Documentation/devicetree/bindings/interrupt-controller/{allwinner,sunxi-ic.txt => allwinner,sun4i-ic.txt} (94%)
 rename Documentation/devicetree/bindings/timer/{allwinner,sunxi-timer.txt => allwinner,sun4i-timer.txt} (78%)
 rename Documentation/devicetree/bindings/watchdog/{sunxi-wdt.txt => sun4i-wdt.txt} (57%)
 delete mode 100644 arch/arm/boot/dts/sunxi.dtsi
 rename drivers/clocksource/{sunxi_timer.c => sun4i_timer.c} (50%)
 rename drivers/irqchip/{irq-sunxi.c => irq-sun4i.c} (38%)
 delete mode 100644 include/linux/irqchip/sunxi.h
 delete mode 100644 include/linux/sunxi_timer.h

-- 
1.7.10.4
