From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 30 Jun 2011 16:49:33 +0900
Subject: [PATCH v3 4/6] ARM: EXYNOS4: Support ADC
In-Reply-To: <1309420175-10301-1-git-send-email-myungjoo.ham@samsung.com>
References: <1309420175-10301-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1309420175-10301-5-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
--
Updates from v2
- Based on EXT_GIC patches from Changhwan Youn (ARM: EXYNOS4: Adds
  External GIC)
---
 arch/arm/mach-exynos4/Kconfig             |    1 +
 arch/arm/mach-exynos4/cpu.c               |    4 ++++
 arch/arm/mach-exynos4/include/mach/irqs.h |    3 +++
 arch/arm/mach-exynos4/include/mach/map.h  |    5 +++++
 4 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index 0aca083..80f4fbe 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -184,6 +184,7 @@ config MACH_NURI
 	select EXYNOS4_SETUP_SDHCI
 	select EXYNOS4_SETUP_USB_PHY
 	select SAMSUNG_DEV_PWM
+	select SAMSUNG_DEV_ADC
 	help
 	  Machine support for Samsung Mobile NURI Board.
 
diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 5423ed8..7ffa81d 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -21,7 +21,9 @@
 
 #include <plat/cpu.h>
 #include <plat/clock.h>
+#include <plat/devs.h>
 #include <plat/exynos4.h>
+#include <plat/adc-core.h>
 #include <plat/sdhci.h>
 #include <plat/devs.h>
 #include <plat/fimc-core.h>
@@ -141,6 +143,8 @@ void __init exynos4_map_io(void)
 	exynos4_default_sdhci2();
 	exynos4_default_sdhci3();
 
+	s3c_adc_setname("samsung-adc-v3");
+
 	s3c_fimc_setname(0, "exynos4-fimc");
 	s3c_fimc_setname(1, "exynos4-fimc");
 	s3c_fimc_setname(2, "exynos4-fimc");
diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-exynos4/include/mach/irqs.h
index 250427f..31f6bed 100644
--- a/arch/arm/mach-exynos4/include/mach/irqs.h
+++ b/arch/arm/mach-exynos4/include/mach/irqs.h
@@ -139,6 +139,9 @@
 
 #define MAX_COMBINER_NR		16
 
+#define IRQ_ADC			IRQ_ADC0
+#define IRQ_TC			IRQ_PEN0
+
 #define S5P_IRQ_EINT_BASE	COMBINER_IRQ(MAX_COMBINER_NR, 0)
 
 #define S5P_EINT_BASE1		(S5P_IRQ_EINT_BASE + 0)
diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos4/include/mach/map.h
index e4b5c79..e03e820 100644
--- a/arch/arm/mach-exynos4/include/mach/map.h
+++ b/arch/arm/mach-exynos4/include/mach/map.h
@@ -110,6 +110,9 @@
 
 #define EXYNOS4_PA_IIC(x)		(0x13860000 + ((x) * 0x10000))
 
+#define EXYNOS4_PA_ADC			0x13910000
+#define EXYNOS4_PA_ADC1			0x13911000
+
 #define EXYNOS4_PA_AC97			0x139A0000
 
 #define EXYNOS4_PA_SPDIF		0x139B0000
@@ -132,6 +135,8 @@
 #define S3C_PA_IIC5			EXYNOS4_PA_IIC(5)
 #define S3C_PA_IIC6			EXYNOS4_PA_IIC(6)
 #define S3C_PA_IIC7			EXYNOS4_PA_IIC(7)
+#define SAMSUNG_PA_ADC			EXYNOS4_PA_ADC
+#define SAMSUNG_PA_ADC1			EXYNOS4_PA_ADC1
 #define S3C_PA_RTC			EXYNOS4_PA_RTC
 #define S3C_PA_WDT			EXYNOS4_PA_WATCHDOG
 
-- 
1.7.4.1
