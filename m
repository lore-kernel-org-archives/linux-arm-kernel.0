From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  1 Jan 2014 10:30:47 +0800
Subject: [PATCH v3 2/5] ARM: dts: sun7i: Change 32768 Hz oscillator node name
 to clk@N style
In-Reply-To: <1388543450-16741-1-git-send-email-wens@csie.org>
References: <1388543450-16741-1-git-send-email-wens@csie.org>
Message-ID: <1388543450-16741-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree naming conventions state that node names should match
the nodes function. Change external low speed oscillator node name
to match.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This patch only changes osc32k in sun7i DT, for proper numbering
of the dummy clocks. osc24M does not support clock-output-names
yet, nor do the other clocks left. I'd like to do thses in another
series, adding support in the clock driver, and fixing up all sunxi
DTs.

 arch/arm/boot/dts/sun7i-a20.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 4c25f81..c0fb390 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -53,10 +53,11 @@
 			clock-frequency = <24000000>;
 		};
 
-		osc32k: osc32k {
+		osc32k: clk at 0 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
+			clock-output-names = "osc32k";
 		};
 
 		pll1: pll1 at 01c20000 {
-- 
1.8.5.2
