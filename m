From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 16 Jul 2016 12:46:04 +0200
Subject: [PATCH 4/4] ARM: dts: sun5i: Remove sample clocks from mmc host nodes
In-Reply-To: <1468665964-27142-1-git-send-email-hdegoede@redhat.com>
References: <1468665964-27142-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1468665964-27142-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It turns out that sun5i does not have mmc sample clocks (the bits for
this in the register always read back 0, not listed in the datasheet),
so remove the sample clocks from the mmc host nodes.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index e374f4f..86044f9 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -431,13 +431,9 @@
 			compatible = "allwinner,sun5i-a13-mmc";
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
@@ -448,13 +444,9 @@
 			compatible = "allwinner,sun5i-a13-mmc";
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
@@ -465,13 +457,9 @@
 			compatible = "allwinner,sun5i-a13-mmc";
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
-- 
2.7.4
