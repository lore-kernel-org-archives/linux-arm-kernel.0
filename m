From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Sun,  6 Jul 2014 01:05:18 -0300
Subject: [PATCH v2 11/8] ARM: sun5i: a10s-olinuxino-micro: add an SPIdev
 device for testing
In-Reply-To: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
References: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1404619518-7592-12-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 12 ++++++++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi                |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index ea9519d..3f19e57 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -68,6 +68,18 @@
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
 			mmc0_cd_pin_olinuxino_micro: mmc0_cd_pin at 0 {
 				allwinner,pins = "PG1";
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 12f26f3..814cddb 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -506,6 +506,13 @@
 				allwinner,drive = <2>;
 				allwinner,pull = <0>;
 			};
+
+			spi2_pins_a: spi2 at 0 {
+				allwinner,pins = "PB11", "PB12", "PB13", "PB14";
+				allwinner,function = "spi2";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
2.0.1
