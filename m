From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 16 Jun 2011 17:59:03 +0900
Subject: [PATCH 2/2] ARM: Exynos4: ADC Support for NURI Board
In-Reply-To: <1308214743-16295-1-git-send-email-myungjoo.ham@samsung.com>
References: <1308214743-16295-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1308214743-16295-2-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/mach-nuri.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-nuri.c
index 5ca6bdd..0604f5d 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -29,6 +29,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
+#include <plat/adc.h>
 #include <plat/regs-serial.h>
 #include <plat/exynos4.h>
 #include <plat/cpu.h>
@@ -350,7 +351,7 @@ static void __init nuri_tsp_init(void)
 }
 
 static struct regulator_consumer_supply nuri_max8997_ldo1_consumer[] = {
-	REGULATOR_SUPPLY("vadc", NULL), /* Used by CPU's ADC drv */
+	REGULATOR_SUPPLY("vdd", "s5p-adc"), /* Used by CPU's ADC drv */
 };
 static struct regulator_consumer_supply nuri_max8997_ldo3_consumer[] = {
 	REGULATOR_SUPPLY("vdd11", "s5p-mipi-csis.0"), /* MIPI */
@@ -1057,6 +1058,7 @@ static struct platform_device *nuri_devices[] __initdata = {
 	&s3c_device_i2c3,
 	&s3c_device_i2c5,
 	&i2c9_gpio,
+	&s3c_device_adc,
 
 	/* NURI Devices */
 	&nuri_gpio_keys,
-- 
1.7.4.1
