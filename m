From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 04 Sep 2016 22:55:37 +0300
Subject: [PATCH] ARM: dts: r8a7794: fix PWM clock parent
In-Reply-To: <1618499.8bcj8adpVO@wasted.cogentembedded.com>
References: <1618499.8bcj8adpVO@wasted.cogentembedded.com>
Message-ID: <1994467.CVFvpbaMyF@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When removing the non-existing thermal clock I forgot to remove its
parent from the node's "clocks" property  -- this led to a wrong PWM
clock's parent clock.

Fixes: 2a29f9d6fea8 ("ARM: dts: r8a7794: add MSTP5 clocks")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'renesas-devel-20160902-v4.8-rc4' branch of Simon
Horman's 'renesas.git' repo...

arch/arm/boot/dts/r8a7794.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
+++ renesas/arch/arm/boot/dts/r8a7794.dtsi
@@ -1251,7 +1251,7 @@
 		mstp5_clks: mstp5_clks at e6150144 {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
-			clocks = <&hp_clk>, <&extal_clk>, <&p_clk>;
+			clocks = <&hp_clk>, <&p_clk>;
 			#clock-cells = <1>;
 			clock-indices = <R8A7794_CLK_AUDIO_DMAC0
 					 R8A7794_CLK_PWM>;
