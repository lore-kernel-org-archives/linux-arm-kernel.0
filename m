From: martin@kaiser.cx (Martin Kaiser)
Date: Mon,  3 Apr 2017 21:47:04 +0200
Subject: [PATCH 1/2 v4] ARM: dts: i.MX25: add AIPS control registers
In-Reply-To: <1485890402-22974-1-git-send-email-martin@kaiser.cx>
References: <1485890402-22974-1-git-send-email-martin@kaiser.cx>
Message-ID: <1491248825-23041-1-git-send-email-martin@kaiser.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX25 contains two AHB to IP bridges (AIPS), each of which has a set of
control registers. Add the memory regions for the control registers to
the Device Tree.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
v4:
   rebased against latest linux-next
   re-sending both patches, it seems they got lost along the way

v3:
   fixed the size of the memory regions, both are 16KBytes long

v2:
   removed the "fsl,imx53-aipstz" property as per Sascha's request

 arch/arm/boot/dts/imx25.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 89c8f8f..0cdf333 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -93,6 +93,11 @@
 			reg = <0x43f00000 0x100000>;
 			ranges;
 
+			aips1: bridge at 43f00000 {
+				compatible = "fsl,imx25-aips";
+				reg = <0x43f00000 0x4000>;
+			};
+
 			i2c1: i2c at 43f80000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -342,6 +347,11 @@
 			reg = <0x53f00000 0x100000>;
 			ranges;
 
+			aips2: bridge at 53f00000 {
+				compatible = "fsl,imx25-aips";
+				reg = <0x53f00000 0x4000>;
+			};
+
 			clks: ccm at 53f80000 {
 				compatible = "fsl,imx25-ccm";
 				reg = <0x53f80000 0x4000>;
-- 
2.1.4
