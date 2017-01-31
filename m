From: martin@kaiser.cx (Martin Kaiser)
Date: Tue, 31 Jan 2017 20:20:01 +0100
Subject: [PATCH 1/2] ARM: dts: i.MX25: add AIPS control registers
Message-ID: <1485890402-22974-1-git-send-email-martin@kaiser.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX25 contains two AHB to IP bridges (AIPS), each of which has a set of
control registers. Add the memory regions for the control registers to
the Device Tree.

All the registers from the i.MX53 AIPSTZ are present on the i.MX25 as
well. Indicate that we are compatible to fsl,imx53-aipstz. However,
don't use aipstz for our name, this seems to be specific to i.MX53.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 arch/arm/boot/dts/imx25.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index e0ba550..4c4768f 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -93,6 +93,11 @@
 			reg = <0x43f00000 0x100000>;
 			ranges;
 
+			aips1: bridge at 43f00000 {
+				compatible = "fsl,imx25-aips", "fsl,imx53-aipstz";
+				reg = <0x43f00000 0x60>;
+			};
+
 			i2c1: i2c at 43f80000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -342,6 +347,11 @@
 			reg = <0x53f00000 0x100000>;
 			ranges;
 
+			aips2: bridge at 53f00000 {
+				compatible = "fsl,imx25-aips", "fsl,imx53-aipstz";
+				reg = <0x53f00000 0x60>;
+			};
+
 			clks: ccm at 53f80000 {
 				compatible = "fsl,imx25-ccm";
 				reg = <0x53f80000 0x4000>;
-- 
2.1.4
