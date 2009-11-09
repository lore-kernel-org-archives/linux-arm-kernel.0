From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon, 9 Nov 2009 12:38:42 -0500
Subject: [PATCH] mfd: rename 88pm8607 to 88pm860x in mfd
Message-ID: <mailman.81.1260364350.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename 88PM8607 to 88PM860X in both Makefile and Kconfig under mfd directory.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mfd/Kconfig  |   12 ++++++------
 drivers/mfd/Makefile |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index fbe684b..62b7aae 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -305,14 +305,14 @@ config EZX_PCAP
 	  This enables the PCAP ASIC present on EZX Phones. This is
 	  needed for MMC, TouchScreen, Sound, USB, etc..

-config MFD_88PM8607
-	bool "Support Marvell 88PM8607"
-	depends on I2C
+config MFD_88PM860X
+	bool "Support Marvell 88PM8606/88PM8607"
+	depends on I2C=y
 	select MFD_CORE
 	help
-	  This supports for Marvell 88PM8607 Power Management IC. This includes
-	  the I2C driver and the core APIs _only_, you have to select
-	  individual components like voltage regulators, RTC and
+	  This supports for Marvell 88PM8606/88PM8607 Power Management IC.
+	  This includes the I2C driver and the core APIs _only_, you have to
+	  select individual components like voltage regulators, RTC and
 	  battery-charger under the corresponding menus.

 endmenu
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index bb000a0..a2c08ce 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -50,4 +50,4 @@ obj-$(CONFIG_PCF50633_ADC)	+= pcf50633-adc.o
 obj-$(CONFIG_PCF50633_GPIO)	+= pcf50633-gpio.o
 obj-$(CONFIG_AB3100_CORE)	+= ab3100-core.o
 obj-$(CONFIG_AB3100_OTP)	+= ab3100-otp.o
-obj-$(CONFIG_MFD_88PM8607)	+= 88pm860x-core.o 88pm860x-i2c.o
+obj-$(CONFIG_MFD_88PM860X)	+= 88pm860x-core.o 88pm860x-i2c.o
-- 
1.5.6.5
