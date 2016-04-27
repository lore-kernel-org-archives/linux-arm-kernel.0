From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 26 Apr 2016 22:28:29 -0300
Subject: [PATCH] ARM: dts: imx6: Do not hardcode the CLKO clock
Message-ID: <1461720509-8890-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Using "IMX6QDL_CLK_CKO" for the clock is easier to read instead of
the hardcoded clock number.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6dl-riotboard.dts       | 2 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts         | 2 +-
 arch/arm/boot/dts/imx6q-tbs2910.dts          | 2 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi        | 2 +-
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi       | 2 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi        | 2 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi        | 2 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi        | 2 +-
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi     | 2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi | 2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi    | 2 +-
 arch/arm/boot/dts/imx6qdl-rex.dtsi           | 2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi     | 2 +-
 arch/arm/boot/dts/imx6qdl-udoo.dtsi          | 2 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi     | 2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts/imx6dl-riotboard.dts
index 5111f51..bfbed52 100644
--- a/arch/arm/boot/dts/imx6dl-riotboard.dts
+++ b/arch/arm/boot/dts/imx6dl-riotboard.dts
@@ -114,7 +114,7 @@
 	codec: sgtl5000 at 0a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
-		clocks = <&clks 201>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply = <&reg_2p5v>;
 		VDDIO-supply = <&reg_3p3v>;
 	};
diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index a51834e..0511137 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -327,7 +327,7 @@
 	codec: sgtl5000 at 0a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
-		clocks = <&clks 201>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply = <&sw4_reg>;
 		VDDIO-supply = <&reg_3p3v>;
 	};
diff --git a/arch/arm/boot/dts/imx6q-tbs2910.dts b/arch/arm/boot/dts/imx6q-tbs2910.dts
index 2401c6b..1926b13 100644
--- a/arch/arm/boot/dts/imx6q-tbs2910.dts
+++ b/arch/arm/boot/dts/imx6q-tbs2910.dts
@@ -159,7 +159,7 @@
 	status = "okay";
 
 	sgtl5000: sgtl5000 at 0a {
-		clocks = <&clks 201>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
 		compatible = "fsl,sgtl5000";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_sgtl5000>;
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index b33e5a9..922b1dd 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -324,7 +324,7 @@
 	codec: sgtl5000 at 0a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
-		clocks = <&clks 201>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply = <&reg_2p5v>;
 		VDDIO-supply = <&reg_3p3v>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
index a8f3500..865c9a2 100644
--- a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
@@ -213,7 +213,7 @@
 	codec: sgtl5000 at 0a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
-		clocks = <&clks 201>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply = <&reg_3p3v>;
 		VDDIO-supply = <&reg_3p3v>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 8dd74e9..7191b84 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -244,7 +244,7 @@
 	codec: sgtl5000 at 0a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
-		clocks = <&clks 201>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply = <&reg_1p8v>;
 		VDDIO-supply = <&reg_3p3v>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index ec3fe74..40d06b0 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -237,7 +237,7 @@
 	codec: sgtl5000 at 0a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
-		clocks = <&clks 201>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply = <&reg_1p8v>;
 		VDDIO-supply = <&reg_3p3v>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 367cc49..d6dbe2a 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -328,7 +328,7 @@
 	codec: sgtl5000 at 0a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
-		clocks = <&clks 201>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply = <&sw4_reg>;
 		VDDIO-supply = <&reg_3p3v>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
index 24d7d3f..e456b5c 100644
--- a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
@@ -269,7 +269,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_sgtl5000>;
 		reg = <0x0a>;
-		clocks = <&clks 201>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply = <&reg_2p5v>;
 		VDDIO-supply = <&reg_3p3v>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
index dc74aa3..657da6b 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -402,7 +402,7 @@
 	codec: sgtl5000 at 0a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
-		clocks = <&clks 201>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply = <&reg_2p5v>;
 		VDDIO-supply = <&reg_3p3v>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index c6c590d..73915db 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -304,7 +304,7 @@
 	codec: sgtl5000 at 0a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
-		clocks = <&clks 201>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply = <&reg_2p5v>;
 		VDDIO-supply = <&reg_3p3v>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-rex.dtsi b/arch/arm/boot/dts/imx6qdl-rex.dtsi
index a503562..cacf593 100644
--- a/arch/arm/boot/dts/imx6qdl-rex.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-rex.dtsi
@@ -126,7 +126,7 @@
 	codec: sgtl5000 at 0a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
-		clocks = <&clks 201>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply = <&reg_3p3v>;
 		VDDIO-supply = <&reg_3p3v>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 0f1aca4..c47fe6c 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -290,7 +290,7 @@
 	codec: sgtl5000 at 0a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
-		clocks = <&clks 201>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply = <&reg_2p5v>;
 		VDDIO-supply = <&reg_3p3v>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
index 0dd5aa1..3bee2f9 100644
--- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
@@ -260,7 +260,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbh>;
 	vbus-supply = <&reg_usb_h1_vbus>;
-	clocks = <&clks 201>;
+	clocks = <&clks IMX6QDL_CLK_CKO>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index 9e096d8..8e7c40e 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -85,7 +85,7 @@
 	codec: sgtl5000 at 0a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
-		clocks = <&clks 201>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply = <&reg_2p5v>;
 		VDDIO-supply = <&reg_3p3v>;
 	};
-- 
1.9.1
