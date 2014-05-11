From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun, 11 May 2014 16:06:01 +0800
Subject: [PATCH v6 05/15] ARM: hisi: add ARCH_HISI
In-Reply-To: <1399795571-17231-1-git-send-email-haojian.zhuang@linaro.org>
References: <1399795571-17231-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1399795571-17231-6-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since multiple ARCH configuration will be appended into mach-hisi
directory, add ARCH_HISI as common configuration for different ARCH in
mach-hisi.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/Makefile          |  2 +-
 arch/arm/mach-hisi/Kconfig | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 41c1931..4c2798a 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -154,7 +154,7 @@ machine-$(CONFIG_ARCH_EP93XX)		+= ep93xx
 machine-$(CONFIG_ARCH_EXYNOS)		+= exynos
 machine-$(CONFIG_ARCH_GEMINI)		+= gemini
 machine-$(CONFIG_ARCH_HIGHBANK)		+= highbank
-machine-$(CONFIG_ARCH_HI3xxx)		+= hisi
+machine-$(CONFIG_ARCH_HISI)		+= hisi
 machine-$(CONFIG_ARCH_INTEGRATOR)	+= integrator
 machine-$(CONFIG_ARCH_IOP13XX)		+= iop13xx
 machine-$(CONFIG_ARCH_IOP32X)		+= iop32x
diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index feee4db..da16efd 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -1,8 +1,16 @@
-config ARCH_HI3xxx
-	bool "Hisilicon Hi36xx/Hi37xx family" if ARCH_MULTI_V7
+config ARCH_HISI
+	bool "Hisilicon SoC Support"
+	depends on ARCH_MULTIPLATFORM
 	select ARM_AMBA
 	select ARM_GIC
 	select ARM_TIMER_SP804
+
+if ARCH_HISI
+
+menu "Hisilicon platform type"
+
+config ARCH_HI3xxx
+	bool "Hisilicon Hi36xx/Hi37xx family" if ARCH_MULTI_V7
 	select CACHE_L2X0
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
@@ -10,3 +18,7 @@ config ARCH_HI3xxx
 	select PINCTRL_SINGLE
 	help
 	  Support for Hisilicon Hi36xx/Hi37xx processor family
+
+endmenu
+
+endif
-- 
1.9.1
