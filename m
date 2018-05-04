From: shawnguo@kernel.org (Shawn Guo)
Date: Fri,  4 May 2018 08:57:25 +0800
Subject: [PATCH 3/4] ARM: dts: imx27: use lable to override osc26m clock
 setting
In-Reply-To: <1525395446-1953-1-git-send-email-shawnguo@kernel.org>
References: <1525395446-1953-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1525395446-1953-4-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of copying the whole node hierarchy, let's define a label for
clock osc26m in soc dtsi and use it for overriding clock-frequency.

Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/boot/dts/imx27-apf27.dts | 13 +++----------
 arch/arm/boot/dts/imx27.dtsi      |  2 +-
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-apf27.dts b/arch/arm/boot/dts/imx27-apf27.dts
index 66941cdbf244..3eddd805a793 100644
--- a/arch/arm/boot/dts/imx27-apf27.dts
+++ b/arch/arm/boot/dts/imx27-apf27.dts
@@ -22,17 +22,10 @@
 	memory at a0000000 {
 		reg = <0xa0000000 0x04000000>;
 	};
+};
 
-	clocks {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		osc26m {
-			compatible = "fsl,imx-osc26m", "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <0>;
-		};
-	};
+&clk_osc26m {
+	clock-frequency = <0>;
 };
 
 &iomuxc {
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 389c9288b4ed..6c28b9cf802c 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -57,7 +57,7 @@
 	};
 
 	clocks {
-		osc26m {
+		clk_osc26m: osc26m {
 			compatible = "fsl,imx-osc26m", "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <26000000>;
-- 
1.9.1
