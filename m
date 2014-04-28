From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 28 Apr 2014 16:12:35 +0200
Subject: [PATCH 2/3] arm: dts: imx6* Add clock-names for all ssi nodes
In-Reply-To: <1398694356-22511-1-git-send-email-mpa@pengutronix.de>
References: <1398694356-22511-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1398694356-22511-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two possible clocks now, baud and ipg. To avoid any issues,
add clock-names to all ssi device nodes.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 3 +++
 arch/arm/boot/dts/imx6sl.dtsi  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index b230c09..288c76e 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -257,6 +257,7 @@
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks 178>;
+					clock-names = "ipg";
 					dmas = <&sdma 37 1 0>,
 					       <&sdma 38 1 0>;
 					dma-names = "rx", "tx";
@@ -271,6 +272,7 @@
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks 179>;
+					clock-names = "ipg";
 					dmas = <&sdma 41 1 0>,
 					       <&sdma 42 1 0>;
 					dma-names = "rx", "tx";
@@ -285,6 +287,7 @@
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks 180>;
+					clock-names = "ipg";
 					dmas = <&sdma 45 1 0>,
 					       <&sdma 46 1 0>;
 					dma-names = "rx", "tx";
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 3cb4941..36da35c 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -231,6 +231,7 @@
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SL_CLK_SSI1>;
+					clock-names = "ipg";
 					dmas = <&sdma 37 1 0>,
 					       <&sdma 38 1 0>;
 					dma-names = "rx", "tx";
@@ -245,6 +246,7 @@
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SL_CLK_SSI2>;
+					clock-names = "ipg";
 					dmas = <&sdma 41 1 0>,
 					       <&sdma 42 1 0>;
 					dma-names = "rx", "tx";
@@ -259,6 +261,7 @@
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SL_CLK_SSI3>;
+					clock-names = "ipg";
 					dmas = <&sdma 45 1 0>,
 					       <&sdma 46 1 0>;
 					dma-names = "rx", "tx";
-- 
1.9.1
