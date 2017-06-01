From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu,  1 Jun 2017 21:39:05 +0200
Subject: [PATCH v3 13/13] ARM: dts: sunxi: add SoC specific compatibles for
 the crypto nodes
In-Reply-To: <20170601193905.28829-1-antoine.tenart@free-electrons.com>
References: <20170601193905.28829-1-antoine.tenart@free-electrons.com>
Message-ID: <20170601193905.28829-14-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SoC specific compatibles for all sunXi crypto nodes, in addition to
the one already used (allwinner,sun4i-a10-crypto).

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 3 ++-
 arch/arm/boot/dts/sun7i-a20.dtsi | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 9c999d3788f6..e3e2a2f5a97b 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -780,7 +780,8 @@
 		};
 
 		crypto: crypto-engine at 01c15000 {
-			compatible = "allwinner,sun4i-a10-crypto";
+			compatible = "allwinner,sun6i-a31-crypto",
+				     "allwinner,sun4i-a10-crypto";
 			reg = <0x01c15000 0x1000>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_AHB1_SS>, <&ccu CLK_SS>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 93aa55970bd7..bd2ef3371c40 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1019,7 +1019,8 @@
 		};
 
 		crypto: crypto-engine at 01c15000 {
-			compatible = "allwinner,sun4i-a10-crypto";
+			compatible = "allwinner,sun7i-a20-crypto",
+				     "allwinner,sun4i-a10-crypto";
 			reg = <0x01c15000 0x1000>;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb_gates 5>, <&ss_clk>;
-- 
2.9.4
