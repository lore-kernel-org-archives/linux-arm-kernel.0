From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu,  7 Aug 2014 18:51:29 +0800
Subject: [PATCH v17 3/9] ARM: hisi: enable HiP04
In-Reply-To: <1407408695-19626-1-git-send-email-haojian.zhuang@linaro.org>
References: <1407408695-19626-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1407408695-19626-4-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support HiP04 SoC what supports 16 cores. And it relies on MCPM
framework.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-hisi/Kconfig     | 9 +++++++++
 arch/arm/mach-hisi/hisilicon.c | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 9848829..075772b 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -22,6 +22,15 @@ config ARCH_HI3xxx
 	help
 	  Support for Hisilicon Hi36xx SoC family
 
+config ARCH_HIP04
+	bool "Hisilicon HiP04 Cortex A15 family" if ARCH_MULTI_V7
+	select ARM_ERRATA_798181 if SMP
+	select HAVE_ARM_ARCH_TIMER
+	select MCPM if SMP
+	select MCPM_QUAD_CLUSTER if SMP
+	help
+	  Support for Hisilicon HiP04 SoC family
+
 config ARCH_HIX5HD2
 	bool "Hisilicon X5HD2 family" if ARCH_MULTI_V7
 	select CACHE_L2X0
diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index f37fb65..5b8c11f 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -65,3 +65,12 @@ static const char *hix5hd2_compat[] __initconst = {
 DT_MACHINE_START(HIX5HD2_DT, "Hisilicon HIX5HD2 (Flattened Device Tree)")
 	.dt_compat	= hix5hd2_compat,
 MACHINE_END
+
+static const char *hip04_compat[] __initconst = {
+	"hisilicon,hip04-d01",
+	NULL,
+};
+
+DT_MACHINE_START(HIP04, "Hisilicon HiP04 (Flattened Device Tree)")
+	.dt_compat	= hip04_compat,
+MACHINE_END
-- 
1.9.1
