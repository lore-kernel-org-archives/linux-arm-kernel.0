From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 09:07:44 +0900
Subject: [PATCH 11/14] arm64: dts: r8a7795: add usb2_phy device nodes
In-Reply-To: <cover.1456445161.git.horms+renesas@verge.net.au>
References: <cover.1456445161.git.horms+renesas@verge.net.au>
Message-ID: <5923bb5227e5601a2e71da2b0d870b840bdfee9d.1456445161.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index e9adb31cd48c..c6e379000e90 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1024,5 +1024,33 @@
 			cap-mmc-highspeed;
 			status = "disabled";
 		};
+
+		usb2_phy0: usb-phy at ee080200 {
+			compatible = "renesas,usb2-phy-r8a7795";
+			reg = <0 0xee080200 0 0x700>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>;
+			power-domains = <&cpg>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		usb2_phy1: usb-phy at ee0a0200 {
+			compatible = "renesas,usb2-phy-r8a7795";
+			reg = <0 0xee0a0200 0 0x700>;
+			clocks = <&cpg CPG_MOD 702>;
+			power-domains = <&cpg>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		usb2_phy2: usb-phy at ee0c0200 {
+			compatible = "renesas,usb2-phy-r8a7795";
+			reg = <0 0xee0c0200 0 0x700>;
+			clocks = <&cpg CPG_MOD 701>;
+			power-domains = <&cpg>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.7.0.rc3.207.g0ac5344
