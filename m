From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Mon, 27 Jul 2015 14:29:58 -0500
Subject: [PATCH v7 0/2] IMX GPCv2 drivers for wakeup source and suspend
Message-ID: <1438025400-5919-1-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IMX7D contains a new version of GPC IP block (GPCv2). It has two
major functions: power management and wakeup source management.

Two drivers were developed to support these functions:
One irqchip driver (irq-imx-gpcv2.c) is to manage
the interrupt wakeup source. One suspend driver (pm-imx7.c) is used
to manage the system power states.

Patch v7:
	Move most of the macros and definitions into relating source files
	Replace the spinlock_t with the struct raw_spinlock in imx_gpcv2_irq
	Code clean up

Patch V6:
	Clean up the codes (irq-imx-gpcv2.c) according to the review
	feedback of Thomas Glx
	Use raw_spin_lock in the irq_mask and irq_unmask callbacks
	Split the struct definition into two: irqchip and suspend
	Unified coding style

Patch V5:
	Splitted it into two patches per Thomas Gleixner suggestion.
	-- one for irqchip
	-- one for suspend

Patch V4:
	Splitted the driver into two function drivers: one irqchip driver
	for wakeup source management, and one suspend driver for power
	state management.

Patch V3:
	Added the assemble codes (suspend-imx7.S) for SUSPEND_MEM state.
	Supported the SUSPEND_MEM power mode.

Patch V2:
	Added the basic driver APIs for power management.
	Supported the STANDBY power mode.

Patch V1:
	Implemented the driver for IRQ wakeup sources.

Shenwei Wang (2):
  irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup sources
  ARM: imx: Add suspend codes for imx7D

 arch/arm/mach-imx/Kconfig        |   1 +
 arch/arm/mach-imx/Makefile       |   2 +
 arch/arm/mach-imx/pm-imx7.c      | 901 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/suspend-imx7.S | 529 +++++++++++++++++++++++
 drivers/irqchip/Kconfig          |   7 +
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-imx-gpcv2.c  | 254 +++++++++++
 include/soc/imx/gpcv2.h          |  25 ++
 8 files changed, 1720 insertions(+)
 create mode 100644 arch/arm/mach-imx/pm-imx7.c
 create mode 100644 arch/arm/mach-imx/suspend-imx7.S
 create mode 100644 drivers/irqchip/irq-imx-gpcv2.c
 create mode 100644 include/soc/imx/gpcv2.h

--
2.5.0.rc2
