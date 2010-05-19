From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Wed, 19 May 2010 18:46:05 +0200
Subject: [PATCH 10/13] eukrea_mbimx27: use card detect through DAT3 for SDHC1
In-Reply-To: <1274287568-30253-9-git-send-email-eric@eukrea.com>
References: <1274287568-30253-1-git-send-email-eric@eukrea.com>
	<1274287568-30253-2-git-send-email-eric@eukrea.com>
	<1274287568-30253-3-git-send-email-eric@eukrea.com>
	<1274287568-30253-4-git-send-email-eric@eukrea.com>
	<1274287568-30253-5-git-send-email-eric@eukrea.com>
	<1274287568-30253-6-git-send-email-eric@eukrea.com>
	<1274287568-30253-7-git-send-email-eric@eukrea.com>
	<1274287568-30253-8-git-send-email-eric@eukrea.com>
	<1274287568-30253-9-git-send-email-eric@eukrea.com>
Message-ID: <1274287568-30253-10-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
index 7ea93e0..136b736 100644
--- a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
@@ -286,6 +286,10 @@ static struct platform_device *platform_devices[] __initdata = {
 	&leds_gpio,
 };
 
+static struct imxmmc_platform_data sdhc_pdata = {
+	.dat3_card_detect = 1,
+};
+
 /*
  * system init for baseboard usage. Will be called by cpuimx27 init.
  *
@@ -304,7 +308,7 @@ void __init eukrea_mbimx27_baseboard_init(void)
 #endif
 
 	mxc_register_device(&mxc_fb_device, &eukrea_mbimx27_fb_data);
-	mxc_register_device(&mxc_sdhc_device0, NULL);
+	mxc_register_device(&mxc_sdhc_device0, &sdhc_pdata);
 
 #if defined(CONFIG_TOUCHSCREEN_ADS7846) \
 	|| defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
-- 
1.6.3.3
