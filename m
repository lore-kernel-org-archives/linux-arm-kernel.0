From: christian.ruppert@abilis.com (Christian Ruppert)
Date: Fri, 12 Apr 2013 12:36:29 +0200
Subject: [PATCH] ARC: [TB10x] Adapt device tree to new compatible string
In-Reply-To: <5167D7E4.9030206@free-electrons.com>
References: <5167D7E4.9030206@free-electrons.com>
Message-ID: <1365762989-31638-1-git-send-email-christian.ruppert@abilis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original device tree was written using a slightly different
implementation of the fixed-factor-clock device tree binding. The
compatible string must be modified in order to be compatible with the
new implementation.

Signed-off-by: Christian Ruppert <christian.ruppert@abilis.com>
---
 arch/arc/boot/dts/abilis_tb10x.dtsi |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/boot/dts/abilis_tb10x.dtsi b/arch/arc/boot/dts/abilis_tb10x.dtsi
index 6d80d9c..a6139fc 100644
--- a/arch/arc/boot/dts/abilis_tb10x.dtsi
+++ b/arch/arc/boot/dts/abilis_tb10x.dtsi
@@ -53,13 +53,13 @@
 			clock-output-names = "pll0";
 		};
 		cpu_clk: clkdiv_cpu {
-			compatible = "fixed-factor-clkdiv";
+			compatible = "fixed-factor-clock";
 			#clock-cells = <0>;
 			clocks = <&pll0>;
 			clock-output-names = "cpu_clk";
 		};
 		ahb_clk: clkdiv_ahb {
-			compatible = "fixed-factor-clkdiv";
+			compatible = "fixed-factor-clock";
 			#clock-cells = <0>;
 			clocks = <&pll0>;
 			clock-output-names = "ahb_clk";
-- 
1.7.1
