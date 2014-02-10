From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 10 Feb 2014 12:29:53 +0000
Subject: [PATCH RFC v2 13/35] imx-drm: add imx6 DT configuration for HDMI
In-Reply-To: <20140210122802.GS26684@n2100.arm.linux.org.uk>
References: <20140210122802.GS26684@n2100.arm.linux.org.uk>
Message-ID: <E1WCpzl-0007O1-BK@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extracted from another patch by Fabio Estevam, this adds the DT
configuration for HDMI output on the IMX6 SoCs

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6dl.dtsi  |  4 ++++
 arch/arm/boot/dts/imx6q.dtsi   |  4 ++++
 arch/arm/boot/dts/imx6qdl.dtsi | 10 ++++++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 9e8ae118fdd4..65e54b4529c5 100644
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
index f024ef28b34b..d2467f532de6 100644
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
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index fb28b2ecb1db..400bbc624f25 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1368,6 +1368,16 @@
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
1.8.3.1
