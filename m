From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:58:01 +0900
Subject: [PATCH 09/13] ARM: shmobile: r8a73a4: ape6evm: Remove legacy platform
In-Reply-To: <cover.1425517246.git.horms+renesas@verge.net.au>
References: <cover.1425517246.git.horms+renesas@verge.net.au>
Message-ID: <9d07d414d4c33d862fc41e22c473a662996b0f4e.1425517246.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the remains of the legacy ape6evm platform.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 MAINTAINERS                            |   1 -
 arch/arm/boot/dts/Makefile             |   1 -
 arch/arm/configs/ape6evm_defconfig     | 109 ------------
 arch/arm/mach-shmobile/Kconfig         |  13 --
 arch/arm/mach-shmobile/Makefile        |   1 -
 arch/arm/mach-shmobile/Makefile.boot   |   1 -
 arch/arm/mach-shmobile/board-ape6evm.c | 306 ---------------------------------
 7 files changed, 432 deletions(-)
 delete mode 100644 arch/arm/configs/ape6evm_defconfig
 delete mode 100644 arch/arm/mach-shmobile/board-ape6evm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ddc5a8c..5181e7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1414,7 +1414,6 @@ F:	arch/arm/boot/dts/emev2*
 F:	arch/arm/boot/dts/r7s*
 F:	arch/arm/boot/dts/r8a*
 F:	arch/arm/boot/dts/sh*
-F:	arch/arm/configs/ape6evm_defconfig
 F:	arch/arm/configs/armadillo800eva_defconfig
 F:	arch/arm/configs/bockw_defconfig
 F:	arch/arm/configs/kzm9g_defconfig
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d3e6cf3..3dbd553 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -464,7 +464,6 @@ dtb-$(CONFIG_ARCH_S5PV210) += \
 	s5pv210-smdkv210.dtb \
 	s5pv210-torbreck.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
-	r8a73a4-ape6evm.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
 	r8a7778-bockw-reference.dtb \
