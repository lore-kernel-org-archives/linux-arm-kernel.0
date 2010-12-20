From: marc@cpdesign.com.au (Marc Reilly)
Date: Mon, 20 Dec 2010 14:50:55 +1100
Subject: [PATCHv3 4/4] mc13xxx: Add i2c and spi drivers to Kconfig and Makefile
In-Reply-To: <1292817055-17715-1-git-send-email-marc@cpdesign.com.au>
References: <1292817055-17715-1-git-send-email-marc@cpdesign.com.au>
Message-ID: <1292817055-17715-5-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
---
 drivers/mfd/Kconfig  |   22 ++++++++++++++--------
 drivers/mfd/Makefile |    2 ++
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3a1493b..6980cf2 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -424,20 +424,26 @@ config MFD_PCF50633
 	  facilities, and registers devices for the various functions
 	  so that function-specific drivers can bind to them.
 
-config MFD_MC13783
-	tristate
-
 config MFD_MC13XXX
-	tristate "Support Freescale MC13783 and MC13892"
-	depends on SPI_MASTER
+	tristate "Support Freescale MC13XXX"
+	depends on SPI_MASTER || I2C
 	select MFD_CORE
-	select MFD_MC13783
 	help
 	  Support for the Freescale (Atlas) PMIC and audio CODECs
 	  MC13783 and MC13892.
-	  This driver provides common support for accessing  the device,
+	  This driver provides common support for accessing the device,
 	  additional drivers must be enabled in order to use the
-	  functionality of the device.
+	  functionality of these devices.
+
+config MFD_MC13XXX_SPI
+	tristate "Support for MC13XXX via SPI"
+	depends on SPI_MASTER
+	select MFD_MC13XXX
+
+config MFD_MC13XXX_I2C
+	tristate "Support for MC13XXX via I2C"
+	depends on I2C
+	select MFD_MC13XXX
 
 config PCF50633_ADC
 	tristate "Support for NXP PCF50633 ADC"
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f54b365..b7d774f 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -42,6 +42,8 @@ obj-$(CONFIG_TWL4030_CODEC)	+= twl4030-codec.o
 obj-$(CONFIG_TWL6030_PWM)	+= twl6030-pwm.o
 
 obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
+obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
+obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
 
 obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
 
-- 
1.7.1
