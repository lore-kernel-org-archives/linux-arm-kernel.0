From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Sep 2016 09:50:07 +0200
Subject: [PATCH 20/26] ARM: dts: r8a7794: fix PWM clock parent
In-Reply-To: <cover.1473234371.git.horms+renesas@verge.net.au>
References: <cover.1473234371.git.horms+renesas@verge.net.au>
Message-ID: <059baea1d33a64e752af201140ef122e29f2a19a.1473234372.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

When removing the non-existing thermal clock I forgot to remove its
parent from the node's "clocks" property  -- this led to a wrong PWM
clock's parent clock.

Fixes: 2a29f9d6fea8 ("ARM: dts: r8a7794: add MSTP5 clocks")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 611ec6df5cf6..9365580a194f 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -1251,7 +1251,7 @@
 		mstp5_clks: mstp5_clks at e6150144 {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
-			clocks = <&hp_clk>, <&extal_clk>, <&p_clk>;
+			clocks = <&hp_clk>, <&p_clk>;
 			#clock-cells = <1>;
 			clock-indices = <R8A7794_CLK_AUDIO_DMAC0
 					 R8A7794_CLK_PWM>;
-- 
2.7.0.rc3.207.g0ac5344
