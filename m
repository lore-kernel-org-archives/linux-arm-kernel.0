From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 25 Feb 2013 11:49:37 +0800
Subject: [PATCH v5 08/12] document: devicetree: add properties in mrvl gpio
In-Reply-To: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
References: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1361764181-26647-9-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Append new properties for mrvl gpio. They're in below.
marvell,gpio-ed-mask marvell,gpio-inverted & marvell,nr_gpios.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 Documentation/devicetree/bindings/gpio/mrvl-gpio.txt |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt b/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
index e137874..8cd5252 100644
--- a/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
@@ -14,6 +14,13 @@ Required properties:
   interrupt source.
 - gpio-controller : Marks the device node as a gpio controller.
 - #gpio-cells : Should be one.  It is the pin number.
+- marvell,nr-gpios : Should be the number of total gpio pins.
+
+Optional properties:
+- marvell,gpio-ed-mask : It means that there's gpio edge mask register.
+  It only exists in mmp family SoC.
+- marvell,gpio-inverted : It means that some gpio pins are inverted.
+  It only exists in PXA26x SoC.
 
 Example:
 
@@ -26,6 +33,8 @@ Example:
 		#gpio-cells = <1>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		marvell,gpio-ed-mask;
+		marvell,nr-gpios = <128>;
       };
 
 * Marvell Orion GPIO Controller
-- 
1.7.10.4
