From: jagan@openedev.com (Jagan Teki)
Date: Fri, 24 Mar 2017 21:48:44 +0530
Subject: [PATCH v2 09/15] ARM: dts: imx6qdl-icore: Add Sound card with codec
 node
In-Reply-To: <1490372330-5611-1-git-send-email-jagan@openedev.com>
References: <1490372330-5611-1-git-send-email-jagan@openedev.com>
Message-ID: <1490372330-5611-10-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Add support for Sound card and related codec(via i2c1) nodes
on below Engicam module boards.
- i.CoreM6 DualLite/Solo Starter kit
- i.CoreM6 Quad/Dual Starter kit
- i.CoreM6 Quad/Dual OpenFrame Cap touch 10.1
- i.CoreM6 Quad/Dual OpenFrame Cap touch 12.3

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Use proper [label:] node-name[@unit-address] for codec

 arch/arm/boot/dts/imx6dl-icore.dts        | 11 +++++++++
 arch/arm/boot/dts/imx6q-icore-ofcap10.dts | 11 +++++++++
 arch/arm/boot/dts/imx6q-icore-ofcap12.dts | 11 +++++++++
 arch/arm/boot/dts/imx6q-icore.dts         | 11 +++++++++
 arch/arm/boot/dts/imx6qdl-icore.dtsi      | 37 +++++++++++++++++++++++++++++++
 5 files changed, 81 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-icore.dts b/arch/arm/boot/dts/imx6dl-icore.dts
index 6de83c7..0562ce4 100644
--- a/arch/arm/boot/dts/imx6dl-icore.dts
+++ b/arch/arm/boot/dts/imx6dl-icore.dts
@@ -57,3 +57,14 @@
 &can2 {
 	status = "okay";
 };
+
+&i2c3 {
+	sgtl5000: codec at a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		VDDA-supply = <&reg_2p5v>;
+		VDDIO-supply = <&reg_3p3v>;
+		VDDD-supply = <&reg_1p8v>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6q-icore-ofcap10.dts b/arch/arm/boot/dts/imx6q-icore-ofcap10.dts
index 49b60ca..f63b87f 100644
--- a/arch/arm/boot/dts/imx6q-icore-ofcap10.dts
+++ b/arch/arm/boot/dts/imx6q-icore-ofcap10.dts
@@ -50,6 +50,17 @@
 	compatible = "engicam,imx6-icore", "fsl,imx6q";
 };
 
+&i2c3 {
+	sgtl5000: codec at a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		VDDA-supply = <&reg_2p5v>;
+		VDDIO-supply = <&reg_3p3v>;
+		VDDD-supply = <&reg_1p8v>;
+	};
+};
+
 &ldb {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/imx6q-icore-ofcap12.dts b/arch/arm/boot/dts/imx6q-icore-ofcap12.dts
index 9e230f5..68ca828 100644
--- a/arch/arm/boot/dts/imx6q-icore-ofcap12.dts
+++ b/arch/arm/boot/dts/imx6q-icore-ofcap12.dts
@@ -50,6 +50,17 @@
 	compatible = "engicam,imx6-icore", "fsl,imx6q";
 };
 
+&i2c3 {
+	sgtl5000: codec at a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		VDDA-supply = <&reg_2p5v>;
+		VDDIO-supply = <&reg_3p3v>;
+		VDDD-supply = <&reg_1p8v>;
+	};
+};
+
 &ldb {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/imx6q-icore.dts b/arch/arm/boot/dts/imx6q-icore.dts
index 5613dd9..1ae7294 100644
--- a/arch/arm/boot/dts/imx6q-icore.dts
+++ b/arch/arm/boot/dts/imx6q-icore.dts
@@ -67,6 +67,17 @@
 	};
 };
 
+&i2c3 {
+	sgtl5000: codec at a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		VDDA-supply = <&reg_2p5v>;
+		VDDIO-supply = <&reg_3p3v>;
+		VDDD-supply = <&reg_1p8v>;
+	};
+};
+
 &ldb {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index 56d0c5d..09600eb 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -55,6 +55,25 @@
 		default-brightness-level = <7>;
 	};
 
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+
+	reg_2p5v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "2P5V";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	reg_3p3v: regulator-3p3v {
 		compatible = "regulator-fixed";
 		regulator-name = "3P3V";
@@ -87,6 +106,20 @@
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;  /* 25MHz for example */
 	};
+
+	sound {
+		compatible = "fsl,imx6-icore-sgtl5000",
+			     "fsl,imx-audio-sgtl5000";
+		model = "imx6q-icore-sgtl5000";
+		ssi-controller = <&ssi1>;
+		audio-codec = <&sgtl5000>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+		mux-int-port = <1>;
+		mux-ext-port = <4>;
+	};
 };
 
 &can1 {
@@ -149,6 +182,10 @@
 	status = "okay";
 };
 
+&ssi1 {
+	status = "okay";
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart4>;
-- 
1.9.1
