From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 17 Jul 2017 07:48:08 +0200
Subject: [PATCH 2/3] ARM: s3c24xx: Remove non-existing SND_SOC_SMDK2443_WM9710
In-Reply-To: <1500270489-14749-1-git-send-email-krzk@kernel.org>
References: <1500270489-14749-1-git-send-email-krzk@kernel.org>
Message-ID: <1500270489-14749-2-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no CONFIG_SND_SOC_SMDK2443_WM9710 so get rid of it.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/mach-smdk2443.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-smdk2443.c b/arch/arm/mach-s3c24xx/mach-smdk2443.c
index 87fe5c5b8073..474cd81aa8ad 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2443.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2443.c
@@ -111,9 +111,6 @@ static struct platform_device *smdk2443_devices[] __initdata = {
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
 	&s3c_device_hsmmc1,
-#ifdef CONFIG_SND_SOC_SMDK2443_WM9710
-	&s3c_device_ac97,
-#endif
 	&s3c2443_device_dma,
 };
 
@@ -133,11 +130,6 @@ static void __init smdk2443_init_time(void)
 static void __init smdk2443_machine_init(void)
 {
 	s3c_i2c0_set_platdata(NULL);
-
-#ifdef CONFIG_SND_SOC_SMDK2443_WM9710
-	s3c24xx_ac97_setup_gpio(S3C24XX_AC97_GPE0);
-#endif
-
 	platform_add_devices(smdk2443_devices, ARRAY_SIZE(smdk2443_devices));
 	smdk_machine_init();
 }
-- 
2.7.4
