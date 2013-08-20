From: Ying.Liu@freescale.com (Liu Ying)
Date: Tue, 20 Aug 2013 16:38:51 +0800
Subject: [PATCH 2/3] ARM: dts: imx6q/imx6dl: add necessary clocks for ldb node
In-Reply-To: <1376987932-5540-1-git-send-email-Ying.Liu@freescale.com>
References: <1376987932-5540-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1376987932-5540-3-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds di[0/1]_div_3_5, di[0/1]_div_7 and di[0/1]_div_sel
clocks to the ldb nodes so that the ldb driver may use them to
setup the display clock trees.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
 arch/arm/boot/dts/imx6dl.dtsi |    8 ++++++--
 arch/arm/boot/dts/imx6q.dtsi  |    8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 9e8ae11..ff0d743 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -75,10 +75,14 @@
 &ldb {
 	clocks = <&clks 33>, <&clks 34>,
 		 <&clks 39>, <&clks 40>,
-		 <&clks 135>, <&clks 136>;
+		 <&clks 135>, <&clks 136>,
+		 <&clks 184>, <&clks 185>, <&clks 203>, <&clks 204>,
+		 <&clks 205>, <&clks 206>;
 	clock-names = "di0_pll", "di1_pll",
 		      "di0_sel", "di1_sel",
-		      "di0", "di1";
+		      "di0", "di1",
+		      "di0_div_3_5", "di1_div_3_5", "di0_div_7", "di1_div_7",
+		      "di0_div_sel", "di1_div_sel";
 
 	lvds-channel at 0 {
 		crtcs = <&ipu1 0>, <&ipu1 1>;
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index f024ef2..b078a42 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -146,10 +146,14 @@
 &ldb {
 	clocks = <&clks 33>, <&clks 34>,
 		 <&clks 39>, <&clks 40>, <&clks 41>, <&clks 42>,
-		 <&clks 135>, <&clks 136>;
+		 <&clks 135>, <&clks 136>,
+		 <&clks 184>, <&clks 185>, <&clks 203>, <&clks 204>,
+		 <&clks 205>, <&clks 206>;
 	clock-names = "di0_pll", "di1_pll",
 		      "di0_sel", "di1_sel", "di2_sel", "di3_sel",
-		      "di0", "di1";
+		      "di0", "di1",
+		      "di0_div_3_5", "di1_div_3_5", "di0_div_7", "di1_div_7",
+		      "di0_div_sel", "di1_div_sel";
 
 	lvds-channel at 0 {
 		crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
-- 
1.7.9.5
