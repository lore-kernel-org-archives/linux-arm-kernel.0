From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Wed, 19 Feb 2014 15:42:30 +0800
Subject: [PATCH v2 3/4] ARM: dts: vf610-twr: Enable SGTL5000 codec.
In-Reply-To: <1392795751-13351-1-git-send-email-Li.Xiubo@freescale.com>
References: <1392795751-13351-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1392795751-13351-4-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds and enables SGTL5000 codec support.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/vf610-twr.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index bcee3bb..0f4bff5 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -34,6 +34,20 @@
 		};
 	};
 
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_3p3v: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
 };
 
 &dspi0 {
@@ -72,6 +86,14 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c0>;
 	status = "okay";
+
+	codec: sgtl5000 at 0a {
+	       compatible = "fsl,sgtl5000";
+	       reg = <0x0a>;
+	       VDDA-supply = <&reg_3p3v>;
+	       VDDIO-supply = <&reg_3p3v>;
+	       clocks = <&clks VF610_CLK_SAI2>;
+       };
 };
 
 &iomuxc {
-- 
1.8.4
