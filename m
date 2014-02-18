From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 18 Feb 2014 20:10:27 +0000
Subject: [PATCH 10/34] imx-drm: update and fix imx6 DT descriptions for v3
 HDMI driver
In-Reply-To: <20140218200900.GM21483@n2100.arm.linux.org.uk>
References: <20140218200900.GM21483@n2100.arm.linux.org.uk>
Message-ID: <E1WFqzr-0007ip-Qk@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6dl.dtsi  | 3 ++-
 arch/arm/boot/dts/imx6q.dtsi   | 1 +
 arch/arm/boot/dts/imx6qdl.dtsi | 1 -
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 65e54b4529c5..6dc397022214 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -90,5 +90,6 @@
 };
 
 &hdmi {
+	compatible = "fsl,imx6dl-hdmi";
 	crtcs = <&ipu1 0>, <&ipu1 1>;
-}
+};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index d2467f532de6..187fe33ba515 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -161,5 +161,6 @@
 };
 
 &hdmi {
+	compatible = "fsl,imx6q-hdmi";
 	crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
 };
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 400bbc624f25..930ebe0c2937 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1369,7 +1369,6 @@
 			};
 
 			hdmi: hdmi at 0120000 {
-				compatible = "fsl,imx6q-hdmi";
 				reg = <0x00120000 0x9000>;
 				interrupts = <0 115 0x04>;
 				gpr = <&gpr>;
-- 
1.8.3.1
