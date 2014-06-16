From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 16 Jun 2014 00:50:35 -0300
Subject: [PATCH 10/10] ARM: sun7i: cubietruck: add an SPIdev device for testing
In-Reply-To: <1402890635-12342-1-git-send-email-emilio@elopez.com.ar>
References: <1402890635-12342-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1402890635-12342-11-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index cb25d3c..2c852aa 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -47,6 +47,18 @@
 			status = "okay";
 		};
 
+		spi2: spi at 01c17000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi2_pins_a>;
+			status = "okay";
+
+			dac0: dh2228 at 2 {
+				compatible = "rohm,dh2228fv";
+				reg = <2>;
+				spi-max-frequency = <100000>;
+			};
+		};
+
 		pinctrl at 01c20800 {
 			ahci_pwr_pin_cubietruck: ahci_pwr_pin at 1 {
 				allwinner,pins = "PH12";
-- 
2.0.0
