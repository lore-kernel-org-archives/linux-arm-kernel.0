From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 2 Jul 2015 17:06:22 +0300
Subject: [PATCH v2 07/20] ARM: DTS: am43xx-epos-evm: Add node for
 tlv320aic3111 audio codec
In-Reply-To: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
References: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1435845995-19085-8-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Analog audio is using this codec on the board.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 11fced01975d..d171e734d3cf 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -14,6 +14,7 @@
 #include <dt-bindings/pinctrl/am43xx.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/sound/tlv320aic31xx-micbias.h>
 
 / {
 	model = "TI AM43x EPOS EVM";
@@ -465,6 +466,22 @@
 		touchscreen-size-x = <1024>;
 		touchscreen-size-y = <600>;
 	};
+
+	tlv320aic3111: tlv320aic3111 at 18 {
+		compatible = "ti,tlv320aic3111";
+		reg = <0x18>;
+		status = "okay";
+
+		ai31xx-micbias-vg = <MICBIAS_2_0V>;
+
+		/* Regulators */
+		HPVDD-supply = <&dcdc4>; /* v3_3AUD -> V3_3D -> DCDC4 */
+		SPRVDD-supply = <&vbat>; /* vbat */
+		SPLVDD-supply = <&vbat>; /* vbat */
+		AVDD-supply = <&dcdc4>; /* v3_3AUD -> V3_3D -> DCDC4 */
+		IOVDD-supply = <&dcdc4>; /* V3_3D -> DCDC4 */
+		DVDD-supply = <&ldo1>; /* V1_8AUD -> V1_8D -> LDO1 */
+	};
 };
 
 &i2c2 {
-- 
2.4.5
