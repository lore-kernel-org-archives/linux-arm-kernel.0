From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Mar 2013 14:30:23 +0100
Subject: [PATCH 00/10] ARM: sunxi: Architecture cleanups and rework
Message-ID: <1364218233-29636-1-git-send-email-maxime.ripard@free-electrons.com>
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

 arch/arm/boot/dts/sun4i-a10-cubieboard.dts |    2 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts  |    2 +-
 arch/arm/boot/dts/sun4i-a10.dtsi           |  157 +++++++++++++++++++++++++--
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts  |    2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi           |  145 ++++++++++++++++++++++++-
 arch/arm/boot/dts/sunxi.dtsi               |  159 ---------------------------
 arch/arm/mach-sunxi/Kconfig                |    5 +-
 arch/arm/mach-sunxi/sunxi.c                |   68 +++++++-----
 drivers/clocksource/Kconfig                |    2 +-
 drivers/clocksource/Makefile               |    2 +-
 drivers/clocksource/sun4i_timer.c          |  161 ++++++++++++++++++++++++++++
 drivers/clocksource/sunxi_timer.c          |  160 ---------------------------
 drivers/irqchip/Makefile                   |    2 +-
 drivers/irqchip/irq-sun4i.c                |  149 +++++++++++++++++++++++++
 drivers/irqchip/irq-sunxi.c                |  151 --------------------------
 include/linux/irqchip/sunxi.h              |   27 -----
 include/linux/sunxi_timer.h                |   24 -----
 17 files changed, 650 insertions(+), 568 deletions(-)
 delete mode 100644 arch/arm/boot/dts/sunxi.dtsi
 create mode 100644 drivers/clocksource/sun4i_timer.c
 delete mode 100644 drivers/clocksource/sunxi_timer.c
 create mode 100644 drivers/irqchip/irq-sun4i.c
 delete mode 100644 drivers/irqchip/irq-sunxi.c
 delete mode 100644 include/linux/irqchip/sunxi.h
 delete mode 100644 include/linux/sunxi_timer.h

-- 
1.7.10.4
