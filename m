From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  5 Sep 2012 10:40:57 +0200
Subject: [PATCH 8/8] ARM: dts: cfa10049: Add the 74HC595 gpio expanders
In-Reply-To: <1346834457-6257-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1346834457-6257-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1346834457-6257-8-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10049.dts |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index 1f7fa50..820153a 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -39,6 +39,26 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&spi3_pins_cfa10049>;
 				status = "okay";
+
+				gpio5: gpio5 at 0 {
+					compatible = "fairchild,74hc595";
+					gpio-controller;
+					#gpio-cells = <2>;
+					reg = <0>;
+					registers-number = <4>;
+					output-latch-gpio = <&gpio0 26 0>;
+					spi-max-frequency = <100000>;
+				};
+
+				gpio6: gpio6 at 1 {
+					compatible = "fairchild,74hc595";
+					gpio-controller;
+					#gpio-cells = <2>;
+					reg = <1>;
+					registers-number = <2>;
+					output-latch-gpio = <&gpio0 17 0>;
+					spi-max-frequency = <100000>;
+				};
 			};
 		};
 
-- 
1.7.9.5
