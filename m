From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  4 Jun 2016 10:09:59 +0300
Subject: [PATCH 07/22] gpio: clps711x: Changing the compatibility string to
 match with the smallest supported chip
In-Reply-To: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
Message-ID: <1465024214-22120-8-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the compatibility string to match with the smallest
supported chip (EP7209). Since the DT-support for this CPU is not yet
announced, this change is safe.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 Documentation/devicetree/bindings/gpio/gpio-clps711x.txt | 4 ++--
 drivers/gpio/gpio-clps711x.c                             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-clps711x.txt b/Documentation/devicetree/bindings/gpio/gpio-clps711x.txt
index e0d0446..0a304ad 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-clps711x.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-clps711x.txt
@@ -1,7 +1,7 @@
 Cirrus Logic CLPS711X GPIO controller
 
 Required properties:
-- compatible: Should be "cirrus,clps711x-gpio"
+- compatible: Should be "cirrus,ep7209-gpio"
 - reg: Physical base GPIO controller registers location and length.
   There should be two registers, first is DATA register, the second
   is DIRECTION.
@@ -21,7 +21,7 @@ aliases {
 };
 
 porta: gpio at 80000000 {
-	compatible = "cirrus,clps711x-gpio";
+	compatible = "cirrus,ep7312-gpio","cirrus,ep7209-gpio";
 	reg = <0x80000000 0x1>, <0x80000040 0x1>;
 	gpio-controller;
 	#gpio-cells = <2>;
diff --git a/drivers/gpio/gpio-clps711x.c b/drivers/gpio/gpio-clps711x.c
index 5a69025..cd3781e 100644
--- a/drivers/gpio/gpio-clps711x.c
+++ b/drivers/gpio/gpio-clps711x.c
@@ -71,7 +71,7 @@ static int clps711x_gpio_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id __maybe_unused clps711x_gpio_ids[] = {
-	{ .compatible = "cirrus,clps711x-gpio" },
+	{ .compatible = "cirrus,ep7209-gpio" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, clps711x_gpio_ids);
-- 
2.4.9
