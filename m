From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Apr 2017 11:58:18 -0400
Subject: [PATCH 17/22] ARM: dts: r7s72100: add rtc to device tree
In-Reply-To: <cover.1491580547.git.horms+renesas@verge.net.au>
References: <cover.1491580547.git.horms+renesas@verge.net.au>
Message-ID: <3b5e3f0455442f376f91c69147526535a0389ac3.1491580547.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Add the realtime clock device node.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 9db46ac08ba7..ab9ced453118 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -563,4 +563,18 @@
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
+
+	rtc: rtc at fcff1000 {
+		compatible = "renesas,r7s72100-rtc", "renesas,sh-rtc";
+		reg = <0xfcff1000 0x2e>;
+		interrupts = <GIC_SPI 276 IRQ_TYPE_EDGE_RISING
+			      GIC_SPI 277 IRQ_TYPE_EDGE_RISING
+			      GIC_SPI 278 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "alarm", "period", "carry";
+		clocks = <&mstp6_clks R7S72100_CLK_RTC>, <&rtc_x1_clk>,
+			 <&rtc_x3_clk>, <&extal_clk>;
+		clock-names = "fck", "rtc_x1", "rtc_x3", "extal";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
 };
-- 
2.7.0.rc3.207.g0ac5344
