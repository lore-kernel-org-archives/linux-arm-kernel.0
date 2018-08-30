From: embed3d@gmail.com (Philipp Rossak)
Date: Thu, 30 Aug 2018 17:44:50 +0200
Subject: [PATCH v3 02/30] mfd: Kconfig: Remove MFD_SUN4I_GPADC config option
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Message-ID: <20180830154518.29507-3-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are merging the mfd:sun4i-gpadc driver into the
iio/adc/sun4i-gpadc driver. So we need to remove the MFD_SUN4I_GPADC
config option.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/mfd/Kconfig | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b860eb5aa194..c7ab57d65610 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -40,23 +40,6 @@ config MFD_ACT8945A
 	  linear regulators, along with a complete ActivePath battery
 	  charger.
 
-config MFD_SUN4I_GPADC
-	tristate "Allwinner sunxi platforms' GPADC MFD driver"
-	select MFD_CORE
-	select REGMAP_MMIO
-	select REGMAP_IRQ
-	depends on ARCH_SUNXI || COMPILE_TEST
-	depends on !TOUCHSCREEN_SUN4I
-	help
-	  Select this to get support for Allwinner SoCs (A10, A13 and A31) ADC.
-	  This driver will only map the hardware interrupt and registers, you
-	  have to select individual drivers based on this MFD to be able to use
-	  the ADC or the thermal sensor. This will try to probe the ADC driver
-	  sun4i-gpadc-iio and the hwmon driver iio_hwmon.
-
-	  To compile this driver as a module, choose M here: the module will be
-	  called sun4i-gpadc.
-
 config MFD_AS3711
 	bool "AMS AS3711"
 	select MFD_CORE
-- 
2.11.0
