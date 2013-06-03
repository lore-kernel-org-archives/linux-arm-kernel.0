From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon,  3 Jun 2013 19:38:36 +0400
Subject: [PATCH 3/3] leds: leds-mc13783: Rename unit to indicate various
 MC13xxx chips support
In-Reply-To: <1370273916-29852-1-git-send-email-shc_work@mail.ru>
References: <1370273916-29852-1-git-send-email-shc_work@mail.ru>
Message-ID: <1370273916-29852-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/configs/imx_v4_v5_defconfig            | 2 +-
 drivers/leds/Kconfig                            | 8 ++++----
 drivers/leds/Makefile                           | 2 +-
 drivers/leds/{leds-mc13783.c => leds-mc13xxx.c} | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)
 rename drivers/leds/{leds-mc13783.c => leds-mc13xxx.c} (99%)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index f07a847..7fd9f9b 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -166,7 +166,7 @@ CONFIG_MMC_MXC=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-CONFIG_LEDS_MC13783=y
+CONFIG_LEDS_MC13XXX=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index ef99229..c9a4eb2 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -387,13 +387,13 @@ config LEDS_DELL_NETBOOKS
 	  This adds support for the Latitude 2100 and similar
 	  notebooks that have an external LED.
 
-config LEDS_MC13783
-	tristate "LED Support for MC13783 PMIC"
+config LEDS_MC13XXX
+	tristate "LED Support for MC13XXX PMIC"
 	depends on LEDS_CLASS
-	depends on MFD_MC13783
+	depends on MFD_MC13XXX
 	help
 	  This option enable support for on-chip LED drivers found
-	  on Freescale Semiconductor MC13783 PMIC.
+	  on Freescale Semiconductor MC13783/MC13892 PMIC.
 
 config LEDS_NS2
 	tristate "LED support for Network Space v2 GPIO LEDs"
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index ac28977..70329f7 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -45,7 +45,7 @@ obj-$(CONFIG_LEDS_INTEL_SS4200)		+= leds-ss4200.o
 obj-$(CONFIG_LEDS_LT3593)		+= leds-lt3593.o
 obj-$(CONFIG_LEDS_ADP5520)		+= leds-adp5520.o
 obj-$(CONFIG_LEDS_DELL_NETBOOKS)	+= dell-led.o
-obj-$(CONFIG_LEDS_MC13783)		+= leds-mc13783.o
+obj-$(CONFIG_LEDS_MC13XXX)		+= leds-mc13xxx.o
 obj-$(CONFIG_LEDS_NS2)			+= leds-ns2.o
 obj-$(CONFIG_LEDS_NETXBIG)		+= leds-netxbig.o
 obj-$(CONFIG_LEDS_ASIC3)		+= leds-asic3.o
diff --git a/drivers/leds/leds-mc13783.c b/drivers/leds/leds-mc13xxx.c
similarity index 99%
rename from drivers/leds/leds-mc13783.c
rename to drivers/leds/leds-mc13xxx.c
index f4e50cc..b8a4c2f 100644
--- a/drivers/leds/leds-mc13783.c
+++ b/drivers/leds/leds-mc13xxx.c
@@ -541,6 +541,6 @@ static struct platform_driver mc13xxx_led_driver = {
 };
 module_platform_driver(mc13xxx_led_driver);
 
-MODULE_DESCRIPTION("LEDs driver for Freescale MC13783 PMIC");
+MODULE_DESCRIPTION("LEDs driver for Freescale MC13XXX PMIC");
 MODULE_AUTHOR("Philippe Retornaz <philippe.retornaz@epfl.ch>");
 MODULE_LICENSE("GPL");
-- 
1.8.1.5
