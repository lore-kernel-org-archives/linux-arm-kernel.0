From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 27 Sep 2012 16:12:05 +0100
Subject: [PATCH 6/7] ARM: ux500: Add support for gpio-keys and Proximity
 Sensor for HREF
In-Reply-To: <1348758726-25336-1-git-send-email-lee.jones@linaro.org>
References: <1348758726-25336-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1348758726-25336-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we ensure the SFH7741 Proximity Sensor is registered through
gpio-keys when booting with Device Tree enabled.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/href.dtsi       |   11 +++++++++++
 arch/arm/boot/dts/hrefprev60.dts  |    6 ++++++
 arch/arm/boot/dts/hrefv60plus.dts |    6 ++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/href.dtsi b/arch/arm/boot/dts/href.dtsi
index 27baa44..592fb9d 100644
--- a/arch/arm/boot/dts/href.dtsi
+++ b/arch/arm/boot/dts/href.dtsi
@@ -16,6 +16,17 @@
 		reg = <0x00000000 0x20000000>;
 	};
 
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		button at 1 {
+			linux,code = <11>;
+			label = "SFH7741 Proximity Sensor";
+		};
+	};
+
 	soc-u9500 {
 		uart at 80120000 {
 			status = "okay";
diff --git a/arch/arm/boot/dts/hrefprev60.dts b/arch/arm/boot/dts/hrefprev60.dts
index 2dd28b9..128cf1c 100644
--- a/arch/arm/boot/dts/hrefprev60.dts
+++ b/arch/arm/boot/dts/hrefprev60.dts
@@ -17,6 +17,12 @@
 	model = "ST-Ericsson HREF (pre-v60) platform with Device Tree";
 	compatible = "st-ericsson,mop500";
 
+	gpio_keys {
+		button at 1 {
+			gpios  = <&tc3589x_gpio 7 0x4>;
+		};
+	};
+
 	soc-u9500 {
 		i2c at 80004000 {
 			tps61052 at 33 {
diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
index 2a85893..1252d8a 100644
--- a/arch/arm/boot/dts/hrefv60plus.dts
+++ b/arch/arm/boot/dts/hrefv60plus.dts
@@ -16,4 +16,10 @@
 / {
 	model = "ST-Ericsson HREF (v60+) platform with Device Tree";
 	compatible = "st-ericsson,hrefv60+";
+
+	gpio_keys {
+		button at 1 {
+			gpios  = <&gpio6 25 0x4>;
+		};
+	};
 };
-- 
1.7.9.5
