From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 16 Jul 2016 12:46:03 +0200
Subject: [PATCH 3/4] ARM: dts: sun4i: Remove sample clocks from mmc host nodes
In-Reply-To: <1468665964-27142-1-git-send-email-hdegoede@redhat.com>
References: <1468665964-27142-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1468665964-27142-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It turns out the A10 does not have mmc sample clocks (the bits for
this in the register always read back 0, not listed in the datasheet),
so remove the sample clocks from the mmc host nodes.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 7e7dfc2..f6bf851 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -783,13 +783,9 @@
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c0f000 0x1000>;
 			clocks = <&ahb_gates 8>,
-				 <&mmc0_clk 0>,
-				 <&mmc0_clk 1>,
-				 <&mmc0_clk 2>;
+				 <&mmc0_clk 0>;
 			clock-names = "ahb",
-				      "mmc",
-				      "output",
-				      "sample";
+				      "mmc";
 			interrupts = <32>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -800,13 +796,9 @@
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c10000 0x1000>;
 			clocks = <&ahb_gates 9>,
-				 <&mmc1_clk 0>,
-				 <&mmc1_clk 1>,
-				 <&mmc1_clk 2>;
+				 <&mmc1_clk 0>;
 			clock-names = "ahb",
-				      "mmc",
-				      "output",
-				      "sample";
+				      "mmc";
 			interrupts = <33>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -817,13 +809,9 @@
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c11000 0x1000>;
 			clocks = <&ahb_gates 10>,
-				 <&mmc2_clk 0>,
-				 <&mmc2_clk 1>,
-				 <&mmc2_clk 2>;
+				 <&mmc2_clk 0>;
 			clock-names = "ahb",
-				      "mmc",
-				      "output",
-				      "sample";
+				      "mmc";
 			interrupts = <34>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -834,13 +822,9 @@
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c12000 0x1000>;
 			clocks = <&ahb_gates 11>,
-				 <&mmc3_clk 0>,
-				 <&mmc3_clk 1>,
-				 <&mmc3_clk 2>;
+				 <&mmc3_clk 0>;
 			clock-names = "ahb",
-				      "mmc",
-				      "output",
-				      "sample";
+				      "mmc";
 			interrupts = <35>;
 			status = "disabled";
 			#address-cells = <1>;
-- 
2.7.4
