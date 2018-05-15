From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 15 May 2018 10:00:38 +0200
Subject: [PATCH v2] ARM: dts: r8a7740: Add CEU1
Message-ID: <20180515080038.7438-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe CEU1 peripheral for Renesas R-Mobile A1 R8A7740 Soc.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v2
* Correct register range start address

  Based on renesas-devel-20180514-v4.17-rc5
---
 arch/arm/boot/dts/r8a7740.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 508d93440ee8..35e2fc957458 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -77,6 +77,16 @@
 		status = "disabled";
 	};
 
+	ceu1: ceu at fe914000 {
+		reg = <0xfe914000 0x3000>;
+		compatible = "renesas,r8a7740-ceu";
+		interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7740_CLK_CEU21>;
+		clock-names = "ceu21";
+		power-domains = <&pd_a4r>;
+		status = "disabled";
+	};
+
 	cmt1: timer at e6138000 {
 		compatible = "renesas,cmt-48-r8a7740", "renesas,cmt-48";
 		reg = <0xe6138000 0x170>;
-- 
2.11.0