diff --git a/arch/arm/configs/ape6evm_defconfig b/arch/arm/configs/ape6evm_defconfig
deleted file mode 100644
index 9e9a72e..0000000
--- a/arch/arm/configs/ape6evm_defconfig
+++ /dev/null
@@ -1,109 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_LOG_BUF_SHIFT=16
-CONFIG_CGROUPS=y
-CONFIG_CGROUP_SCHED=y
-CONFIG_KALLSYMS_ALL=y
-CONFIG_EMBEDDED=y
-CONFIG_PERF_EVENTS=y
-CONFIG_SLAB=y
-CONFIG_ARCH_SHMOBILE_LEGACY=y
-CONFIG_ARCH_R8A73A4=y
-CONFIG_MACH_APE6EVM=y
-# CONFIG_ARM_THUMB is not set
-CONFIG_CPU_BPREDICT_DISABLE=y
-CONFIG_PL310_ERRATA_588369=y
-CONFIG_ARM_ERRATA_754322=y
-CONFIG_SMP=y
-CONFIG_SCHED_MC=y
-CONFIG_HAVE_ARM_ARCH_TIMER=y
-CONFIG_NR_CPUS=8
-CONFIG_AEABI=y
-CONFIG_HIGHMEM=y
-CONFIG_HIGHPTE=y
-# CONFIG_HW_PERF_EVENTS is not set
-# CONFIG_COMPACTION is not set
-# CONFIG_CROSS_MEMORY_ATTACH is not set
-CONFIG_ARM_APPENDED_DTB=y
-CONFIG_VFP=y
-CONFIG_NEON=y
-CONFIG_BINFMT_MISC=y
-CONFIG_PM=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_XFRM_USER=y
-CONFIG_NET_KEY=y
-CONFIG_NET_KEY_MIGRATE=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_LRO is not set
-# CONFIG_IPV6_SIT is not set
-CONFIG_NETFILTER=y
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_DEVTMPFS=y
-CONFIG_DEVTMPFS_MOUNT=y
-# CONFIG_FW_LOADER_USER_HELPER is not set
-CONFIG_NETDEVICES=y
-# CONFIG_NET_CADENCE is not set
-CONFIG_SMC91X=y
-CONFIG_SMSC911X=y
-# CONFIG_INPUT_MOUSEDEV is not set
-CONFIG_INPUT_EVDEV=y
-CONFIG_KEYBOARD_GPIO=y
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-CONFIG_SERIAL_NONSTANDARD=y
-CONFIG_SERIAL_SH_SCI=y
-CONFIG_SERIAL_SH_SCI_NR_UARTS=12
-CONFIG_SERIAL_SH_SCI_CONSOLE=y
-CONFIG_I2C=y
-CONFIG_I2C_SH_MOBILE=y
-CONFIG_GPIO_SH_PFC=y
-CONFIG_GPIOLIB=y
-# CONFIG_HWMON is not set
-CONFIG_THERMAL=y
-CONFIG_RCAR_THERMAL=y
-CONFIG_REGULATOR=y
-CONFIG_REGULATOR_FIXED_VOLTAGE=y
-CONFIG_REGULATOR_GPIO=y
-CONFIG_REGULATOR_MAX8973=y
-# CONFIG_HID is not set
-# CONFIG_USB_SUPPORT is not set
-CONFIG_MMC=y
-CONFIG_MMC_SDHI=y
-CONFIG_MMC_SH_MMCIF=y
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=y
-CONFIG_LEDS_GPIO=y
-CONFIG_DMADEVICES=y
-CONFIG_SH_DMAE=y
-# CONFIG_IOMMU_SUPPORT is not set
-# CONFIG_DNOTIFY is not set
-CONFIG_TMPFS=y
-# CONFIG_MISC_FILESYSTEMS is not set
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3_ACL=y
-CONFIG_NFS_V4=y
-CONFIG_NFS_V4_1=y
-CONFIG_ROOT_NFS=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_ENABLE_DEFAULT_TRACERS=y
-CONFIG_CRYPTO_CBC=y
-CONFIG_CRYPTO_ECB=y
-CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_MICHAEL_MIC=y
-CONFIG_CRYPTO_TWOFISH=y
-CONFIG_CRC_CCITT=y
-CONFIG_CRC16=y
-CONFIG_CRC_T10DIF=y
-CONFIG_CRC_ITU_T=y
-CONFIG_CRC7=y
-CONFIG_LIBCRC32C=y
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index f8977e7..5fc4756 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -108,13 +108,6 @@ config ARCH_SH73A0
 	select SH_INTC
 	select RENESAS_INTC_IRQPIN
 
-config ARCH_R8A73A4
-	bool "R-Mobile APE6 (R8A73A40)"
-	select ARCH_RMOBILE
-	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select ARM_GIC
-	select RENESAS_IRQC
-
 config ARCH_R8A7740
 	bool "R-Mobile A1 (R8A77400)"
 	select ARCH_RMOBILE
@@ -136,12 +129,6 @@ config ARCH_R8A7779
 
 comment "Renesas ARM SoCs Board Type"
 
-config MACH_APE6EVM
-	bool "APE6EVM board"
-	depends on ARCH_R8A73A4
-	select SMSC_PHY if SMSC911X
-	select USE_OF
-
 config MACH_MACKEREL
 	bool "mackerel board"
 	depends on ARCH_SH7372
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 40f82ee..963d985 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -58,7 +58,6 @@ obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o sleep-sh7372.o
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen-reference.o
 else
-obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
 obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
 obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.o
 obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index e67a6c9..d893aa4 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -1,6 +1,5 @@
 # per-board load address for uImage
 loadaddr-y	:=
-loadaddr-$(CONFIG_MACH_APE6EVM) += 0x40008000
 loadaddr-$(CONFIG_MACH_ARMADILLO800EVA) += 0x40008000
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
 loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
