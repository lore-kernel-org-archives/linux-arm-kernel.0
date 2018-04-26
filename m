From: kieran.bingham+renesas@ideasonboard.com (Kieran Bingham)
Date: Thu, 26 Apr 2018 17:53:41 +0100
Subject: [PATCH 12/17] arm64: dts: r8a77965: Populate the DU instance
 placeholder
In-Reply-To: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
Message-ID: <20180426165346.494-13-kieran.bingham+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DU entity node has been previously added but only as a placeholder.
Populate the node with the properties to use the device.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index e92e6b03333a..8a40bba53027 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -1106,9 +1106,21 @@
 		};
 
 		du: display at feb00000 {
+			compatible = "renesas,du-r8a77965";
 			reg = <0 0xfeb00000 0 0x80000>,
 			      <0 0xfeb90000 0 0x14>;
-			/* placeholder */
+			reg-names = "du", "lvds.0";
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 724>,
+				 <&cpg CPG_MOD 723>,
+				 <&cpg CPG_MOD 721>,
+				 <&cpg CPG_MOD 727>;
+			clock-names = "du.0", "du.1", "du.3", "lvds.0";
+			status = "disabled";
+
+			vsps = <&vspd0 0 &vspd1 0 &vspd0 1>;
 
 			ports {
 				#address-cells = <1>;
-- 
2.17.0
