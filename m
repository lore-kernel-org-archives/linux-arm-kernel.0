From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 16 Nov 2015 10:36:15 +0900
Subject: [PATCH 2/2] arm64: EXYNOS: Consolidate ARCH_EXYNOS7 symbol into
 ARCH_EXYNOS
In-Reply-To: <1447637775-9887-1-git-send-email-k.kozlowski@samsung.com>
References: <1447637775-9887-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1447637775-9887-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARMv8 Exynos family SoCs in Linux kernel are currently:
 - Exynos5433 (controlled by ARCH_EXYNOS),
 - Exynos7 (controlled by ARCH_EXYNOS7).

It duplicates Kconfig symbols unnecessarily, so consolidate them into
one ARCH_EXYNOS. Future SoCs could fall also under the ARCH_EXYNOS
symbol.

The commit should not bring any visible functional change.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm64/Kconfig.platforms        | 11 ++---------
 arch/arm64/boot/dts/exynos/Makefile |  2 +-
 arch/arm64/configs/defconfig        |  2 +-
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 4043c35962cc..afa19baca94e 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -13,21 +13,14 @@ config ARCH_BERLIN
 	  This enables support for Marvell Berlin SoC Family
 
 config ARCH_EXYNOS
-	bool
-	help
-	  This enables support for Samsung Exynos SoC family
-
-config ARCH_EXYNOS7
-	bool "ARMv8 based Samsung Exynos7"
-	select ARCH_EXYNOS
+	bool "ARMv8 based Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
 	select PINCTRL
 	select PINCTRL_EXYNOS
-
 	help
-	  This enables support for Samsung Exynos7 SoC family
+	  This enables support for Samsung Exynos ARMv8 SoC family
 
 config ARCH_LAYERSCAPE
 	bool "ARMv8 based Freescale Layerscape SoC family"
diff --git a/arch/arm64/boot/dts/exynos/Makefile b/arch/arm64/boot/dts/exynos/Makefile
index 20310e5b6d6f..50c9b9383cfa 100644
--- a/arch/arm64/boot/dts/exynos/Makefile
+++ b/arch/arm64/boot/dts/exynos/Makefile
@@ -1,4 +1,4 @@
-dtb-$(CONFIG_ARCH_EXYNOS7) += exynos7-espresso.dtb
+dtb-$(CONFIG_ARCH_EXYNOS) += exynos7-espresso.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index bdd7aa358d2a..a396fa7c69a5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -33,7 +33,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_IOSCHED_DEADLINE is not set
 CONFIG_ARCH_BCM_IPROC=y
 CONFIG_ARCH_BERLIN=y
-CONFIG_ARCH_EXYNOS7=y
+CONFIG_ARCH_EXYNOS=y
 CONFIG_ARCH_LAYERSCAPE=y
 CONFIG_ARCH_HISI=y
 CONFIG_ARCH_MEDIATEK=y
-- 
1.9.1
