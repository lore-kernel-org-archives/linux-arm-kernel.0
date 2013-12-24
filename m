From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:19:41 +0900
Subject: [PATCH 18/21] ARM: shmobile: r8a7790: Add QSPI module clock in device
 tree
In-Reply-To: <cover.1387893834.git.horms+renesas@verge.net.au>
References: <cover.1387893834.git.horms+renesas@verge.net.au>
Message-ID: <91b56ca10a3cf4999bae5f8b8e7e2723bf4b1363.1387893834.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi            | 11 +++++++----
 include/dt-bindings/clock/r8a7790-clock.h |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 9c9a992..a179125 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -615,13 +615,16 @@
 		mstp9_clks: mstp9_clks at e6150994 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
-			clocks = <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>;
+			clocks = <&p_clk>, <&p_clk>, <&cpg_clocks R8A7790_CLK_QSPI>,
+				 <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
-				R8A7790_CLK_RCAN1 R8A7790_CLK_RCAN0 R8A7790_CLK_I2C3
-				R8A7790_CLK_I2C2 R8A7790_CLK_I2C1 R8A7790_CLK_I2C0
+				R8A7790_CLK_RCAN1 R8A7790_CLK_RCAN0 R8A7790_CLK_QSPI_MOD
+				R8A7790_CLK_I2C3 R8A7790_CLK_I2C2 R8A7790_CLK_I2C1
+				R8A7790_CLK_I2C0
 			>;
-			clock-output-names = "rcan1", "rcan0", "i2c3", "i2c2", "i2c1", "i2c0";
+			clock-output-names =
+				"rcan1", "rcan0", "qspi_mod", "i2c3", "i2c2", "i2c1", "i2c0";
 		};
 	};
 };
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index bbabb8e..859e9be 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -97,6 +97,7 @@
 #define R8A7790_CLK_GPIO0		12
 #define R8A7790_CLK_RCAN1		15
 #define R8A7790_CLK_RCAN0		16
+#define R8A7790_CLK_QSPI_MOD		17
 #define R8A7790_CLK_IICDVFS		26
 #define R8A7790_CLK_I2C3		28
 #define R8A7790_CLK_I2C2		29
-- 
1.8.4
