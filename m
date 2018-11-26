From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:54:39 +0100
Subject: [PATCH 13/40] arm64: dts: renesas: r8a77990: add/enable USB3.0
 peripheral device node
In-Reply-To: <cover.1543229515.git.horms+renesas@verge.net.au>
References: <cover.1543229515.git.horms+renesas@verge.net.au>
Message-ID: <8dae1d2bbc128201bde30eee41940fab4c4f18c0.1543229515.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds/enables USB3.0 peripheral device node for r8a77990
ebisu board.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts |  5 +++++
 arch/arm64/boot/dts/renesas/r8a77990.dtsi      | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
index f342dd85b152..ff428a64341c 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
@@ -362,6 +362,11 @@
 	status = "okay";
 };
 
+&usb3_peri0 {
+	companion = <&xhci0>;
+	status = "okay";
+};
+
 &vin4 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index f969e680b9ba..cb83d866db7f 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -898,6 +898,17 @@
 			status = "disabled";
 		};
 
+		usb3_peri0: usb at ee020000 {
+			compatible = "renesas,r8a77990-usb3-peri",
+				     "renesas,rcar-gen3-usb3-peri";
+			reg = <0 0xee020000 0 0x400>;
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 328>;
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 328>;
+			status = "disabled";
+		};
+
 		ohci0: usb at ee080000 {
 			compatible = "generic-ohci";
 			reg = <0 0xee080000 0 0x100>;
-- 
2.11.0
