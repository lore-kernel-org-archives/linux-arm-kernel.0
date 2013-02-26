From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 26 Feb 2013 12:39:33 +0100
Subject: [PATCH v4 7/8] ARM i.MX5: Add system reset controller (SRC) to i.MX51
 and i.MX53 device tree
In-Reply-To: <1361878774-6382-1-git-send-email-p.zabel@pengutronix.de>
References: <1361878774-6382-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1361878774-6382-8-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also, link SRC to IPU via phandle.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/imx51.dtsi |    7 +++++++
 arch/arm/boot/dts/imx53.dtsi |    7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index fcf035b..cfe4e92 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -67,6 +67,7 @@
 			compatible = "fsl,imx51-ipu";
 			reg = <0x40000000 0x20000000>;
 			interrupts = <11 10>;
+			resets = <&src 2>;
 		};
 
 		aips at 70000000 { /* AIPS1 */
@@ -501,6 +502,12 @@
 				status = "disabled";
 			};
 
+			src: src at 73fd0000 {
+				compatible = "fsl,imx51-src";
+				reg = <0x73fd0000 0x4000>;
+				#reset-cells = <1>;
+			};
+
 			clks: ccm at 73fd4000{
 				compatible = "fsl,imx51-ccm";
 				reg = <0x73fd4000 0x4000>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index d05aa21..9e1348d 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -72,6 +72,7 @@
 			compatible = "fsl,imx53-ipu";
 			reg = <0x18000000 0x080000000>;
 			interrupts = <11 10>;
+			resets = <&src 2>;
 		};
 
 		aips at 50000000 { /* AIPS1 */
@@ -558,6 +559,12 @@
 				status = "disabled";
 			};
 
+			src: src at 53fd0000 {
+				compatible = "fsl,imx53-src", "fsl,imx51-src";
+				reg = <0x53fd0000 0x4000>;
+				#reset-cells = <1>;
+			};
+
 			clks: ccm at 53fd4000{
 				compatible = "fsl,imx53-ccm";
 				reg = <0x53fd4000 0x4000>;
-- 
1.7.10.4
