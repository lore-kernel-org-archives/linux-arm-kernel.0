From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:26:26 +0000
Subject: [PATCH RFC 08/46] imx-drm: add imx6 DT configuration for HDMI
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1Vypmc-0007E1-M4@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extracted from another patch by Fabio Estevam, this adds the DT
configuration for HDMI output on the IMX6 SoCs

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6dl.dtsi  |    4 ++++
 arch/arm/boot/dts/imx6q.dtsi   |    4 ++++
 arch/arm/boot/dts/imx6qdl.dtsi |   10 ++++++++++
 3 files changed, 18 insertions(+), 0 deletions(-)

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
1.7.4.4
