From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 11:29:57 +0100
Subject: [PATCH 19/37] ARM: dts: iwg20d-q7-common: Enable SGTL5000 audio codec
In-Reply-To: <cover.1513938145.git.horms+renesas@verge.net.au>
References: <cover.1513938145.git.horms+renesas@verge.net.au>
Message-ID: <3091626868981e086f57d580cb1711b4553c5663.1513938145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

This patch enables SGTL5000 audio codec on the carrier board.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/iwg20d-q7-common.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
index 54470c6de891..03d41a736afd 100644
--- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
@@ -20,6 +20,20 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	audio_clock: audio_clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+	};
+
+	reg_1p5v: 1p5v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P5V";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-always-on;
+	};
+
 	vcc_sdhi1: regulator-vcc-sdhi1 {
 		compatible = "regulator-fixed";
 
@@ -83,6 +97,16 @@
 		compatible = "ti,bq32000";
 		reg = <0x68>;
 	};
+
+	sgtl5000: codec at a {
+		compatible = "fsl,sgtl5000";
+		#sound-dai-cells = <0>;
+		reg = <0x0a>;
+		clocks = <&audio_clock>;
+		VDDA-supply = <&reg_3p3v>;
+		VDDIO-supply = <&reg_3p3v>;
+		VDDD-supply = <&reg_1p5v>;
+	};
 };
 
 &pci0 {
-- 
2.11.0
