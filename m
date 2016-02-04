From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:29:39 +0100
Subject: [PATCH 2/8] arm64: dts: r8a7795: Add USB3.0 host device nodes
In-Reply-To: <cover.1454595726.git.horms+renesas@verge.net.au>
References: <cover.1454595726.git.horms+renesas@verge.net.au>
Message-ID: <171f2ef82284f61b763a620747806ec2724d1a84.1454595726.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 221a8f5d24af..119549e6502d 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -862,5 +862,23 @@
 			clocks = <&cpg CPG_MOD 815>;
 			status = "disabled";
 		};
+
+		xhci0: usb at ee000000 {
+			compatible = "renesas,xhci-r8a7795";
+			reg = <0 0xee000000 0 0xc00>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 328>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		xhci1: usb at ee0400000 {
+			compatible = "renesas,xhci-r8a7795";
+			reg = <0 0xee040000 0 0xc00>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 327>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.7.0.rc3.207.g0ac5344
