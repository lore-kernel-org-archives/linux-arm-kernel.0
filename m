From: narmstrong@baylibre.com (Neil Armstrong)
Date: Sun, 10 Jul 2016 11:24:04 +0200
Subject: [PATCH v2 3/4] ARM64: dts: meson-gxbb: Add Meson GXBB PWM Controller
 nodes
In-Reply-To: <1468142645-4360-1-git-send-email-narmstrong@baylibre.com>
References: <1468142645-4360-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1468142645-4360-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 806b903..2eacef0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -153,6 +153,27 @@
 				status = "disabled";
 			};
 
+			pwm_ab: pwm at 8550 {
+				compatible = "amlogic,meson-gxbb-pwm";
+				reg = <0x0 0x08550 0x0 0x10>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_cd: pwm at 8650 {
+				compatible = "amlogic,meson-gxbb-pwm";
+				reg = <0x0 0x08650 0x0 0x10>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_ef: pwm at 86c0 {
+				compatible = "amlogic,meson-gxbb-pwm";
+				reg = <0x0 0x086c0 0x0 0x10>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
 			uart_C: serial at 8700 {
 				compatible = "amlogic,meson-uart";
 				reg = <0x0 0x8700 0x0 0x14>;
@@ -212,6 +233,13 @@
 				clocks = <&xtal>;
 				status = "disabled";
 			};
+
+			pwm_ab_AO: pwm at 550 {
+				compatible = "amlogic,meson-gxbb-pwm";
+				reg = <0x0 0x0550 0x0 0x10>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
 		};
 
 		periphs: periphs at c8834000 {
-- 
2.7.0
