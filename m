From: xuejiancheng@huawei.com (Jiancheng Xue)
Date: Thu, 3 Dec 2015 10:48:06 +0800
Subject: [PATCH v2 7/9] ARM: hisi: rename ARCH_HI3xxx to ARCH_HI36xx
Message-ID: <1449110886-23828-1-git-send-email-xuejiancheng@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARCH_HI3xxx just represents hi36xx soc family.

Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
---
 arch/arm/Kconfig.debug              | 4 ++--
 arch/arm/boot/dts/Makefile          | 2 +-
 arch/arm/configs/hisi_defconfig     | 2 +-
 arch/arm/configs/multi_v7_defconfig | 2 +-
 arch/arm/mach-hisi/Kconfig          | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 4d2ae2a..27d97c8 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -280,7 +280,7 @@ choice
 
 	config DEBUG_HI3620_UART
 		bool "Hisilicon HI3620 Debug UART"
-		depends on ARCH_HI3xxx
+		depends on ARCH_HI36xx
 		select DEBUG_UART_PL01X
 		help
 		  Say Y here if you want kernel low-level debugging support
@@ -288,7 +288,7 @@ choice
 
 	config DEBUG_HI3716_UART
 		bool "Hisilicon Hi3716 Debug UART"
-		depends on ARCH_HI3xxx
+		depends on ARCH_HI36xx
 		select DEBUG_UART_PL01X
 		help
 		  Say Y here if you want kernel low-level debugging support
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 39ad947..9a7ba0b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -135,7 +135,7 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
 	exynos5800-peach-pi.dtb
 dtb-$(CONFIG_ARCH_HI3519) += \
 	hi3519-demb.dtb
-dtb-$(CONFIG_ARCH_HI3xxx) += \
+dtb-$(CONFIG_ARCH_HI36xx) += \
 	hi3620-hi4511.dtb
 dtb-$(CONFIG_ARCH_HIX5HD2) += \
 	hisi-x5hd2-dkb.dtb
diff --git a/arch/arm/configs/hisi_defconfig b/arch/arm/configs/hisi_defconfig
index 321d020..3162709 100644
--- a/arch/arm/configs/hisi_defconfig
+++ b/arch/arm/configs/hisi_defconfig
@@ -4,7 +4,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_RD_LZMA=y
 CONFIG_ARCH_HISI=y
-CONFIG_ARCH_HI3xxx=y
+CONFIG_ARCH_HI36xx=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_CMDLINE_PARTITION=y
 CONFIG_ARCH_HIX5HD2=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 69a22fd..ddc28ce 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -38,7 +38,7 @@ CONFIG_MACH_BERLIN_BG2Q=y
 CONFIG_ARCH_DIGICOLOR=y
 CONFIG_ARCH_HIGHBANK=y
 CONFIG_ARCH_HISI=y
-CONFIG_ARCH_HI3xxx=y
+CONFIG_ARCH_HI36xx=y
 CONFIG_ARCH_HIX5HD2=y
 CONFIG_ARCH_HIP01=y
 CONFIG_ARCH_HIP04=y
diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index bc5b873..15f23ed 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -20,7 +20,7 @@ config ARCH_HI3519
 	help
 	  Support for Hisilicon Hi3519 Soc
 
-config ARCH_HI3xxx
+config ARCH_HI36xx
 	bool "Hisilicon Hi36xx family" if ARCH_MULTI_V7
 	select CACHE_L2X0
 	select HAVE_ARM_SCU if SMP
-- 
1.9.1
