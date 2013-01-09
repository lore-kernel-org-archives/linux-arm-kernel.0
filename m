From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed,  9 Jan 2013 18:17:19 +0100
Subject: [RFC PATCH 5/5] ARM i.MX5: Add system reset controller (SRC) to
 i.MX51 and i.MX53 device tree
In-Reply-To: <1357751839-19680-1-git-send-email-p.zabel@pengutronix.de>
References: <1357751839-19680-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1357751839-19680-6-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also, link SRC to IPU via phandle.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx51.dtsi |    6 ++++++
 arch/arm/boot/dts/imx53.dtsi |    9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 1f5d45e..b3e9742 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -448,6 +448,12 @@
 				status = "disabled";
 			};
 
+			src: src at 73fd0000 {
+				compatible = "fsl,imx5-src";
+				reg = <0x73fd0000 0x4000>;
+				#reset-cells = <1>;
+			};
+
 			clks: ccm at 73fd4000{
 				compatible = "fsl,imx51-ccm";
 				reg = <0x73fd4000 0x4000>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index edc3f1e..7266942 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -72,6 +72,9 @@
 			compatible = "fsl,imx53-ipu";
 			reg = <0x18000000 0x080000000>;
 			interrupts = <11 10>;
+			clocks = <&clks 59>, <&clks 110>, <&clks 61>;
+			clock-names = "bus", "di0", "di1";
+			reset = <&src 2>;
 		};
 
 		aips at 50000000 { /* AIPS1 */
@@ -497,6 +500,12 @@
 				status = "disabled";
 			};
 
+			src: src at 53fd0000 {
+				compatible = "fsl,imx5-src";
+				reg = <0x53fd0000 0x4000>;
+				#reset-cells = <1>;
+			};
+
 			clks: ccm at 53fd4000{
 				compatible = "fsl,imx53-ccm";
 				reg = <0x53fd4000 0x4000>;
-- 
1.7.10.4
