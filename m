From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri, 13 Oct 2017 10:22:06 +0200
Subject: [PATCH] i2c: meson: use generic compatible
Message-ID: <20171013082206.31632-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The meson i2c driver seems to be compatible with more SoCs than
initially thought. Let's use the most generic compatible he have in
DT instead of the gxbb specific one

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/i2c/i2c-meson.txt | 2 +-
 drivers/i2c/busses/i2c-meson.c                      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-meson.txt b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
index 611b934c7e10..e6a563443e26 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-meson.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
@@ -1,7 +1,7 @@
 Amlogic Meson I2C controller
 
 Required properties:
- - compatible: must be "amlogic,meson6-i2c" or "amlogic,meson-gxbb-i2c"
+ - compatible: must be "amlogic,meson6-i2c" or "amlogic,meson-gx-i2c"
  - reg: physical address and length of the device registers
  - interrupts: a single interrupt specifier
  - clocks: clock for the device
diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 88d15b92ec35..7b238d8c19af 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -442,7 +442,7 @@ static int meson_i2c_remove(struct platform_device *pdev)
 
 static const struct of_device_id meson_i2c_match[] = {
 	{ .compatible = "amlogic,meson6-i2c" },
-	{ .compatible = "amlogic,meson-gxbb-i2c" },
+	{ .compatible = "amlogic,meson-gx-i2c" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, meson_i2c_match);
-- 
2.13.6
