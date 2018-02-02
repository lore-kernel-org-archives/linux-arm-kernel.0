From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  2 Feb 2018 21:26:39 -0200
Subject: [PATCH v2] ARM: dts: imx27-eukrea-cpuimx27: Put the clock node
 directly into root
Message-ID: <1517613999-6467-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Put the UART clock node directly under root with a unique node name and
drop unit-address in order to fix the following build warning with W=1:

arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dtb: Warning (simple_bus_reg): Node /clocks/osc26m missing or empty reg/ranges property

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Put the UART clock node directly under root (Shawn)

 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
index 2cf896c..6671a80 100644
--- a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
+++ b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
@@ -20,17 +20,10 @@
 		reg = <0xa0000000 0x04000000>;
 	};
 
-	clocks {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "simple-bus";
-
-		clk14745600: clock at 0 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <14745600>;
-			reg = <0>;
-		};
+	clk14745600: clk-uart {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <14745600>;
 	};
 };
 
-- 
2.7.4
