From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 12 May 2014 09:30:33 +0800
Subject: [PATCH 2/5] ARM: hisi: enable hix5hd2 SoC
In-Reply-To: <1399858236-29027-1-git-send-email-haojian.zhuang@linaro.org>
References: <1399858236-29027-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1399858236-29027-3-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haifeng Yan <yanhaifeng@gmail.com>

Enable HiX5HD2 SoC.
Add ARCH_HIX5HD2 to support Hisilicon x5hd2 SoCs.

Signed-off-by: Haifeng Yan <yanhaifeng@gmail.com>
---
 arch/arm/mach-hisi/Kconfig | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 0a5a49d..94b7ff1 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -10,14 +10,14 @@ if ARCH_HISI
 menu "Hisilicon platform type"
 
 config ARCH_HI3xxx
-	bool "Hisilicon Hi36xx/Hi37xx family" if ARCH_MULTI_V7
+	bool "Hisilicon Hi36xx family" if ARCH_MULTI_V7
 	select CACHE_L2X0
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select PINCTRL
 	select PINCTRL_SINGLE
 	help
-	  Support for Hisilicon Hi36xx/Hi37xx SoC family
+	  Support for Hisilicon Hi36xx SoC family
 
 config ARCH_HIP04
 	bool "Hisilicon HiP04 Cortex A15 family" if ARCH_MULTI_V7
@@ -28,6 +28,15 @@ config ARCH_HIP04
 	help
 	  Support for Hisilicon HiP04 SoC family
 
+config ARCH_HIX5HD2
+	bool "Hisilicon X5HD2 family" if ARCH_MULTI_V7
+	select CACHE_L2X0
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
+	select PINCTRL
+	select PINCTRL_SINGLE
+	help
+	  Support for Hisilicon X5HD2 SoC family
 endmenu
 
 endif
-- 
1.9.1
