From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 18 Apr 2013 17:38:56 +0200
Subject: [PATCH 3/3] ARM: mxs: cfa10049: Add NAU7802 ADCs to the device tree
In-Reply-To: <1366299536-18353-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1366299536-18353-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1366299536-18353-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

Since these ADCs share the same non-configurable address on the I2C bus,
they have to be put behind a muxer.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10049.dts |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index a333dbf..23166d9 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -312,18 +312,36 @@
 			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			adc0: nau7802 at 2a {
+				compatible = "nuvoton,nau7802";
+				reg = <0x2a>;
+				nuvoton,vldo = <3000>;
+			};
 		};
 
 		i2c at 1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			adc1: nau7802 at 2a {
+				compatible = "nuvoton,nau7802";
+				reg = <0x2a>;
+				nuvoton,vldo = <3000>;
+			};
 		};
 
 		i2c at 2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			adc2: nau7802 at 2a {
+				compatible = "nuvoton,nau7802";
+				reg = <0x2a>;
+				nuvoton,vldo = <3000>;
+			};
 		};
 
 		i2c at 3 {
-- 
1.7.10.4
