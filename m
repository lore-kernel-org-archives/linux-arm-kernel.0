From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Tue, 19 Dec 2017 14:57:16 +0100
Subject: [PATCH v5 08/11] thermal: armada: Update Kconfig and module
 description
In-Reply-To: <20171219135719.9531-1-miquel.raynal@free-electrons.com>
References: <20171219135719.9531-1-miquel.raynal@free-electrons.com>
Message-ID: <20171219135719.9531-9-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update Armada thermal driver Kconfig entry as well as the driver's
MODULE_DESCRIPTION content, now that 64-bit SoCs are also supported,
eg. Armada 7K and Armada 8K.

Use the generic term "Marvell EBU Armada SoCs" instead of listing all
the supported SoCs everywhere (excepted in the Kconfig description,
where it is useful to have a list).

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/thermal/Kconfig          | 4 ++--
 drivers/thermal/armada_thermal.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 315ae2926e20..b6adc54b96f1 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -301,13 +301,13 @@ config DB8500_THERMAL
 	  thermal zone if trip points reached.
 
 config ARMADA_THERMAL
-	tristate "Armada 370/XP thermal management"
+	tristate "Marvell EBU Armada SoCs thermal management"
 	depends on ARCH_MVEBU || COMPILE_TEST
 	depends on HAS_IOMEM
 	depends on OF
 	help
 	  Enable this option if you want to have support for thermal management
-	  controller present in Armada 370 and Armada XP SoC.
+	  controller present in Marvell EBU Armada SoCs (370,375,XP,38x,7K,8K).
 
 config DA9062_THERMAL
 	tristate "DA9062/DA9061 Dialog Semiconductor thermal driver"
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 3785b5248bf5..40b57ba2f55b 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -1,5 +1,5 @@
 /*
- * Marvell Armada 370/XP thermal sensor driver
+ * Marvell EBU Armada SoCs thermal sensor driver
  *
  * Copyright (C) 2013 Marvell
  *
@@ -409,5 +409,5 @@ static struct platform_driver armada_thermal_driver = {
 module_platform_driver(armada_thermal_driver);
 
 MODULE_AUTHOR("Ezequiel Garcia <ezequiel.garcia@free-electrons.com>");
-MODULE_DESCRIPTION("Armada 370/XP thermal driver");
+MODULE_DESCRIPTION("Marvell EBU Armada SoCs thermal driver");
 MODULE_LICENSE("GPL v2");
-- 
2.11.0
