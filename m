From: ying.zhang@freescale.com (ying.zhang at freescale.com)
Date: Wed, 27 Dec 2017 10:41:51 +0800
Subject: [PATCH v2] arm64: dts: ls1088a: add DT node of watchdog
Message-ID: <20171227024151.9223-1-ying.zhang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhang Ying-22455 <ying.zhang22455@nxp.com>

There are eight cores in ls1088a and each core has an watchdog,
ls1088a can use sp805-wdt driver, so we just add DT node for it.

Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   56 ++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index f5f29a2..fb1858a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -592,6 +592,62 @@
 					<0000 0 0 3 &gic 0 0 0 121 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 0 122 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		cluster1_core0_watchdog: wdt at c000000 {
+			compatible = "arm,sp805-wdt", "arm,primecell";
+			reg = <0x0 0xc000000 0x0 0x1000>;
+			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clock-names = "apb_pclk", "wdog_clk";
+		};
+
+		cluster1_core1_watchdog: wdt at c010000 {
+			compatible = "arm,sp805-wdt", "arm,primecell";
+			reg = <0x0 0xc010000 0x0 0x1000>;
+			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clock-names = "apb_pclk", "wdog_clk";
+		};
+
+		cluster1_core2_watchdog: wdt at c020000 {
+			compatible = "arm,sp805-wdt", "arm,primecell";
+			reg = <0x0 0xc020000 0x0 0x1000>;
+			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clock-names = "apb_pclk", "wdog_clk";
+		};
+
+		cluster1_core3_watchdog: wdt at c030000 {
+			compatible = "arm,sp805-wdt", "arm,primecell";
+			reg = <0x0 0xc030000 0x0 0x1000>;
+			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clock-names = "apb_pclk", "wdog_clk";
+		};
+
+		cluster2_core0_watchdog: wdt at c100000 {
+			compatible = "arm,sp805-wdt", "arm,primecell";
+			reg = <0x0 0xc100000 0x0 0x1000>;
+			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clock-names = "apb_pclk", "wdog_clk";
+		};
+
+		cluster2_core1_watchdog: wdt at c110000 {
+			compatible = "arm,sp805-wdt", "arm,primecell";
+			reg = <0x0 0xc110000 0x0 0x1000>;
+			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clock-names = "apb_pclk", "wdog_clk";
+		};
+
+		cluster2_core2_watchdog: wdt at c120000 {
+			compatible = "arm,sp805-wdt", "arm,primecell";
+			reg = <0x0 0xc120000 0x0 0x1000>;
+			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clock-names = "apb_pclk", "wdog_clk";
+		};
+
+		cluster2_core3_watchdog: wdt at c130000 {
+			compatible = "arm,sp805-wdt", "arm,primecell";
+			reg = <0x0 0xc130000 0x0 0x1000>;
+			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clock-names = "apb_pclk", "wdog_clk";
+		};
 	};
 
 	firmware {
-- 
1.7.1
