From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:17:41 +0200
Subject: [PATCH 68/69] ARM: dts: r8a7740: Add CEU0
In-Reply-To: <cover.1526641667.git.horms+renesas@verge.net.au>
References: <cover.1526641667.git.horms+renesas@verge.net.au>
Message-ID: <6ff6991bb4adc74cc248f2aaea2e5560671b34c2.1526641667.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Describe CEU0 peripheral for Renesas R-Mobile A1 R8A7740 Soc.

Reported-by: Geert Uytterhoeven <geert@glider.be>
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
[simon: dropped clock-names property]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index afd3bc5e6cf2..180eb9d2a390 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -67,6 +67,15 @@
 		power-domains = <&pd_d4>;
 	};
 
+	ceu0: ceu at fe910000 {
+		reg = <0xfe910000 0x3000>;
+		compatible = "renesas,r8a7740-ceu";
+		interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7740_CLK_CEU20>;
+		power-domains = <&pd_a4r>;
+		status = "disabled";
+	};
+
 	cmt1: timer at e6138000 {
 		compatible = "renesas,cmt-48-r8a7740", "renesas,cmt-48";
 		reg = <0xe6138000 0x170>;
-- 
2.11.0
