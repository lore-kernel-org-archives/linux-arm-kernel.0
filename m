From: stefan@agner.ch (Stefan Agner)
Date: Tue, 16 Feb 2016 16:18:37 -0800
Subject: [PATCH v2 3/3] ARM: dts: vf-colibri: add carrier boards 3.3V supply
In-Reply-To: <1455668317-15728-1-git-send-email-stefan@agner.ch>
References: <1455668317-15728-1-git-send-email-stefan@agner.ch>
Message-ID: <1455668317-15728-3-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the carrier boards 3.3V supply as fixed regulator. This allows
to specify the power supply for nodes like backlight.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
index ca061c9..f9598b8 100644
--- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
@@ -50,6 +50,14 @@
 		clock-frequency = <16000000>;
 	};
 
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
 	reg_5v0: regulator-5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "5V";
@@ -73,6 +81,7 @@
 &bl {
 	brightness-levels = <0 4 8 16 32 64 128 255>;
 	default-brightness-level = <6>;
+	power-supply = <&reg_3v3>;
 	status  = "okay";
 };
 
@@ -123,6 +132,10 @@
 	status = "okay";
 };
 
+&reg_module_3v3 {
+	vin-supply = <&reg_3v3>;
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.7.1
