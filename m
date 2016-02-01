From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  1 Feb 2016 09:58:03 +0100
Subject: [PATCH 5/5] ARM: realview: add the DS1338 RTC to PB1176 DT
Message-ID: <1454317083-4882-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the Versatile I2C adapter and the Dallas DS1338
RTC on it to the PB1176 device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm-realview-pb1176.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index 95ea12b32aa5..d012ecf25127 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -371,6 +371,18 @@
 		compatible = "simple-bus";
 		ranges;
 
+		i2c0: i2c at 10002000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "arm,versatile-i2c";
+			reg = <0x10002000 0x1000>;
+
+			rtc at 68 {
+				compatible = "dallas,ds1338";
+				reg = <0x68>;
+			};
+		};
+
 		fpga_aaci: aaci at 10004000 {
 			compatible = "arm,pl041", "arm,primecell";
 			reg = <0x10004000 0x1000>;
-- 
2.4.3
