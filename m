From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:03:23 +0200
Subject: [PATCH 31/31] arm64: dts: renesas: r8a7795: add hsusb ch3 device node
In-Reply-To: <cover.1501509525.git.horms+renesas@verge.net.au>
References: <cover.1501509525.git.horms+renesas@verge.net.au>
Message-ID: <4725f2b8805718a65dcbce8668710f145df797a8.1501509526.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds support for hsusb ch3 device nodes for R-Car H3 ES2.0.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi |  1 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi     | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
index 9743acad9b9c..aaa5e67a963e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -24,6 +24,7 @@
 	/delete-node/ usb-phy at ee0e0200;
 	/delete-node/ usb at ee0e0100;
 	/delete-node/ usb at ee0e0000;
+	/delete-node/ usb at e659c000;
 
 	/delete-node/ dma-controller at e6460000;
 	/delete-node/ dma-controller at e6470000;
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index f9735a3a736e..a87ae76880ab 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1733,6 +1733,23 @@
 			status = "disabled";
 		};
 
+		hsusb3: usb at e659c000 {
+			compatible = "renesas,usbhs-r8a7795",
+				     "renesas,rcar-gen3-usbhs";
+			reg = <0 0xe659c000 0 0x100>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 705>;
+			dmas = <&usb_dmac2 0>, <&usb_dmac2 1>,
+			       <&usb_dmac3 0>, <&usb_dmac3 1>;
+			dma-names = "ch0", "ch1", "ch2", "ch3";
+			renesas,buswait = <11>;
+			phys = <&usb2_phy3>;
+			phy-names = "usb";
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 705>;
+			status = "disabled";
+		};
+
 		pciec0: pcie at fe000000 {
 			compatible = "renesas,pcie-r8a7795",
 				     "renesas,pcie-rcar-gen3";
-- 
2.1.4
