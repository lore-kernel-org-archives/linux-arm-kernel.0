From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 05 Jul 2011 16:10:07 -0400 (EDT)
Subject: [PATCH/RFC] mach-loki: delete
Message-ID: <alpine.LFD.2.00.1107051558470.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


If someone disagrees with the following patch please reply ASAP.

commit 7c3ecafbeb951d57399ec8e772f987e603e31e40
Author: Nicolas Pitre <nico@fluxnic.net>
Date:   Tue Jul 5 15:27:58 2011 -0400

    ARM: mach-loki: delete
    
    This was introduced more than 3 years ago, and since then only generic
    janitorial changes were made without further addition of actual support
    for "real" devices.  This is therefore a cost with no benefits to keep
    in the tree.  If someone wishes to revive this code, it is always
    possible to retrieve it from the Git repository.
    
    Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
    CC: Ke Wei <kewei@marvell.com>
    CC: Saeed Bishara <saeed@marvell.com>
    CC: Lennert Buytenhek <buytenh@wantstofly.org>

---
 arch/arm/Makefile                             |    1 -
 arch/arm/configs/loki_defconfig               |  120 --------------
 arch/arm/mach-loki/Kconfig                    |   13 --
 arch/arm/mach-loki/Makefile                   |    3 -
 arch/arm/mach-loki/Makefile.boot              |    3 -
 arch/arm/mach-loki/addr-map.c                 |  122 --------------
 arch/arm/mach-loki/common.c                   |  162 -------------------
 arch/arm/mach-loki/common.h                   |   37 -----
 arch/arm/mach-loki/include/mach/bridge-regs.h |   28 ----
 arch/arm/mach-loki/include/mach/debug-macro.S |   19 ---
 arch/arm/mach-loki/include/mach/entry-macro.S |   30 ----
 arch/arm/mach-loki/include/mach/hardware.h    |   15 --
 arch/arm/mach-loki/include/mach/io.h          |   26 ---
 arch/arm/mach-loki/include/mach/irqs.h        |   58 -------
 arch/arm/mach-loki/include/mach/loki.h        |   83 ----------
 arch/arm/mach-loki/include/mach/system.h      |   36 ----
 arch/arm/mach-loki/include/mach/timex.h       |   11 --
 arch/arm/mach-loki/include/mach/uncompress.h  |   47 ------
 arch/arm/mach-loki/include/mach/vmalloc.h     |    5 -
 arch/arm/mach-loki/irq.c                      |   22 ---
 arch/arm/mach-loki/lb88rc8480-setup.c         |   99 -----------
 21 files changed, 0 insertions(+), 940 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 64d2591..25f34a8 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -150,7 +150,6 @@ machine-$(CONFIG_ARCH_IXP23XX)		:= ixp23xx
 machine-$(CONFIG_ARCH_IXP4XX)		:= ixp4xx
 machine-$(CONFIG_ARCH_KIRKWOOD)		:= kirkwood
 machine-$(CONFIG_ARCH_KS8695)		:= ks8695
-machine-$(CONFIG_ARCH_LOKI) 		:= loki
 machine-$(CONFIG_ARCH_LPC32XX)		:= lpc32xx
 machine-$(CONFIG_ARCH_MMP)		:= mmp
 machine-$(CONFIG_ARCH_MSM)		:= msm
