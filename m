From: robh@kernel.org (Rob Herring)
Date: Thu,  1 Mar 2018 14:25:33 -0600
Subject: [PATCH] arm: dts: imx: Add missing #sound-dai-cells for sgtl5000 codec
Message-ID: <20180301202537.30571-1-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc now warns about missing #sound-dai-cells:

arch/arm/boot/dts/imx6ul-geam.dtb: Warning (sound_dai_property): /sound/simple-audio-card,codec: Missing property '#sound-dai-cells' in node /soc/aips-bus at 2100000/i2c at 21a0000/codec at a or bad phandle (referred from sound-dai[0])
arch/arm/boot/dts/imx6ul-isiot-emmc.dtb: Warning (sound_dai_property): /sound/simple-audio-card,codec: Missing property '#sound-dai-cells' in node /soc/aips-bus at 2100000/i2c at 21a0000/codec at a or bad phandle (referred from sound-dai[0])
arch/arm/boot/dts/imx6ul-isiot-nand.dtb: Warning (sound_dai_property): /sound/simple-audio-card,codec: Missing property '#sound-dai-cells' in node /soc/aips-bus at 2100000/i2c at 21a0000/codec at a or bad phandle (referred from sound-dai[0])

Lots of i.MX boards use the SGTL5000 codec, but not all get the warning
because only some reference the codec with "sound-dai" property. However,
the codec should always provide #sound-dai-cells regardless, so fix all
the occurrences.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/imx28-apx4devkit.dts       | 1 +
 arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi | 1 +
 arch/arm/boot/dts/imx28-evk.dts              | 1 +
 arch/arm/boot/dts/imx28-m28evk.dts           | 1 +
 arch/arm/boot/dts/imx51-babbage.dts          | 1 +
 arch/arm/boot/dts/imx53-m53evk.dts           | 1 +
 arch/arm/boot/dts/imx53-ppd.dts              | 1 +
 arch/arm/boot/dts/imx53-qsb-common.dtsi      | 1 +
 arch/arm/boot/dts/imx53-tx53-x03x.dts        | 1 +
 arch/arm/boot/dts/imx53-tx53-x13x.dts        | 1 +
 arch/arm/boot/dts/imx53-voipac-bsb.dts       | 1 +
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi        | 1 +
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 1 +
 arch/arm/boot/dts/imx6ul-geam.dts            | 1 +
 14 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts b/arch/arm/boot/dts/imx28-apx4devkit.dts
