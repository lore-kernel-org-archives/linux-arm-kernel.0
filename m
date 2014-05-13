From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 13 May 2014 19:45:58 +0800
Subject: [PATCH v7 07/15] ARM: hisi: enable HiP04
In-Reply-To: <1399795571-17231-8-git-send-email-haojian.zhuang@linaro.org>
References: <1399795571-17231-8-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1399981558-31726-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support HiP04 SoC what supports 16 cores. And it relies on MCPM
framework.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-hisi/Kconfig     | 10 +++++++++-
 arch/arm/mach-hisi/hisilicon.c |  9 +++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index da16efd..3f1ece7 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -17,7 +17,15 @@ config ARCH_HI3xxx
 	select PINCTRL
 	select PINCTRL_SINGLE
 	help
-	  Support for Hisilicon Hi36xx/Hi37xx processor family
+	  Support for Hisilicon Hi36xx/Hi37xx SoC family
+
+config ARCH_HIP04
+	bool "Hisilicon HiP04 Cortex A15 family" if ARCH_MULTI_V7
+	select HAVE_ARM_ARCH_TIMER
+	select MCPM if SMP
+	select MCPM_QUAD_CLUSTER if SMP
+	help
+	  Support for Hisilicon HiP04 SoC family
 
 endmenu
 
diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index 741faf3..a9f648f 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -88,3 +88,12 @@ DT_MACHINE_START(HI3620, "Hisilicon Hi3620 (Flattened Device Tree)")
 	.smp		= smp_ops(hi3xxx_smp_ops),
 	.restart	= hi3xxx_restart,
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
