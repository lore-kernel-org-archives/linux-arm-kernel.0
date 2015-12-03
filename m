From: xuejiancheng@huawei.com (Jiancheng Xue)
Date: Thu, 3 Dec 2015 10:42:45 +0800
Subject: [PATCH v2 3/9] ARM: hisi: enable Hi3519 soc
Message-ID: <1449110565-23590-1-git-send-email-xuejiancheng@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi3519 SOC is mainly used for ip camera and sport dv
solutions.

Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
---
 arch/arm/mach-hisi/Kconfig     | 9 +++++++++
 arch/arm/mach-hisi/hisilicon.c | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 83061ad..bc5b873 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -12,6 +12,14 @@ if ARCH_HISI
 
 menu "Hisilicon platform type"
 
+config ARCH_HI3519
+	bool "Hisilicon Hi3519 Soc" if ARCH_MULTI_V7
+	select HAVE_ARM_ARCH_TIMER
+	select ARCH_HAS_RESET_CONTROLLER
+
+	help
+	  Support for Hisilicon Hi3519 Soc
+
 config ARCH_HI3xxx
 	bool "Hisilicon Hi36xx family" if ARCH_MULTI_V7
 	select CACHE_L2X0
@@ -48,6 +56,7 @@ config ARCH_HIX5HD2
 	select PINCTRL_SINGLE
 	help
 	  Support for Hisilicon HIX5HD2 SoC family
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index 8cc6215..a93ac5c 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -81,3 +81,12 @@ static const char *const hip01_compat[] __initconst = {
 DT_MACHINE_START(HIP01, "Hisilicon HIP01 (Flattened Device Tree)")
 	.dt_compat      = hip01_compat,
 MACHINE_END
+
+static const char *const hi3519_compat[] __initconst = {
+	"hisilicon,hi3519",
+	NULL,
+};
+
+DT_MACHINE_START(HI3519_DT, "Hisilicon Hi3519 (Flattened Device Tree)")
+	.dt_compat	= hi3519_compat,
+MACHINE_END
-- 
1.9.1
