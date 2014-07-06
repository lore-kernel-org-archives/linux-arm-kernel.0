From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Sun,  6 Jul 2014 01:05:17 -0300
Subject: [PATCH v2 10/8] ARM: sun7i: cubietruck: add an SPIdev device for
 testing
In-Reply-To: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
References: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1404619518-7592-11-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index b87fea9..4ef421f 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -66,6 +66,18 @@
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
 			mmc3_pins_a: mmc3 at 0 {
 				/* AP6210 requires pull-up */
-- 
2.0.1
