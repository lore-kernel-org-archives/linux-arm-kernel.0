From: chris.brandt@renesas.com (Chris Brandt)
Date: Thu,  1 Sep 2016 21:40:11 -0400
Subject: [PATCH v2 2/3] ARM: dts: r7s72100: add ethernet to device tree
In-Reply-To: <20160902014012.9383-1-chris.brandt@renesas.com>
References: <20160901155430.23400-1-chris.brandt@renesas.com>
 <20160902014012.9383-1-chris.brandt@renesas.com>
Message-ID: <20160902014012.9383-2-chris.brandt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
* Removed MSTP7 clock node
---
 arch/arm/boot/dts/r7s72100.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 6d29e8f..fb9ef9c 100644
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
2.9.2