diff --git a/arch/arm/configs/loki_defconfig b/arch/arm/configs/loki_defconfig
deleted file mode 100644
index 1ba752b..0000000
--- a/arch/arm/configs/loki_defconfig
+++ /dev/null
@@ -1,120 +0,0 @@
-CONFIG_EXPERIMENTAL=y
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_EXPERT=y
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_LOKI=y
-CONFIG_MACH_LB88RC8480=y
-# CONFIG_CPU_FEROCEON_OLD_ID is not set
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_PREEMPT=y
-CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-# CONFIG_IPV6 is not set
-CONFIG_NET_PKTGEN=m
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
-CONFIG_MTD_BLOCK=y
-CONFIG_FTL=y
-CONFIG_NFTL=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_JEDECPROBE=y
-CONFIG_MTD_CFI_ADV_OPTIONS=y
-CONFIG_MTD_CFI_GEOMETRY=y
-CONFIG_MTD_CFI_I4=y
-CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_STAA=y
-CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_M25P80=y
-CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_VERIFY_WRITE=y
-CONFIG_MTD_NAND_ORION=y
-CONFIG_BLK_DEV_LOOP=y
-# CONFIG_MISC_DEVICES is not set
-# CONFIG_SCSI_PROC_FS is not set
-CONFIG_BLK_DEV_SD=y
-CONFIG_BLK_DEV_SR=m
-CONFIG_CHR_DEV_SG=m
-CONFIG_ATA=y
-CONFIG_SATA_MV=y
-CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
-CONFIG_MV643XX_ETH=y
-# CONFIG_NETDEV_10000 is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_RUNTIME_UARTS=2
-CONFIG_LEGACY_PTY_COUNT=16
-CONFIG_I2C=y
-CONFIG_I2C_CHARDEV=y
-CONFIG_I2C_MV64XXX=y
-CONFIG_SPI=y
-# CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_USB=y
-CONFIG_USB_DEVICEFS=y
-CONFIG_USB_PRINTER=y
-CONFIG_USB_STORAGE=y
-CONFIG_USB_STORAGE_DATAFAB=y
-CONFIG_USB_STORAGE_FREECOM=y
-CONFIG_USB_STORAGE_SDDR09=y
-CONFIG_USB_STORAGE_SDDR55=y
-CONFIG_USB_STORAGE_JUMPSHOT=y
-CONFIG_NEW_LEDS=y
-CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_FS_XATTR is not set
-CONFIG_XFS_FS=y
-CONFIG_INOTIFY=y
-CONFIG_ISO9660_FS=y
-CONFIG_UDF_FS=m
-CONFIG_MSDOS_FS=y
-CONFIG_VFAT_FS=y
-CONFIG_TMPFS=y
-CONFIG_JFFS2_FS=y
-CONFIG_CRAMFS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
-CONFIG_ROOT_NFS=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_BSD_DISKLABEL=y
-CONFIG_MINIX_SUBPARTITION=y
-CONFIG_SOLARIS_X86_PARTITION=y
-CONFIG_UNIXWARE_DISKLABEL=y
-CONFIG_LDM_PARTITION=y
-CONFIG_LDM_DEBUG=y
-CONFIG_SUN_PARTITION=y
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_CODEPAGE_850=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_NLS_ISO8859_2=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_SYSCTL_SYSCALL_CHECK=y
-CONFIG_DEBUG_USER=y
-CONFIG_CRYPTO_CBC=m
-CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_PCBC=m
-CONFIG_CRC_CCITT=y
-CONFIG_CRC16=y
-CONFIG_LIBCRC32C=y
diff --git a/arch/arm/mach-loki/Kconfig b/arch/arm/mach-loki/Kconfig
deleted file mode 100644
index 0045bdd..0000000
--- a/arch/arm/mach-loki/Kconfig
+++ /dev/null
@@ -1,13 +0,0 @@
-if ARCH_LOKI
-
-menu "Marvell Loki (88RC8480) Implementations"
-
-config MACH_LB88RC8480
-	bool "Marvell LB88RC8480 Development Board"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Marvell LB88RC8480 Development Board.
-
-endmenu
-
-endif
diff --git a/arch/arm/mach-loki/Makefile b/arch/arm/mach-loki/Makefile
deleted file mode 100644
index d43233e..0000000
--- a/arch/arm/mach-loki/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-y				+= common.o addr-map.o irq.o
-
-obj-$(CONFIG_MACH_LB88RC8480)	+= lb88rc8480-setup.o
diff --git a/arch/arm/mach-loki/Makefile.boot b/arch/arm/mach-loki/Makefile.boot
deleted file mode 100644
index 67039c3..0000000
--- a/arch/arm/mach-loki/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-   zreladdr-y	:= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-loki/addr-map.c b/arch/arm/mach-loki/addr-map.c
deleted file mode 100644
index b9537c9..0000000
--- a/arch/arm/mach-loki/addr-map.c
+++ /dev/null
@@ -1,122 +0,0 @@
-/*
- * arch/arm/mach-loki/addr-map.c
- *
- * Address map functions for Marvell Loki (88RC8480) SoCs
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/mbus.h>
-#include <linux/io.h>
-#include <mach/hardware.h>
-#include "common.h"
-
-/*
- * Generic Address Decode Windows bit settings
- */
-#define TARGET_DDR		0
-#define TARGET_DEV_BUS		1
-#define TARGET_PCIE0		3
-#define TARGET_PCIE1		4
-#define ATTR_DEV_BOOT		0x0f
-#define ATTR_DEV_CS2		0x1b
-#define ATTR_DEV_CS1		0x1d
-#define ATTR_DEV_CS0		0x1e
-#define ATTR_PCIE_IO		0x51
-#define ATTR_PCIE_MEM		0x59
-
-/*
- * Helpers to get DDR bank info
- */
-#define DDR_SIZE_CS(n)		DDR_REG(0x1500 + ((n) << 3))
-#define DDR_BASE_CS(n)		DDR_REG(0x1504 + ((n) << 3))
-
-/*
- * CPU Address Decode Windows registers
- */
-#define BRIDGE_REG(x)		(BRIDGE_VIRT_BASE | (x))
-#define CPU_WIN_CTRL(n)		BRIDGE_REG(0x000 | ((n) << 4))
-#define CPU_WIN_BASE(n)		BRIDGE_REG(0x004 | ((n) << 4))
-#define CPU_WIN_REMAP_LO(n)	BRIDGE_REG(0x008 | ((n) << 4))
-#define CPU_WIN_REMAP_HI(n)	BRIDGE_REG(0x00c | ((n) << 4))
-
-
-struct mbus_dram_target_info loki_mbus_dram_info;
-
-static void __init setup_cpu_win(int win, u32 base, u32 size,
-				 u8 target, u8 attr, int remap)
-{
-	u32 ctrl;
-
-	base &= 0xffff0000;
-	ctrl = ((size - 1) & 0xffff0000) | (attr << 8) | (1 << 5) | target;
-
-	writel(base, CPU_WIN_BASE(win));
-	writel(ctrl, CPU_WIN_CTRL(win));
-	if (win < 2) {
-		if (remap < 0)
-			remap = base;
-
-		writel(remap & 0xffff0000, CPU_WIN_REMAP_LO(win));
-		writel(0, CPU_WIN_REMAP_HI(win));
-	}
-}
-
-void __init loki_setup_cpu_mbus(void)
-{
-	int i;
-	int cs;
-
-	/*
-	 * First, disable and clear windows.
-	 */
-	for (i = 0; i < 8; i++) {
-		writel(0, CPU_WIN_BASE(i));
-		writel(0, CPU_WIN_CTRL(i));
-		if (i < 2) {
-			writel(0, CPU_WIN_REMAP_LO(i));
-			writel(0, CPU_WIN_REMAP_HI(i));
-		}
-	}
-
-	/*
-	 * Setup windows for PCIe IO+MEM space.
-	 */
-	setup_cpu_win(2, LOKI_PCIE0_MEM_PHYS_BASE, LOKI_PCIE0_MEM_SIZE,
-		      TARGET_PCIE0, ATTR_PCIE_MEM, -1);
-	setup_cpu_win(3, LOKI_PCIE1_MEM_PHYS_BASE, LOKI_PCIE1_MEM_SIZE,
-		      TARGET_PCIE1, ATTR_PCIE_MEM, -1);
-
-	/*
-	 * Setup MBUS dram target info.
-	 */
-	loki_mbus_dram_info.mbus_dram_target_id = TARGET_DDR;
-
-	for (i = 0, cs = 0; i < 4; i++) {
-		u32 base = readl(DDR_BASE_CS(i));
-		u32 size = readl(DDR_SIZE_CS(i));
-
-		/*
-		 * Chip select enabled?
-		 */
-		if (size & 1) {
-			struct mbus_dram_window *w;
-
-			w = &loki_mbus_dram_info.cs[cs++];
-			w->cs_index = i;
-			w->mbus_attr = 0xf & ~(1 << i);
-			w->base = base & 0xffff0000;
-			w->size = (size | 0x0000ffff) + 1;
-		}
-	}
-	loki_mbus_dram_info.num_cs = cs;
-}
-
-void __init loki_setup_dev_boot_win(u32 base, u32 size)
-{
-	setup_cpu_win(4, base, size, TARGET_DEV_BUS, ATTR_DEV_BOOT, -1);
-}
diff --git a/arch/arm/mach-loki/common.c b/arch/arm/mach-loki/common.c
deleted file mode 100644
index 5f02664..0000000
--- a/arch/arm/mach-loki/common.c
+++ /dev/null
@@ -1,162 +0,0 @@
-/*
- * arch/arm/mach-loki/common.c
- *
- * Core functions for Marvell Loki (88RC8480) SoCs
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/serial_8250.h>
-#include <linux/mbus.h>
-#include <linux/dma-mapping.h>
-#include <asm/page.h>
-#include <asm/timex.h>
-#include <asm/mach/map.h>
-#include <asm/mach/time.h>
-#include <mach/bridge-regs.h>
-#include <mach/loki.h>
-#include <plat/orion_nand.h>
-#include <plat/time.h>
-#include <plat/common.h>
-#include "common.h"
-
-/*****************************************************************************
- * I/O Address Mapping
- ****************************************************************************/
-static struct map_desc loki_io_desc[] __initdata = {
-	{
-		.virtual	= LOKI_REGS_VIRT_BASE,
-		.pfn		= __phys_to_pfn(LOKI_REGS_PHYS_BASE),
-		.length		= LOKI_REGS_SIZE,
-		.type		= MT_DEVICE,
-	},
-};
-
-void __init loki_map_io(void)
-{
-	iotable_init(loki_io_desc, ARRAY_SIZE(loki_io_desc));
-}
-
-
-/*****************************************************************************
- * GE00
- ****************************************************************************/
-void __init loki_ge0_init(struct mv643xx_eth_platform_data *eth_data)
-{
-	writel(0x00079220, GE0_VIRT_BASE + 0x20b0);
-
-	orion_ge00_init(eth_data, &loki_mbus_dram_info,
-			GE0_PHYS_BASE, IRQ_LOKI_GBE_A_INT,
-			0, LOKI_TCLK);
-}
-
-
-/*****************************************************************************
- * GE01
- ****************************************************************************/
-void __init loki_ge1_init(struct mv643xx_eth_platform_data *eth_data)
-{
-	writel(0x00079220, GE1_VIRT_BASE + 0x20b0);
-
-	orion_ge01_init(eth_data, &loki_mbus_dram_info,
-			GE1_PHYS_BASE, IRQ_LOKI_GBE_B_INT,
-			0, LOKI_TCLK);
-}
-
-
-/*****************************************************************************
- * SAS/SATA
- ****************************************************************************/
-static struct resource loki_sas_resources[] = {
-	{
-		.name	= "mvsas0 mem",
-		.start	= SAS0_PHYS_BASE,
-		.end	= SAS0_PHYS_BASE + 0x01ff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.name	= "mvsas0 irq",
-		.start	= IRQ_LOKI_SAS_A,
-		.end	= IRQ_LOKI_SAS_A,
-		.flags	= IORESOURCE_IRQ,
-	}, {
-		.name	= "mvsas1 mem",
-		.start	= SAS1_PHYS_BASE,
-		.end	= SAS1_PHYS_BASE + 0x01ff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.name	= "mvsas1 irq",
-		.start	= IRQ_LOKI_SAS_B,
-		.end	= IRQ_LOKI_SAS_B,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device loki_sas = {
-	.name		= "mvsas",
-	.id		= 0,
-	.dev		= {
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(loki_sas_resources),
-	.resource	= loki_sas_resources,
-};
-
-void __init loki_sas_init(void)
-{
-	writel(0x8300f707, DDR_REG(0x1424));
-	platform_device_register(&loki_sas);
-}
-
-
-/*****************************************************************************
- * UART0
- ****************************************************************************/
-void __init loki_uart0_init(void)
-{
-	orion_uart0_init(UART0_VIRT_BASE, UART0_PHYS_BASE,
-			 IRQ_LOKI_UART0, LOKI_TCLK);
-}
-
-/*****************************************************************************
- * UART1
- ****************************************************************************/
-void __init loki_uart1_init(void)
-{
-	orion_uart1_init(UART1_VIRT_BASE, UART1_PHYS_BASE,
-			 IRQ_LOKI_UART1, LOKI_TCLK);
-}
-
-
-/*****************************************************************************
- * Time handling
- ****************************************************************************/
-void __init loki_init_early(void)
-{
-	orion_time_set_base(TIMER_VIRT_BASE);
-}
-
-static void loki_timer_init(void)
-{
-	orion_time_init(BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
-			IRQ_LOKI_BRIDGE, LOKI_TCLK);
-}
-
-struct sys_timer loki_timer = {
-	.init = loki_timer_init,
-};
-
-
-/*****************************************************************************
- * General
- ****************************************************************************/
-void __init loki_init(void)
-{
-	printk(KERN_INFO "Loki ID: 88RC8480. TCLK=%d.\n", LOKI_TCLK);
-
-	loki_setup_cpu_mbus();
-}
diff --git a/arch/arm/mach-loki/common.h b/arch/arm/mach-loki/common.h
deleted file mode 100644
index a315dcf..0000000
--- a/arch/arm/mach-loki/common.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * arch/arm/mach-loki/common.h
- *
- * Core functions for Marvell Loki (88RC8480) SoCs
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ARCH_LOKI_COMMON_H
-#define __ARCH_LOKI_COMMON_H
-
-struct mv643xx_eth_platform_data;
-
-/*
- * Basic Loki init functions used early by machine-setup.
- */
-void loki_map_io(void);
-void loki_init(void);
-void loki_init_early(void);
-void loki_init_irq(void);
-
-extern struct mbus_dram_target_info loki_mbus_dram_info;
-void loki_setup_cpu_mbus(void);
-void loki_setup_dev_boot_win(u32 base, u32 size);
-
-void loki_ge0_init(struct mv643xx_eth_platform_data *eth_data);
-void loki_ge1_init(struct mv643xx_eth_platform_data *eth_data);
-void loki_sas_init(void);
-void loki_uart0_init(void);
-void loki_uart1_init(void);
-
-extern struct sys_timer loki_timer;
-
-
-#endif
diff --git a/arch/arm/mach-loki/include/mach/bridge-regs.h b/arch/arm/mach-loki/include/mach/bridge-regs.h
deleted file mode 100644
index fd87732..0000000
--- a/arch/arm/mach-loki/include/mach/bridge-regs.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * arch/arm/mach-loki/include/mach/bridge-regs.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_BRIDGE_REGS_H
-#define __ASM_ARCH_BRIDGE_REGS_H
-
-#include <mach/loki.h>
-
-#define RSTOUTn_MASK		(BRIDGE_VIRT_BASE | 0x0108)
-#define SOFT_RESET_OUT_EN	0x00000004
-
-#define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE | 0x010c)
-#define SOFT_RESET		0x00000001
-
-#define BRIDGE_INT_TIMER1_CLR	0x0004
-
-#define IRQ_VIRT_BASE		(BRIDGE_VIRT_BASE | 0x0200)
-#define IRQ_CAUSE_OFF		0x0000
-#define IRQ_MASK_OFF		0x0004
-
-#define TIMER_VIRT_BASE		(BRIDGE_VIRT_BASE | 0x0300)
-
-#endif
diff --git a/arch/arm/mach-loki/include/mach/debug-macro.S b/arch/arm/mach-loki/include/mach/debug-macro.S
deleted file mode 100644
index cc90d99..0000000
--- a/arch/arm/mach-loki/include/mach/debug-macro.S
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-loki/include/mach/debug-macro.S
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <mach/loki.h>
-
-	.macro	addruart, rp, rv
-	ldr	\rp, =LOKI_REGS_PHYS_BASE
-	ldr	\rv, =LOKI_REGS_VIRT_BASE
-	orr	\rp, \rp, #0x00012000
-	orr	\rv, \rv, #0x00012000
-	.endm
-
-#define UART_SHIFT	2
-#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-loki/include/mach/entry-macro.S b/arch/arm/mach-loki/include/mach/entry-macro.S
deleted file mode 100644
index bc917ed..0000000
--- a/arch/arm/mach-loki/include/mach/entry-macro.S
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * arch/arm/mach-loki/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for Marvell Loki (88RC8480) platforms
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <mach/bridge-regs.h>
-
-	.macro  disable_fiq
-	.endm
-
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
-	.macro  get_irqnr_preamble, base, tmp
-	ldr	\base, =IRQ_VIRT_BASE
-	.endm
-
-	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-	ldr	\irqstat, [\base, #IRQ_CAUSE_OFF]
-	ldr	\tmp, [\base, #IRQ_MASK_OFF]
-	mov	\irqnr, #0
-	ands	\irqstat, \irqstat, \tmp
-	clzne	\irqnr, \irqstat
-	rsbne	\irqnr, \irqnr, #31
-	.endm
diff --git a/arch/arm/mach-loki/include/mach/hardware.h b/arch/arm/mach-loki/include/mach/hardware.h
deleted file mode 100644
index d7bfc8f..0000000
--- a/arch/arm/mach-loki/include/mach/hardware.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * arch/arm/mach-loki/include/mach/hardware.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H
-
-#include "loki.h"
-
-
-#endif
diff --git a/arch/arm/mach-loki/include/mach/io.h b/arch/arm/mach-loki/include/mach/io.h
deleted file mode 100644
index a373cd5..0000000
--- a/arch/arm/mach-loki/include/mach/io.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * arch/arm/mach-loki/include/mach/io.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_IO_H
-#define __ASM_ARCH_IO_H
-
-#include "loki.h"
-
-#define IO_SPACE_LIMIT		0xffffffff
-
-static inline void __iomem *__io(unsigned long addr)
-{
-	return (void __iomem *)((addr - LOKI_PCIE0_IO_PHYS_BASE)
-					+ LOKI_PCIE0_IO_VIRT_BASE);
-}
-
-#define __io(a)			__io(a)
-#define __mem_pci(a)		(a)
-
-
-#endif
diff --git a/arch/arm/mach-loki/include/mach/irqs.h b/arch/arm/mach-loki/include/mach/irqs.h
deleted file mode 100644
index 9fbd332..0000000
--- a/arch/arm/mach-loki/include/mach/irqs.h
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- * arch/arm/mach-loki/include/mach/irqs.h
- *
- * IRQ definitions for Marvell Loki (88RC8480) SoCs
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_IRQS_H
-#define __ASM_ARCH_IRQS_H
-
-#include "loki.h"	/* need GPIO_MAX */
-
-/*
- * Interrupt Controller
- */
-#define IRQ_LOKI_PCIE_A_CPU_DRBL	0
-#define IRQ_LOKI_CPU_PCIE_A_DRBL	1
-#define IRQ_LOKI_PCIE_B_CPU_DRBL	2
-#define IRQ_LOKI_CPU_PCIE_B_DRBL	3
-#define IRQ_LOKI_COM_A_ERR		6
-#define IRQ_LOKI_COM_A_IN		7
-#define IRQ_LOKI_COM_A_OUT		8
-#define IRQ_LOKI_COM_B_ERR		9
-#define IRQ_LOKI_COM_B_IN		10
-#define IRQ_LOKI_COM_B_OUT		11
-#define IRQ_LOKI_DMA_A			12
-#define IRQ_LOKI_DMA_B			13
-#define IRQ_LOKI_SAS_A			14
-#define IRQ_LOKI_SAS_B			15
-#define IRQ_LOKI_DDR			16
-#define IRQ_LOKI_XOR			17
-#define IRQ_LOKI_BRIDGE			18
-#define IRQ_LOKI_PCIE_A_ERR		20
-#define IRQ_LOKI_PCIE_A_INT		21
-#define IRQ_LOKI_PCIE_B_ERR		22
-#define IRQ_LOKI_PCIE_B_INT		23
-#define IRQ_LOKI_GBE_A_INT		24
-#define IRQ_LOKI_GBE_B_INT		25
-#define IRQ_LOKI_DEV_ERR		26
-#define IRQ_LOKI_UART0			27
-#define IRQ_LOKI_UART1			28
-#define IRQ_LOKI_TWSI			29
-#define IRQ_LOKI_GPIO_23_0		30
-#define IRQ_LOKI_GPIO_25_24		31
-
-/*
- * Loki General Purpose Pins
- */
-#define IRQ_LOKI_GPIO_START	32
-#define NR_GPIO_IRQS		GPIO_MAX
-
-#define NR_IRQS			(IRQ_LOKI_GPIO_START + NR_GPIO_IRQS)
-
-
-#endif
diff --git a/arch/arm/mach-loki/include/mach/loki.h b/arch/arm/mach-loki/include/mach/loki.h
deleted file mode 100644
index bfca7c2..0000000
--- a/arch/arm/mach-loki/include/mach/loki.h
+++ /dev/null
@@ -1,83 +0,0 @@
-/*
- * arch/arm/mach-loki/include/mach/loki.h
- *
- * Generic definitions for Marvell Loki (88RC8480) SoC flavors
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_LOKI_H
-#define __ASM_ARCH_LOKI_H
-
-/*
- * Marvell Loki (88RC8480) address maps.
- *
- * phys
- * d0000000	on-chip peripheral registers
- * e0000000	PCIe 0 Memory space
- * e8000000	PCIe 1 Memory space
- * f0000000	PCIe 0 I/O space
- * f0100000	PCIe 1 I/O space
- *
- * virt		phys		size
- * fed00000	d0000000	1M	on-chip peripheral registers
- * fee00000	f0000000	64K	PCIe 0 I/O space
- * fef00000	f0100000	64K	PCIe 1 I/O space
- */
-
-#define LOKI_REGS_PHYS_BASE		0xd0000000
-#define LOKI_REGS_VIRT_BASE		0xfed00000
-#define LOKI_REGS_SIZE			SZ_1M
-
-#define LOKI_PCIE0_IO_PHYS_BASE		0xf0000000
-#define LOKI_PCIE0_IO_VIRT_BASE		0xfee00000
-#define LOKI_PCIE0_IO_BUS_BASE		0x00000000
-#define LOKI_PCIE0_IO_SIZE		SZ_64K
-
-#define LOKI_PCIE1_IO_PHYS_BASE		0xf0100000
-#define LOKI_PCIE1_IO_VIRT_BASE		0xfef00000
-#define LOKI_PCIE1_IO_BUS_BASE		0x00000000
-#define LOKI_PCIE1_IO_SIZE		SZ_64K
-
-#define LOKI_PCIE0_MEM_PHYS_BASE	0xe0000000
-#define LOKI_PCIE0_MEM_SIZE		SZ_128M
-
-#define LOKI_PCIE1_MEM_PHYS_BASE	0xe8000000
-#define LOKI_PCIE1_MEM_SIZE		SZ_128M
-
-/*
- * Register Map
- */
-#define DEV_BUS_PHYS_BASE	(LOKI_REGS_PHYS_BASE | 0x10000)
-#define DEV_BUS_VIRT_BASE	(LOKI_REGS_VIRT_BASE | 0x10000)
-#define  UART0_PHYS_BASE	(DEV_BUS_PHYS_BASE | 0x2000)
-#define  UART0_VIRT_BASE	(DEV_BUS_VIRT_BASE | 0x2000)
-#define  UART1_PHYS_BASE	(DEV_BUS_PHYS_BASE | 0x2100)
-#define  UART1_VIRT_BASE	(DEV_BUS_VIRT_BASE | 0x2100)
-
-#define BRIDGE_VIRT_BASE	(LOKI_REGS_VIRT_BASE | 0x20000)
-
-#define PCIE0_VIRT_BASE		(LOKI_REGS_VIRT_BASE | 0x30000)
-
-#define PCIE1_VIRT_BASE		(LOKI_REGS_VIRT_BASE | 0x40000)
-
-#define SAS0_PHYS_BASE		(LOKI_REGS_PHYS_BASE | 0x80000)
-
-#define SAS1_PHYS_BASE		(LOKI_REGS_PHYS_BASE | 0x90000)
-
-#define GE0_PHYS_BASE		(LOKI_REGS_PHYS_BASE | 0xa0000)
-#define GE0_VIRT_BASE		(LOKI_REGS_VIRT_BASE | 0xa0000)
-
-#define GE1_PHYS_BASE		(LOKI_REGS_PHYS_BASE | 0xb0000)
-#define GE1_VIRT_BASE		(LOKI_REGS_VIRT_BASE | 0xb0000)
-
-#define DDR_VIRT_BASE		(LOKI_REGS_VIRT_BASE | 0xf0000)
-#define DDR_REG(x)		(DDR_VIRT_BASE | (x))
-
-
-#define GPIO_MAX		8
-
-
-#endif
diff --git a/arch/arm/mach-loki/include/mach/system.h b/arch/arm/mach-loki/include/mach/system.h
deleted file mode 100644
index 7189519..0000000
--- a/arch/arm/mach-loki/include/mach/system.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * arch/arm/mach-loki/include/mach/system.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-#include <mach/bridge-regs.h>
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-	/*
-	 * Enable soft reset to assert RSTOUTn.
-	 */
-	writel(SOFT_RESET_OUT_EN, RSTOUTn_MASK);
-
-	/*
-	 * Assert soft reset.
-	 */
-	writel(SOFT_RESET, SYSTEM_SOFT_RESET);
-
-	while (1)
-		;
-}
-
-
-#endif
diff --git a/arch/arm/mach-loki/include/mach/timex.h b/arch/arm/mach-loki/include/mach/timex.h
deleted file mode 100644
index 9df2109..0000000
--- a/arch/arm/mach-loki/include/mach/timex.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * arch/arm/mach-loki/include/mach/timex.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#define CLOCK_TICK_RATE		(100 * HZ)
-
-#define LOKI_TCLK		180000000
diff --git a/arch/arm/mach-loki/include/mach/uncompress.h b/arch/arm/mach-loki/include/mach/uncompress.h
deleted file mode 100644
index 90b2a7e..0000000
--- a/arch/arm/mach-loki/include/mach/uncompress.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * arch/arm/mach-loki/include/mach/uncompress.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/serial_reg.h>
-#include <mach/loki.h>
-
-#define SERIAL_BASE	((unsigned char *)UART0_PHYS_BASE)
-
-static void putc(const char c)
-{
-	unsigned char *base = SERIAL_BASE;
-	int i;
-
-	for (i = 0; i < 0x1000; i++) {
-		if (base[UART_LSR << 2] & UART_LSR_THRE)
-			break;
-		barrier();
-	}
-
-	base[UART_TX << 2] = c;
-}
-
-static void flush(void)
-{
-	unsigned char *base = SERIAL_BASE;
-	unsigned char mask;
-	int i;
-
-	mask = UART_LSR_TEMT | UART_LSR_THRE;
-
-	for (i = 0; i < 0x1000; i++) {
-		if ((base[UART_LSR << 2] & mask) == mask)
-			break;
-		barrier();
-	}
-}
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-loki/include/mach/vmalloc.h b/arch/arm/mach-loki/include/mach/vmalloc.h
deleted file mode 100644
index 5dcbd86..0000000
--- a/arch/arm/mach-loki/include/mach/vmalloc.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/*
- * arch/arm/mach-loki/include/mach/vmalloc.h
- */
-
-#define VMALLOC_END	0xfe800000UL
diff --git a/arch/arm/mach-loki/irq.c b/arch/arm/mach-loki/irq.c
deleted file mode 100644
index 76b211b..0000000
--- a/arch/arm/mach-loki/irq.c
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * arch/arm/mach-loki/irq.c
- *
- * Marvell Loki (88RC8480) IRQ handling.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-#include <mach/bridge-regs.h>
-#include <plat/irq.h>
-#include "common.h"
-
-void __init loki_init_irq(void)
-{
-	orion_irq_init(0, (void __iomem *)(IRQ_VIRT_BASE + IRQ_MASK_OFF));
-}
diff --git a/arch/arm/mach-loki/lb88rc8480-setup.c b/arch/arm/mach-loki/lb88rc8480-setup.c
deleted file mode 100644
index cd4fa76..0000000
--- a/arch/arm/mach-loki/lb88rc8480-setup.c
+++ /dev/null
@@ -1,99 +0,0 @@
-/*
- * arch/arm/mach-loki/lb88rc8480-setup.c
- *
- * Marvell LB88RC8480 Development Board Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/irq.h>
-#include <linux/mtd/physmap.h>
-#include <linux/mtd/nand.h>
-#include <linux/timer.h>
-#include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <mach/loki.h>
-#include "common.h"
-
-#define LB88RC8480_FLASH_BOOT_CS_BASE	0xf8000000
-#define LB88RC8480_FLASH_BOOT_CS_SIZE	SZ_128M
-
-#define LB88RC8480_NOR_BOOT_BASE	0xff000000
-#define LB88RC8480_NOR_BOOT_SIZE	SZ_16M
-
-static struct mtd_partition lb88rc8480_boot_flash_parts[] = {
-	{
-		.name	= "kernel",
-		.offset	= 0,
-		.size	= SZ_2M,
-	}, {
-		.name	= "root-fs",
-		.offset	= SZ_2M,
-		.size	= (SZ_8M + SZ_4M + SZ_1M),
-	}, {
-		.name	= "u-boot",
-		.offset	= (SZ_8M + SZ_4M + SZ_2M + SZ_1M),
-		.size	= SZ_1M,
-	},
-};
-
-static struct physmap_flash_data lb88rc8480_boot_flash_data = {
-	.parts		= lb88rc8480_boot_flash_parts,
-	.nr_parts	= ARRAY_SIZE(lb88rc8480_boot_flash_parts),
-	.width		= 1,	/* 8 bit bus width */
-};
-
-static struct resource lb88rc8480_boot_flash_resource = {
-	.flags	= IORESOURCE_MEM,
-	.start	= LB88RC8480_NOR_BOOT_BASE,
-	.end	= LB88RC8480_NOR_BOOT_BASE + LB88RC8480_NOR_BOOT_SIZE - 1,
-};
-
-static struct platform_device lb88rc8480_boot_flash = {
-	.name	= "physmap-flash",
-	.id	= 0,
-	.dev	= {
-		.platform_data	= &lb88rc8480_boot_flash_data,
-	},
-	.num_resources	= 1,
-	.resource	= &lb88rc8480_boot_flash_resource,
-};
-
-static struct mv643xx_eth_platform_data lb88rc8480_ge0_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(1),
-	.mac_addr	= { 0x00, 0x50, 0x43, 0x11, 0x22, 0x33 },
-};
-
-static void __init lb88rc8480_init(void)
-{
-	/*
-	 * Basic setup. Needs to be called early.
-	 */
-	loki_init();
-
-	loki_ge0_init(&lb88rc8480_ge0_data);
-	loki_sas_init();
-	loki_uart0_init();
-	loki_uart1_init();
-
-	loki_setup_dev_boot_win(LB88RC8480_FLASH_BOOT_CS_BASE,
-				LB88RC8480_FLASH_BOOT_CS_SIZE);
-	platform_device_register(&lb88rc8480_boot_flash);
-}
-
-MACHINE_START(LB88RC8480, "Marvell LB88RC8480 Development Board")
-	/* Maintainer: Ke Wei <kewei@marvell.com> */
-	.atag_offset	= 0x100,
-	.init_machine	= lb88rc8480_init,
-	.map_io		= loki_map_io,
-	.init_early	= loki_init_early,
-	.init_irq	= loki_init_irq,
-	.timer		= &loki_timer,
-MACHINE_END
