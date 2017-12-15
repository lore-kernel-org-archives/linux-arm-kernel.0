From: ying.zhang@freescale.com (ying.zhang at freescale.com)
Date: Fri, 15 Dec 2017 14:02:47 +0800
Subject: [PATCH] arm64: dts: ls1088a: add DT node of watchdog
Message-ID: <20171215060247.22287-1-ying.zhang@freescale.com>
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
index bd80e9a..c21e4dd 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -292,6 +292,62 @@
 			status = "disabled";
 		};
 
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
+
 		gpio0: gpio at 2300000 {
 			compatible = "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
-- 
1.7.1
