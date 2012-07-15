From: florian@openwrt.org (Florian Fainelli)
Date: Sun, 15 Jul 2012 16:49:13 +0200
Subject: [PATCH 7/8] ARM: MSC814X: add Kconfig and Makefile to arch/arm
In-Reply-To: <1342363754-30808-1-git-send-email-florian@openwrt.org>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
Message-ID: <1342363754-30808-8-git-send-email-florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes arch/arm/{Kconfig,Makefile} reference the MCS814x
machine code that we can now select and build it.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/arm/Kconfig  |   15 +++++++++++++++
 arch/arm/Makefile |    1 +
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 84449dd..ec7e340 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -618,6 +618,19 @@ config ARCH_KS8695
 	  Support for Micrel/Kendin KS8695 "Centaur" (ARM922T) based
 	  System-on-Chip devices.
 
+config ARCH_MCS814X
+	bool "Moschip MCS814x"
+	select PCI
+	select FIQ
+	select GENERIC_IRQ_CHIP
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	select CLKDEV_LOOKUP
+	select ARCH_USES_GETTIMEOFFSET
+	select NEED_MACH_MEMORY_H
+	help
+	  Support for Moschip MCS814x SoCs (MCS8140 currently).
+
 config ARCH_W90X900
 	bool "Nuvoton W90X900 CPU"
 	select CPU_ARM926T
@@ -1054,6 +1067,8 @@ source "arch/arm/mach-sa1100/Kconfig"
 source "arch/arm/plat-samsung/Kconfig"
 source "arch/arm/plat-s3c24xx/Kconfig"
 
+source "arch/arm/mach-mcs814x/Kconfig"
+
 source "arch/arm/plat-spear/Kconfig"
 
 source "arch/arm/mach-s3c24xx/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 0298b00..1d9f377 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -151,6 +151,7 @@ machine-$(CONFIG_ARCH_IXP4XX)		:= ixp4xx
 machine-$(CONFIG_ARCH_KIRKWOOD)		:= kirkwood
 machine-$(CONFIG_ARCH_KS8695)		:= ks8695
 machine-$(CONFIG_ARCH_LPC32XX)		:= lpc32xx
+machine-$(CONFIG_ARCH_MCS814X)		:= mcs814x
 machine-$(CONFIG_ARCH_MMP)		:= mmp
 machine-$(CONFIG_ARCH_MSM)		:= msm
 machine-$(CONFIG_ARCH_MV78XX0)		:= mv78xx0
-- 
1.7.10.4
