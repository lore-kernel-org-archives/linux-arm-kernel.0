From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:03:21 +0200
Subject: [PATCH 29/31] arm64: dts: renesas: r8a7795: add usb2.0 host ch3
 device nodes
In-Reply-To: <cover.1501509525.git.horms+renesas@verge.net.au>
References: <cover.1501509525.git.horms+renesas@verge.net.au>
Message-ID: <4dad6dcdae7bdfb21377b6bccd13c51e70124970.1501509526.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds support for usb2.0 host ch3 device nodes for R-Car
H3 ES2.0.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi |  2 ++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi     | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
index 2c249430e1a4..1eccc7c795df 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -22,6 +22,8 @@
 	};
 
 	/delete-node/ usb-phy at ee0e0200;
+	/delete-node/ usb at ee0e0100;
+	/delete-node/ usb at ee0e0000;
 
 	fcpf2: fcp at fe952000 {
 		compatible = "renesas,fcpf";
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 0d9f311d15d1..cf9ed0d0a1fb 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1627,6 +1627,19 @@
 			status = "disabled";
 		};
 
+		ehci3: usb at ee0e0100 {
+			compatible = "generic-ehci";
+			reg = <0 0xee0e0100 0 0x100>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 700>;
+			phys = <&usb2_phy3>;
+			phy-names = "usb";
+			companion= <&ohci3>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 700>;
+			status = "disabled";
+		};
+
 		ohci0: usb at ee080000 {
 			compatible = "generic-ohci";
 			reg = <0 0xee080000 0 0x100>;
@@ -1663,6 +1676,18 @@
 			status = "disabled";
 		};
 
+		ohci3: usb at ee0e0000 {
+			compatible = "generic-ohci";
+			reg = <0 0xee0e0000 0 0x100>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 700>;
+			phys = <&usb2_phy3>;
+			phy-names = "usb";
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 700>;
+			status = "disabled";
+		};
+
 		hsusb: usb at e6590000 {
 			compatible = "renesas,usbhs-r8a7795",
 				     "renesas,rcar-gen3-usbhs";
-- 
2.1.4
