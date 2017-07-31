From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:03:20 +0200
Subject: [PATCH 28/31] arm64: dts: renesas: r8a7795: add usb2_phy ch3 device
 node
In-Reply-To: <cover.1501509525.git.horms+renesas@verge.net.au>
References: <cover.1501509525.git.horms+renesas@verge.net.au>
Message-ID: <ac29cc445c72e688b913dd4b8b0bec982dcf6e95.1501509526.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds support for usb3_phy ch3 device node for R-Car H3 ES2.0.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi |  2 ++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi     | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
index f1646334899f..2c249430e1a4 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -21,6 +21,8 @@
 		status = "disabled";
 	};
 
+	/delete-node/ usb-phy at ee0e0200;
+
 	fcpf2: fcp at fe952000 {
 		compatible = "renesas,fcpf";
 		reg = <0 0xfe952000 0 0x200>;
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 7246e689b619..0d9f311d15d1 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1576,6 +1576,18 @@
 			status = "disabled";
 		};
 
+		usb2_phy3: usb-phy at ee0e0200 {
+			compatible = "renesas,usb2-phy-r8a7795",
+				     "renesas,rcar-gen3-usb2-phy";
+			reg = <0 0xee0e0200 0 0x700>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 700>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 700>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		ehci0: usb at ee080100 {
 			compatible = "generic-ehci";
 			reg = <0 0xee080100 0 0x100>;
-- 
2.1.4