deleted file mode 100644
index 444f22d..0000000
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ /dev/null
@@ -1,306 +0,0 @@
-/*
- * APE6EVM board support
- *
- * Copyright (C) 2013  Renesas Solutions Corp.
- * Copyright (C) 2013  Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/gpio.h>
-#include <linux/gpio_keys.h>
-#include <linux/input.h>
-#include <linux/interrupt.h>
-#include <linux/irqchip.h>
-#include <linux/irqchip/arm-gic.h>
-#include <linux/kernel.h>
-#include <linux/mfd/tmio.h>
-#include <linux/mmc/host.h>
-#include <linux/mmc/sh_mmcif.h>
-#include <linux/mmc/sh_mobile_sdhi.h>
-#include <linux/pinctrl/machine.h>
-#include <linux/platform_device.h>
-#include <linux/regulator/fixed.h>
-#include <linux/regulator/machine.h>
-#include <linux/sh_clk.h>
-#include <linux/smsc911x.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-
-#include "common.h"
-#include "irqs.h"
-#include "r8a73a4.h"
-
-/* LEDS */
-static struct gpio_led ape6evm_leds[] = {
-	{
-		.name		= "gnss-en",
-		.gpio		= 28,
-		.default_state	= LEDS_GPIO_DEFSTATE_OFF,
-	}, {
-		.name		= "nfc-nrst",
-		.gpio		= 126,
-		.default_state	= LEDS_GPIO_DEFSTATE_OFF,
-	}, {
-		.name		= "gnss-nrst",
-		.gpio		= 132,
-		.default_state	= LEDS_GPIO_DEFSTATE_OFF,
-	}, {
-		.name		= "bt-wakeup",
-		.gpio		= 232,
-		.default_state	= LEDS_GPIO_DEFSTATE_OFF,
-	}, {
-		.name		= "strobe",
-		.gpio		= 250,
-		.default_state	= LEDS_GPIO_DEFSTATE_OFF,
-	}, {
-		.name		= "bbresetout",
-		.gpio		= 288,
-		.default_state	= LEDS_GPIO_DEFSTATE_OFF,
-	},
-};
-
-static __initdata struct gpio_led_platform_data ape6evm_leds_pdata = {
-	.leds		= ape6evm_leds,
-	.num_leds	= ARRAY_SIZE(ape6evm_leds),
-};
-
-/* GPIO KEY */
-#define GPIO_KEY(c, g, d, ...) \
-	{ .code = c, .gpio = g, .desc = d, .active_low = 1 }
-
-static struct gpio_keys_button gpio_buttons[] = {
-	GPIO_KEY(KEY_0,			324,	"S16"),
-	GPIO_KEY(KEY_MENU,		325,	"S17"),
-	GPIO_KEY(KEY_HOME,		326,	"S18"),
-	GPIO_KEY(KEY_BACK,		327,	"S19"),
-	GPIO_KEY(KEY_VOLUMEUP,		328,	"S20"),
-	GPIO_KEY(KEY_VOLUMEDOWN,	329,	"S21"),
-};
-
-static struct gpio_keys_platform_data ape6evm_keys_pdata __initdata = {
-	.buttons	= gpio_buttons,
-	.nbuttons	= ARRAY_SIZE(gpio_buttons),
-};
-
-/* Dummy supplies, where voltage doesn't matter */
-static struct regulator_consumer_supply dummy_supplies[] = {
-	REGULATOR_SUPPLY("vddvario", "smsc911x"),
-	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
-};
-
-/* SMSC LAN9220 */
-static const struct resource lan9220_res[] __initconst = {
-	DEFINE_RES_MEM(0x08000000, 0x1000),
-	{
-		.start	= irq_pin(40), /* IRQ40 */
-		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_HIGH,
-	},
-};
-
-static const struct smsc911x_platform_config lan9220_data __initconst = {
-	.flags		= SMSC911X_USE_32BIT,
-	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
-	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_HIGH,
-};
-
-/*
- * MMC0 power supplies:
- * Both Vcc and VccQ to eMMC on APE6EVM are supplied by a tps80032 voltage
- * regulator. Until support for it is added to this file we simulate the
- * Vcc supply by a fixed always-on regulator
- */
-static struct regulator_consumer_supply vcc_mmc0_consumers[] =
-{
-	REGULATOR_SUPPLY("vmmc", "sh_mmcif.0"),
-};
-
-/*
- * SDHI0 power supplies:
- * Vcc to SDHI0 on APE6EVM is supplied by a GPIO-switchable regulator. VccQ is
- * provided by the same tps80032 regulator as both MMC0 voltages - see comment
- * above
- */
-static struct regulator_consumer_supply vcc_sdhi0_consumers[] =
-{
-	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
-};
-
-static struct regulator_init_data vcc_sdhi0_init_data = {
-	.constraints = {
-		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies  = ARRAY_SIZE(vcc_sdhi0_consumers),
-	.consumer_supplies      = vcc_sdhi0_consumers,
-};
-
-static const struct fixed_voltage_config vcc_sdhi0_info __initconst = {
-	.supply_name = "SDHI0 Vcc",
-	.microvolts = 3300000,
-	.gpio = 76,
-	.enable_high = 1,
-	.init_data = &vcc_sdhi0_init_data,
-};
-
-/*
- * SDHI1 power supplies:
- * Vcc and VccQ to SDHI1 on APE6EVM are both fixed at 3.3V
- */
-static struct regulator_consumer_supply vcc_sdhi1_consumers[] =
-{
-	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.1"),
-};
-
-/* MMCIF */
-static const struct sh_mmcif_plat_data mmcif0_pdata __initconst = {
-	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
-	.slave_id_tx	= SHDMA_SLAVE_MMCIF0_TX,
-	.slave_id_rx	= SHDMA_SLAVE_MMCIF0_RX,
-	.ccs_unsupported = true,
-};
-
-static const struct resource mmcif0_resources[] __initconst = {
-	DEFINE_RES_MEM(0xee200000, 0x100),
-	DEFINE_RES_IRQ(gic_spi(169)),
-};
-
-/* SDHI0 */
-static const struct sh_mobile_sdhi_info sdhi0_pdata __initconst = {
-	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE,
-	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
-};
-
-static const struct resource sdhi0_resources[] __initconst = {
-	DEFINE_RES_MEM(0xee100000, 0x100),
-	DEFINE_RES_IRQ(gic_spi(165)),
-};
-
-/* SDHI1 */
-static const struct sh_mobile_sdhi_info sdhi1_pdata __initconst = {
-	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE,
-	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
-			  MMC_CAP_NEEDS_POLL,
-};
-
-static const struct resource sdhi1_resources[] __initconst = {
-	DEFINE_RES_MEM(0xee120000, 0x100),
-	DEFINE_RES_IRQ(gic_spi(166)),
-};
-
-static const struct pinctrl_map ape6evm_pinctrl_map[] __initconst = {
-	/* SCIFA0 console */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a73a4",
-				  "scifa0_data", "scifa0"),
-	/* SMSC */
-	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-r8a73a4",
-				  "irqc_irq40", "irqc"),
-	/* MMCIF0 */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-r8a73a4",
-				  "mmc0_data8", "mmc0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-r8a73a4",
-				  "mmc0_ctrl", "mmc0"),
-	/* SDHI0: uSD: no WP */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a73a4",
-				  "sdhi0_data4", "sdhi0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a73a4",
-				  "sdhi0_ctrl", "sdhi0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a73a4",
-				  "sdhi0_cd", "sdhi0"),
-	/* SDHI1 */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-r8a73a4",
-				  "sdhi1_data4", "sdhi1"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-r8a73a4",
-				  "sdhi1_ctrl", "sdhi1"),
-};
-
-static void __init ape6evm_add_standard_devices(void)
-{
-
-	struct clk *parent;
-	struct clk *mp;
-
-	r8a73a4_clock_init();
-
-	/* MP clock parent = extal2 */
-	parent      = clk_get(NULL, "extal2");
-	mp          = clk_get(NULL, "mp");
-	BUG_ON(IS_ERR(parent) || IS_ERR(mp));
-
-	clk_set_parent(mp, parent);
-	clk_put(parent);
-	clk_put(mp);
-
-	pinctrl_register_mappings(ape6evm_pinctrl_map,
-				  ARRAY_SIZE(ape6evm_pinctrl_map));
-	r8a73a4_pinmux_init();
-	r8a73a4_add_standard_devices();
-
-	/* LAN9220 ethernet */
-	gpio_request_one(270, GPIOF_OUT_INIT_HIGH, NULL); /* smsc9220 RESET */
-
-	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
-
-	platform_device_register_resndata(NULL, "smsc911x", -1,
-					  lan9220_res, ARRAY_SIZE(lan9220_res),
-					  &lan9220_data, sizeof(lan9220_data));
-
-	regulator_register_always_on(1, "MMC0 Vcc", vcc_mmc0_consumers,
-				     ARRAY_SIZE(vcc_mmc0_consumers), 2800000);
-	platform_device_register_resndata(NULL, "sh_mmcif", 0,
-					  mmcif0_resources, ARRAY_SIZE(mmcif0_resources),
-					  &mmcif0_pdata, sizeof(mmcif0_pdata));
-	platform_device_register_data(NULL, "reg-fixed-voltage", 2,
-				      &vcc_sdhi0_info, sizeof(vcc_sdhi0_info));
-	platform_device_register_resndata(NULL, "sh_mobile_sdhi", 0,
-					  sdhi0_resources, ARRAY_SIZE(sdhi0_resources),
-					  &sdhi0_pdata, sizeof(sdhi0_pdata));
-	regulator_register_always_on(3, "SDHI1 Vcc", vcc_sdhi1_consumers,
-				     ARRAY_SIZE(vcc_sdhi1_consumers), 3300000);
-	platform_device_register_resndata(NULL, "sh_mobile_sdhi", 1,
-					  sdhi1_resources, ARRAY_SIZE(sdhi1_resources),
-					  &sdhi1_pdata, sizeof(sdhi1_pdata));
-	platform_device_register_data(NULL, "gpio-keys", -1,
-				      &ape6evm_keys_pdata,
-				      sizeof(ape6evm_keys_pdata));
-	platform_device_register_data(NULL, "leds-gpio", -1,
-				      &ape6evm_leds_pdata,
-				      sizeof(ape6evm_leds_pdata));
-}
-
-static void __init ape6evm_legacy_init_time(void)
-{
-	/* Do not invoke DT-based timers via clocksource_of_init() */
-}
-
-static void __init ape6evm_legacy_init_irq(void)
-{
-	void __iomem *gic_dist_base = ioremap_nocache(0xf1001000, 0x1000);
-	void __iomem *gic_cpu_base = ioremap_nocache(0xf1002000, 0x1000);
-
-	gic_init(0, 29, gic_dist_base, gic_cpu_base);
-
-	/* Do not invoke DT-based interrupt code via irqchip_init() */
-}
-
-
-static const char *ape6evm_boards_compat_dt[] __initdata = {
-	"renesas,ape6evm",
-	NULL,
-};
-
-DT_MACHINE_START(APE6EVM_DT, "ape6evm")
-	.init_early	= shmobile_init_delay,
-	.init_irq       = ape6evm_legacy_init_irq,
-	.init_machine	= ape6evm_add_standard_devices,
-	.init_late	= shmobile_init_late,
-	.dt_compat	= ape6evm_boards_compat_dt,
-	.init_time	= ape6evm_legacy_init_time,
-MACHINE_END
-- 
2.1.4
