From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Sep 2016 09:50:05 +0200
Subject: [PATCH 18/26] ARM: dts: r7s72100: add ethernet to device tree
In-Reply-To: <cover.1473234371.git.horms+renesas@verge.net.au>
References: <cover.1473234371.git.horms+renesas@verge.net.au>
Message-ID: <e54824019155a609eb3547ce07721c96d9e790ac.1473234372.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 6d29e8ffa0d9..fb9ef9ca120e 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -428,4 +428,17 @@
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
+
+	ether: ethernet at e8203000 {
+		compatible = "renesas,ether-r7s72100";
+		reg = <0xe8203000 0x800>,
+		      <0xe8204800 0x200>;
+		interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R7S72100_CLK_ETHER>;
+		power-domains = <&cpg_clocks>;
+		phy-mode = "mii";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
 };
-- 
2.7.0.rc3.207.g0ac5344
