From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  8 Sep 2016 09:43:00 +0200
Subject: [PATCH 04/30] arm64: dts: r8a7795: Add HSUSB device node
In-Reply-To: <cover.1473320411.git.horms+renesas@verge.net.au>
References: <cover.1473320411.git.horms+renesas@verge.net.au>
Message-ID: <d2422e1088128f7c7c93681dde7bafe4e52e9255.1473320411.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 834a12a13735..58376e72404b 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1228,6 +1228,23 @@
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
+
+		hsusb: usb at e6590000 {
+			compatible = "renesas,usbhs-r8a7795",
+				     "renesas,rcar-gen3-usbhs";
+			reg = <0 0xe6590000 0 0x100>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 704>;
+			dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
+			       <&usb_dmac1 0>, <&usb_dmac1 1>;
+			dma-names = "ch0", "ch1", "ch2", "ch3";
+			renesas,buswait = <11>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
 		pciec0: pcie at fe000000 {
 			compatible = "renesas,pcie-r8a7795";
 			reg = <0 0xfe000000 0 0x80000>;
-- 
2.7.0.rc3.207.g0ac5344
