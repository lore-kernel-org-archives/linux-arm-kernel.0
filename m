From: long.wanglong@huawei.com (Wang Long)
Date: Fri, 28 Nov 2014 02:15:45 +0000
Subject: [PATCH 2/7] ARM: hisi: enable HiP01 SoC
In-Reply-To: <1417140950-67103-1-git-send-email-long.wanglong@huawei.com>
References: <1417140950-67103-1-git-send-email-long.wanglong@huawei.com>
Message-ID: <1417140950-67103-3-git-send-email-long.wanglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Hisilicon HiP01 SoC. This HiP01 SoC series support both
one core or dual cores and quad cores. The core is Cortex A9.

Signed-off-by: Wang Long <long.wanglong@huawei.com>
---
 arch/arm/mach-hisi/Kconfig     |  8 ++++++++
 arch/arm/mach-hisi/hisilicon.c | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index cd19433..83061ad 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -22,6 +22,14 @@ config ARCH_HI3xxx
 	help
 	  Support for Hisilicon Hi36xx SoC family
 
+config ARCH_HIP01
+       bool "Hisilicon HIP01 family" if ARCH_MULTI_V7
+       select HAVE_ARM_SCU if SMP
+       select HAVE_ARM_TWD if SMP
+       select ARM_GLOBAL_TIMER
+       help
+         Support for Hisilicon HIP01 SoC family
+
 config ARCH_HIP04
 	bool "Hisilicon HiP04 Cortex A15 family" if ARCH_MULTI_V7
 	select ARM_ERRATA_798181 if SMP
diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index 7744c35..76b9070 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -72,3 +72,13 @@ static const char *hip04_compat[] __initconst = {
 DT_MACHINE_START(HIP04, "Hisilicon HiP04 (Flattened Device Tree)")
 	.dt_compat	= hip04_compat,
 MACHINE_END
+
+static const char *hip01_compat[] __initconst = {
+	"hisilicon,hip01",
+	"hisilicon,hip01-ca9x2",
+	NULL,
+};
+
+DT_MACHINE_START(HIP01, "Hisilicon HIP01 (Flattened Device Tree)")
+	.dt_compat      = hip01_compat,
+MACHINE_END
-- 
1.8.3.4
