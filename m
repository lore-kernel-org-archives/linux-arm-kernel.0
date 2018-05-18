From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:49 +0200
Subject: [PATCH 087/102] arm64: dts: renesas: r8a77995: Add VIN4
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <d86bd47fefbb6e4db53d733fe95bc13bc9ddedb1.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Describe VIN4 interface for R-Car D3 R8A77995 SoC.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Acked-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
[simon: sorted node by bus address]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index ba98865b0c9b..2506f46293e8 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -610,6 +610,17 @@
 			status = "disabled";
 		};
 
+		vin4: video at e6ef4000 {
+			compatible = "renesas,vin-r8a77995";
+			reg = <0 0xe6ef4000 0 0x1000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 807>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 807>;
+			renesas,id = <4>;
+			status = "disabled";
+		};
+
 		ohci0: usb at ee080000 {
 			compatible = "generic-ohci";
 			reg = <0 0xee080000 0 0x100>;
-- 
2.11.0
