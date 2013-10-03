From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 3 Oct 2013 15:51:26 -0300
Subject: [PATCH v2 2/3] ARM: dts: imx6qdl-wandboard: Add HDMI support
In-Reply-To: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1380826287-30253-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None

 arch/arm/boot/dts/imx6dl.dtsi            |  4 ++++
 arch/arm/boot/dts/imx6q.dtsi             |  4 ++++
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi | 13 +++++++++++++
 arch/arm/boot/dts/imx6qdl.dtsi           | 10 ++++++++++
 4 files changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 9e8ae11..65e54b4 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -88,3 +88,7 @@
 		crtcs = <&ipu1 0>, <&ipu1 1>;
 	};
 };
+
+&hdmi {
+	crtcs = <&ipu1 0>, <&ipu1 1>;
+}
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index f024ef2..d2467f5 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -159,3 +159,7 @@
 		crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
 	};
 };
+
+&hdmi {
+	crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
+};
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index a55113e..758c17f 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -51,6 +51,19 @@
 	status = "okay";
 };
 
+
+&hdmi {
+	ddc = <&i2c1>;
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1_1>;
+	status = "okay";
+};
+
 &i2c2 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index ccd55c2..b148cb3 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1301,6 +1301,16 @@
 				};
 			};
 
+			hdmi: hdmi at 0120000 {
+				compatible = "fsl,imx6q-hdmi";
+				reg = <0x00120000 0x9000>;
+				interrupts = <0 115 0x04>;
+				gpr = <&gpr>;
+				clocks = <&clks 123>, <&clks 124>;
+				clock-names = "iahb", "isfr";
+				status = "disabled";
+			};
+
 			dcic1: dcic at 020e4000 {
 				reg = <0x020e4000 0x4000>;
 				interrupts = <0 124 0x04>;
-- 
1.8.1.2
