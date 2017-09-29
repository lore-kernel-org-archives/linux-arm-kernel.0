From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:52:26 +0200
Subject: [PATCH 17/22] arm64: dts: renesas: r8a77995: add USB2.0 Host
 (EHCI/OHCI) device node
In-Reply-To: <cover.1506678250.git.horms+renesas@verge.net.au>
References: <cover.1506678250.git.horms+renesas@verge.net.au>
Message-ID: <423254a1799bc7ea1f81db0b5e0c7eb1494c13f1.1506678250.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds USB2.0 Host (EHCI/OHCI) device node for r8a77995.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index 59ed1303bd93..56e42921e879 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -310,6 +310,31 @@
 			status = "disabled";
 		};
 
+		ehci0: usb at ee080100 {
+			compatible = "generic-ehci";
+			reg = <0 0xee080100 0 0x100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
+			companion = <&ohci0>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 703>;
+			status = "disabled";
+		};
+
+		ohci0: usb at ee080000 {
+			compatible = "generic-ohci";
+			reg = <0 0xee080000 0 0x100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 703>;
+			status = "disabled";
+		};
+
 		usb2_phy0: usb-phy at ee080200 {
 			compatible = "renesas,usb2-phy-r8a77995",
 				     "renesas,rcar-gen3-usb2-phy";
-- 
2.1.4
