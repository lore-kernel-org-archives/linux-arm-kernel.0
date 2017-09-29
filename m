From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:52:25 +0200
Subject: [PATCH 16/22] arm64: dts: renesas: r8a77995: Add USB2.0 PHY device
 node
In-Reply-To: <cover.1506678250.git.horms+renesas@verge.net.au>
References: <cover.1506678250.git.horms+renesas@verge.net.au>
Message-ID: <a0ea7fe8d34cbede9928b44e9a6b1dcd3f0150d1.1506678250.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds USB2.0 PHY device node for r8a77995.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index 72d04d7337be..59ed1303bd93 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -309,5 +309,17 @@
 			resets = <&cpg 310>;
 			status = "disabled";
 		};
+
+		usb2_phy0: usb-phy at ee080200 {
+			compatible = "renesas,usb2-phy-r8a77995",
+				     "renesas,rcar-gen3-usb2-phy";
+			reg = <0 0xee080200 0 0x700>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 703>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.1.4
