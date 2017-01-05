From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed,  4 Jan 2017 18:21:23 -0600
Subject: [PATCH 01/12] ARM: dts: socfpga: enable GPIO and LEDs for Cyclone5
 and Arria5 devkits
In-Reply-To: <1483575694-29599-1-git-send-email-dinguyen@kernel.org>
References: <1483575694-29599-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1483575694-29599-2-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable all the GPIO ports and define the GPIO-based leds on the Cyclone5 and
Arria5 devkits.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/boot/dts/socfpga_arria5_socdk.dts   | 35 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts | 31 ++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria5_socdk.dts b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
index f739ead..fa70c39 100644
--- a/arch/arm/boot/dts/socfpga_arria5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
@@ -39,6 +39,29 @@
 		ethernet0 = &gmac1;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		hps0 {
+			label = "hps_led0";
+			gpios = <&porta 0 1>;
+		};
+
+		hps1 {
+			label = "hps_led1";
+			gpios = <&portb 11 1>;
+		};
+
+		hps2 {
+			label = "hps_led2";
+			gpios = <&porta 17 1>;
+		};
+
+		hps3 {
+			label = "hps_led3";
+			gpios = <&porta 18 1>;
+		};
+	};
+
 	regulator_3_3v: 3-3-v-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "3.3V";
@@ -61,6 +84,18 @@
 	rxc-skew-ps = <2000>;
 };
 
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&gpio2 {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
index 6306d00..6d3188b 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
@@ -39,6 +39,29 @@
 		ethernet0 = &gmac1;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		hps0 {
+			label = "hps_led0";
+			gpios = <&portb 15 1>;
+		};
+
+		hps1 {
+			label = "hps_led1";
+			gpios = <&portb 14 1>;
+		};
+
+		hps2 {
+			label = "hps_led2";
+			gpios = <&portb 13 1>;
+		};
+
+		hps3 {
+			label = "hps_led3";
+			gpios = <&portb 12 1>;
+		};
+	};
+
 	regulator_3_3v: 3-3-v-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "3.3V";
@@ -61,10 +84,18 @@
 	rxc-skew-ps = <2000>;
 };
 
+&gpio0 {
+	status = "okay";
+};
+
 &gpio1 {
 	status = "okay";
 };
 
+&gpio2 {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
2.7.4
