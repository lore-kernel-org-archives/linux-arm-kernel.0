From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:21 +0100
Subject: [PATCH 22/29] ARM: dts: r8a7779: Fix DU reg property
In-Reply-To: <cover.1478252308.git.horms+renesas@verge.net.au>
References: <cover.1478252308.git.horms+renesas@verge.net.au>
Message-ID: <30524edfae10d4af08cb2daed786ae4713ba3fd6.1478252309.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The system uses one address cell and one size cell, not two. Fix the DU
DT node.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index b9bbcce69dfb..9d5b8fa3da8b 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -420,7 +420,7 @@
 
 	du: display at fff80000 {
 		compatible = "renesas,du-r8a7779";
-		reg = <0 0xfff80000 0 0x40000>;
+		reg = <0xfff80000 0x40000>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7779_CLK_DU>;
 		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
-- 
2.7.0.rc3.207.g0ac5344
