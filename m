From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Sun, 20 Jan 2013 03:54:26 +0100
Subject: [PATCH] RX-51: Register twl4030-madc device
Message-ID: <1358650466-29917-1-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 9a0dbb7..286292e 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -1364,6 +1364,16 @@ static void __init rx51_init_lirc(void)
 }
 #endif
 
+static struct platform_device madc_hwmon = {
+	.name	= "twl4030_madc_hwmon",
+	.id	= -1,
+};
+
+static void __init rx51_init_twl4030_hwmon(void)
+{
+	platform_device_register(&madc_hwmon);
+}
+
 void __init rx51_peripherals_init(void)
 {
 	rx51_i2c_init();
@@ -1386,5 +1396,6 @@ void __init rx51_peripherals_init(void)
 		omap_hsmmc_init(mmc);
 
 	rx51_charger_init();
+	rx51_init_twl4030_hwmon();
 }
 
-- 
1.7.10.4
