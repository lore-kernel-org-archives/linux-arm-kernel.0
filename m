From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 12 Feb 2010 10:38:50 +0000
Subject: [PATCH 2/5] ARM: SMDK2443: Enable AC97 device
In-Reply-To: <1265971133-17610-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1265971133-17610-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1265971133-17610-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Add AC97 controller to platform devices and initialize the AC97 gpios.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c2443/mach-smdk2443.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2443/mach-smdk2443.c b/arch/arm/mach-s3c2443/mach-smdk2443.c
index d65afde..e2e362b 100644
--- a/arch/arm/mach-s3c2443/mach-smdk2443.c
+++ b/arch/arm/mach-s3c2443/mach-smdk2443.c
@@ -106,6 +106,9 @@ static struct platform_device *smdk2443_devices[] __initdata = {
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
 	&s3c_device_hsmmc0,
+#ifdef CONFIG_SND_SOC_SMDK2443_WM9710
+	&s3c_device_ac97,
+#endif
 };
 
 static void __init smdk2443_map_io(void)
@@ -118,6 +121,11 @@ static void __init smdk2443_map_io(void)
 static void __init smdk2443_machine_init(void)
 {
 	s3c_i2c0_set_platdata(NULL);
+
+#ifdef CONFIG_SND_SOC_SMDK2443_WM9710
+	s3c24xx_ac97_setup_gpio(S3C24XX_AC97_GPE0);
+#endif
+
 	platform_add_devices(smdk2443_devices, ARRAY_SIZE(smdk2443_devices));
 	smdk_machine_init();
 }
-- 
1.6.6.1
