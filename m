From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 30 Jun 2011 17:26:27 +0900
Subject: [PATCH 3/3] Exynos4 NURI: support for NTC thermistor
In-Reply-To: <1309422387-11546-1-git-send-email-myungjoo.ham@samsung.com>
References: <1309422387-11546-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1309422387-11546-4-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/mach-nuri.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-nuri.c
index bdf7a5c..cd8bc06 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -40,6 +40,7 @@
 #include <plat/clock.h>
 #include <plat/gpio-cfg.h>
 #include <plat/iic.h>
+#include <plat/adc-ntc.h>
 
 #include <mach/map.h>
 
@@ -1098,6 +1099,7 @@ static struct platform_device *nuri_devices[] __initdata = {
 	&s3c_device_i2c3,
 	&i2c9_gpio,
 	&s3c_device_adc,
+	&s3c_device_adc_ntc_thermistor,
 	&s3c_device_rtc,
 
 	/* NURI Devices */
@@ -1133,6 +1135,8 @@ static void __init nuri_machine_init(void)
 	nuri_ehci_init();
 	clk_xusbxti.rate = 24000000;
 
+	s3c_adc_ntc_init(6); /* NTC Thermistor uses ADC port 6 */
+
 	/* Last */
 	platform_add_devices(nuri_devices, ARRAY_SIZE(nuri_devices));
 }
-- 
1.7.4.1
