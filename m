From: jagan@openedev.com (Jagan Teki)
Date: Fri, 24 Mar 2017 21:48:45 +0530
Subject: [PATCH v2 10/15] ARM: dts: imx6dl-icore-rqs: Add sgtl5000 codec node
In-Reply-To: <1490372330-5611-1-git-send-email-jagan@openedev.com>
References: <1490372330-5611-1-git-send-email-jagan@openedev.com>
Message-ID: <1490372330-5611-11-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

- Moved sound card node on imx6qdl-icore-rqs.dtsi
- Added codec node in imx6dl-icore-rqs from imx6q-icore-rqs

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Newly added patch

 arch/arm/boot/dts/imx6dl-icore-rqs.dts   | 11 +++++++++++
 arch/arm/boot/dts/imx6q-icore-rqs.dts    | 13 -------------
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi | 13 +++++++++++++
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-icore-rqs.dts b/arch/arm/boot/dts/imx6dl-icore-rqs.dts
index cf42c2f..5b4c14c 100644
--- a/arch/arm/boot/dts/imx6dl-icore-rqs.dts
+++ b/arch/arm/boot/dts/imx6dl-icore-rqs.dts
@@ -49,3 +49,14 @@
 	model = "Engicam i.CoreM6 DualLite/Solo RQS Starter Kit";
 	compatible = "engicam,imx6-icore-rqs", "fsl,imx6dl";
 };
+
+&i2c3 {
+	codec: sgtl5000 at 0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		VDDA-supply = <&reg_2p5v>;
+		VDDIO-supply = <&reg_3p3v>;
+		VDDD-supply = <&reg_1p8v>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6q-icore-rqs.dts b/arch/arm/boot/dts/imx6q-icore-rqs.dts
index e451b4c..441a28e5 100644
--- a/arch/arm/boot/dts/imx6q-icore-rqs.dts
+++ b/arch/arm/boot/dts/imx6q-icore-rqs.dts
@@ -47,19 +47,6 @@
 / {
 	model = "Engicam i.CoreM6 Quad/Dual RQS Starter Kit";
 	compatible = "engicam,imx6-icore-rqs", "fsl,imx6q";
-
-	sound {
-		compatible = "fsl,imx-audio-sgtl5000";
-		model = "imx-audio-sgtl5000";
-		ssi-controller = <&ssi1>;
-		audio-codec = <&codec>;
-		audio-routing =
-			"MIC_IN", "Mic Jack",
-			"Mic Jack", "Mic Bias",
-			"Headphone Jack", "HP_OUT";
-		mux-int-port = <1>;
-		mux-ext-port = <4>;
-	};
 };
 
 &i2c3 {
diff --git a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
index 5fab5be..4032d38 100644
--- a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
@@ -118,6 +118,19 @@
 		clocks = <&clks IMX6QDL_CLK_LVDS2_GATE>;
 		clock-names = "refclk";
 	};
+
+	sound {
+		compatible = "fsl,imx-audio-sgtl5000";
+		model = "imx-audio-sgtl5000";
+		ssi-controller = <&ssi1>;
+		audio-codec = <&codec>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+		mux-int-port = <1>;
+		mux-ext-port = <4>;
+	};
 };
 
 &clks {
-- 
1.9.1
