From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 08:53:06 +0900
Subject: [PATCH 17/19] ARM: dts: r8a7794: add EtherAVB support
In-Reply-To: <cover.1456443769.git.horms+renesas@verge.net.au>
References: <cover.1456443769.git.horms+renesas@verge.net.au>
Message-ID: <89aac8af1a607355710c7c954efec85a9302bc95.1456443769.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the generic R8A7794 part of the EtherAVB device node.

Based on the commit 46ece349aa54 ("ARM: shmobile: r8a7791: add EtherAVB DT
support").

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 042440b6dc8c..eacb2b291361 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -544,6 +544,18 @@
 		status = "disabled";
 	};
 
+	avb: ethernet at e6800000 {
+		compatible = "renesas,etheravb-r8a7794",
+			     "renesas,etheravb-rcar-gen2";
+		reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
+		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7794_CLK_ETHERAVB>;
+		power-domains = <&cpg_clocks>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	/* The memory map in the User's Manual maps the cores to bus numbers */
 	i2c0: i2c at e6508000 {
 		compatible = "renesas,i2c-r8a7794";
-- 
2.7.0.rc3.207.g0ac5344
