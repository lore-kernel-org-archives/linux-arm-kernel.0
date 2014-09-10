From: b38343@freescale.com (Robin Gong)
Date: Wed, 10 Sep 2014 13:30:12 +0800
Subject: [PATCH v2] ARM: dts: imx6dl: disable dma support for spi on i.mx6dl
Message-ID: <1410327012-31185-1-git-send-email-b38343@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is one weird data in rxfifo after one full rx/tx transfer
done sometimes. It looks a design issue and hard to workaround
totally, so disable dma functhion here. And will re-enable it
once the root cause found.

Signed-off-by: Robin Gong <b38343@freescale.com>
---
 arch/arm/boot/dts/imx6q.dtsi   | 20 ++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl.dtsi |  8 --------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index e9f3646..8d5d33b 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -291,6 +291,26 @@
 	};
 };
 
+&ecspi1 {
+	dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
+	dma-names = "rx", "tx";
+};
+
+&ecspi2 {
+	dmas = <&sdma 5 7 1>, <&sdma 6 7 2>;
+	dma-names = "rx", "tx";
+};
+
+&ecspi3 {
+	dmas = <&sdma 7 7 1>, <&sdma 8 7 2>;
+	dma-names = "rx", "tx";
+};
+
+&ecspi4 {
+	dmas = <&sdma 9 7 1>, <&sdma 10 7 2>;
+	dma-names = "rx", "tx";
+};
+
 &mipi_dsi {
 	port at 2 {
 		reg = <2>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 70d7207..f696546 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -210,8 +210,6 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI1>,
 						 <&clks IMX6QDL_CLK_ECSPI1>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
-					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -224,8 +222,6 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI2>,
 						 <&clks IMX6QDL_CLK_ECSPI2>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 5 7 1>, <&sdma 6 7 2>;
-					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -238,8 +234,6 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI3>,
 						 <&clks IMX6QDL_CLK_ECSPI3>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 7 7 1>, <&sdma 8 7 2>;
-					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -252,8 +246,6 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI4>,
 						 <&clks IMX6QDL_CLK_ECSPI4>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 9 7 1>, <&sdma 10 7 2>;
-					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
-- 
1.9.1
