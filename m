From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Fri, 31 Jul 2015 16:33:57 -0500
Subject: [PATCH v8 0/2] IMX GPCv2 drivers for wakeup source and suspend
Message-ID: <1438378439-11569-1-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IMX7D contains a new version of GPC IP block (GPCv2). It has two
major functions: power management and wakeup source management.

Two drivers were developed to support these functions:
One irqchip driver (irq-imx-gpcv2.c) is to manage
the interrupt wakeup source. One suspend driver (pm-imx7.c) is used
to manage the system power states.

Patch v8:
	Rename the structure "imx-gpcv2-irq" to "gpcv2_irqchip_data", and
	move it into irq-imx-gpcv2.c.
	Deleted the "gpcv2.h" header file, and moved 3 function declarations
	into common.h.
	Changed the compile switch for suspend-imx7.S and pm-imx7.c
	to CONFIG_SOC_IMX7D.
	Added the register and bit mask definitions.
	Added some error handling codes.
	Unified coding style and code clean up.

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
  ARM: imx: support suspend states on imx7D

 arch/arm/mach-imx/Kconfig        |   1 +
 arch/arm/mach-imx/Makefile       |   2 +
 arch/arm/mach-imx/common.h       |   4 +
 arch/arm/mach-imx/pm-imx7.c      | 917 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/suspend-imx7.S | 529 ++++++++++++++++++++++
 drivers/irqchip/Kconfig          |   7 +
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-imx-gpcv2.c  | 273 ++++++++++++
 8 files changed, 1734 insertions(+)
 create mode 100644 arch/arm/mach-imx/pm-imx7.c
 create mode 100644 arch/arm/mach-imx/suspend-imx7.S
 create mode 100644 drivers/irqchip/irq-imx-gpcv2.c

--
2.5.0.rc2