index ae078341fb60..552ab577f1b0 100644
--- a/arch/arm/boot/dts/imx28-apx4devkit.dts
+++ b/arch/arm/boot/dts/imx28-apx4devkit.dts
@@ -146,6 +146,7 @@
 				sgtl5000: codec at a {
 					compatible = "fsl,sgtl5000";
 					reg = <0x0a>;
+					#sound-dai-cells = <0>;
 					VDDA-supply = <&reg_3p3v>;
 					VDDIO-supply = <&reg_3p3v>;
 					clocks = <&saif0>;
diff --git a/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi b/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
index 49ab40838e69..ff1328ce7d37 100644
--- a/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
+++ b/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
@@ -151,6 +151,7 @@
 	sgtl5000: codec at a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
+		#sound-dai-cells = <0>;
 		VDDA-supply = <&reg_3p3v>;
 		VDDIO-supply = <&reg_3p3v>;
 		clocks = <&saif0>;
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 7f5b80402c54..bc099610cd76 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -197,6 +197,7 @@
 				sgtl5000: codec at a {
 					compatible = "fsl,sgtl5000";
 					reg = <0x0a>;
+					#sound-dai-cells = <0>;
 					VDDA-supply = <&reg_3p3v>;
 					VDDIO-supply = <&reg_3p3v>;
 					clocks = <&saif0>;
diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index 22aa025cab1e..7d97a0ce74a3 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -140,6 +140,7 @@
 				sgtl5000: codec at a {
 					compatible = "fsl,sgtl5000";
 					reg = <0x0a>;
+					#sound-dai-cells = <0>;
 					VDDA-supply = <&reg_3p3v>;
 					VDDIO-supply = <&reg_3p3v>;
 					clocks = <&saif0>;
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 4ac5ab614a7f..0b46e9726650 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -369,6 +369,7 @@
 	sgtl5000: codec at a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
+		#sound-dai-cells = <0>;
 		clocks = <&clk_audio>;
 		VDDA-supply = <&vdig_reg>;
 		VDDIO-supply = <&vvideo_reg>;
diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index e48525763b1b..3935fe6490ed 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -153,6 +153,7 @@
 	sgtl5000: codec at a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
+		#sound-dai-cells = <0>;
 		VDDA-supply = <&reg_3p2v>;
 		VDDIO-supply = <&reg_3p2v>;
 		clocks = <&clks IMX5_CLK_SSI_EXT1_GATE>;
diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index cce959438a79..c37418108e88 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -436,6 +436,7 @@
 			sgtl5000: codec at a {
 				compatible = "fsl,sgtl5000";
 				reg = <0xa>;
+				#sound-dai-cells = <0>;
 				VDDA-supply = <&reg_sgtl5k>;
 				VDDIO-supply = <&reg_sgtl5k>;
 				clocks = <&cko2_11M>;
diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index 41a2e2a2b079..2cf41fec282b 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -317,6 +317,7 @@
 	sgtl5000: codec at a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
+		#sound-dai-cells = <0>;
 		VDDA-supply = <&reg_3p2v>;
 		VDDIO-supply = <&reg_3p2v>;
 		clocks = <&clks IMX5_CLK_SSI_EXT1_GATE>;
diff --git a/arch/arm/boot/dts/imx53-tx53-x03x.dts b/arch/arm/boot/dts/imx53-tx53-x03x.dts
index fe15c9555d6e..af8ec5e4417b 100644
--- a/arch/arm/boot/dts/imx53-tx53-x03x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x03x.dts
@@ -230,6 +230,7 @@
 	sgtl5000: codec at a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
+		#sound-dai-cells = <0>;
 		VDDA-supply = <&reg_2v5>;
 		VDDIO-supply = <&reg_3v3>;
 		clocks = <&mclk>;
diff --git a/arch/arm/boot/dts/imx53-tx53-x13x.dts b/arch/arm/boot/dts/imx53-tx53-x13x.dts
index f2b2ad3ce9e5..6cdf2082c742 100644
--- a/arch/arm/boot/dts/imx53-tx53-x13x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x13x.dts
@@ -131,6 +131,7 @@
 	sgtl5000: codec at a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
+		#sound-dai-cells = <0>;
 		VDDA-supply = <&reg_2v5>;
 		VDDIO-supply = <&reg_3v3>;
 		clocks = <&mclk>;
diff --git a/arch/arm/boot/dts/imx53-voipac-bsb.dts b/arch/arm/boot/dts/imx53-voipac-bsb.dts
index 25c78f19826c..957053755c3c 100644
--- a/arch/arm/boot/dts/imx53-voipac-bsb.dts
+++ b/arch/arm/boot/dts/imx53-voipac-bsb.dts
@@ -133,6 +133,7 @@
 	sgtl5000: codec at a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
+		#sound-dai-cells = <0>;
 		VDDA-supply = <&reg_3p3v>;
 		VDDIO-supply = <&reg_3p3v>;
 		clocks = <&clks 150>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
index d894dde6e85d..b5986efe1090 100644
--- a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
@@ -288,6 +288,7 @@
 	sgtl5000: codec at a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
+		#sound-dai-cells = <0>;
 		clocks = <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply = <&reg_1p8v>;
 		VDDIO-supply = <&reg_3p3v>;
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index dffbc92e0023..8dcf3bb96e79 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -191,6 +191,7 @@
 	sgtl5000: codec at a {
 		clocks = <&clks IMX6QDL_CLK_CKO>;
 		compatible = "fsl,sgtl5000";
+		#sound-dai-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_hummingboard2_sgtl5000>;
 		reg = <0x0a>;
diff --git a/arch/arm/boot/dts/imx6ul-geam.dts b/arch/arm/boot/dts/imx6ul-geam.dts
index 571eea7f1c6b..aee6cf39cb76 100644
--- a/arch/arm/boot/dts/imx6ul-geam.dts
+++ b/arch/arm/boot/dts/imx6ul-geam.dts
@@ -181,6 +181,7 @@
 	sgtl5000: codec at a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
+		#sound-dai-cells = <0>;
 		clocks = <&clks IMX6UL_CLK_OSC>;
 		clock-names = "mclk";
 		VDDA-supply = <&reg_3p3v>;
-- 
2.14.1
