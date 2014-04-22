From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 22 Apr 2014 13:01:30 +0200
Subject: [PATCH v8 10/17] ARM: dts: sun6i: Add mmc clocks
In-Reply-To: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1398164497-14212-11-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clk-nodes for the mmc clocks.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index d45efa7..12bcc17 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -198,6 +198,38 @@
 					"apb2_uart4", "apb2_uart5";
 		};
 
+		mmc0_clk: clk at 01c20088 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c20088 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "mmc0";
+		};
+
+		mmc1_clk: clk at 01c2008c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c2008c 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "mmc1";
+		};
+
+		mmc2_clk: clk at 01c20090 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c20090 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "mmc2";
+		};
+
+		mmc3_clk: clk at 01c20094 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c20094 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "mmc3";
+		};
+
 		spi0_clk: clk at 01c200a0 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
-- 
1.9.0
