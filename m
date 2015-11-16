From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Mon, 16 Nov 2015 19:54:43 +0530
Subject: [PATCH 2/2] dts/ls2080a: Update DTSI to add support of SP805 WDT
In-Reply-To: <1447683883-6600-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1447683883-6600-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1447683883-6600-3-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the LS2080a DTSI (DTS Include) file to add
support for eight SP805 Watchdog units which can be used to
reset the eight Cortex-A57 cores available on LS2080A.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi |   64 ++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index e81cd48..15637ab 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -193,6 +193,70 @@
 			interrupts = <0 32 0x4>; /* Level high type */
 		};
 
+		cluster1_core0_watchdog: wdt at c000000 {
+			compatible = "arm,sp805-wdt", "arm,primecell";
+			reg = <0x0 0xc000000 0x0 0x1000>;
+			interrupts = <1 12 0x8>; /* PPI, Level low type */
+			clocks = <&clockgen 4 3>;
+			clock-names = "apb_pclk";
+		};
+
+		cluster1_core1_watchdog: wdt at c010000 {
+			compatible = "arm,sp805-wdt", "arm,primecell";
+			reg = <0x0 0xc010000 0x0 0x1000>;
+			interrupts = <1 12 0x8>; /* PPI, Level low type */
+			clocks = <&clockgen 4 3>;
+			clock-names = "apb_pclk";
+		};
+
+		cluster2_core0_watchdog: wdt at c100000 {
+			compatible = "arm,sp805-wdt", "arm,primecell";
+			reg = <0x0 0xc100000 0x0 0x1000>;
+			interrupts = <1 12 0x8>; /* PPI, Level low type */
+			clocks = <&clockgen 4 3>;
+			clock-names = "apb_pclk";
+		};
+
+		cluster2_core1_watchdog: wdt at c110000 {
+			compatible = "arm,sp805-wdt", "arm,primecell";
+			reg = <0x0 0xc110000 0x0 0x1000>;
+			interrupts = <1 12 0x8>; /* PPI, Level low type */
+			clocks = <&clockgen 4 3>;
+			clock-names = "apb_pclk";
+		};
+
+		cluster3_core0_watchdog: wdt at c200000 {
+			compatible = "arm,sp805-wdt", "arm,primecell";
+			reg = <0x0 0xc200000 0x0 0x1000>;
+			interrupts = <1 12 0x8>; /* PPI, Level low type */
+			clocks = <&clockgen 4 3>;
+			clock-names = "apb_pclk";
+		};
+
+		cluster3_core1_watchdog: wdt at c210000 {
+			compatible = "arm,sp805-wdt", "arm,primecell";
+			reg = <0x0 0xc210000 0x0 0x1000>;
+			interrupts = <1 12 0x8>; /* PPI, Level low type */
+			clocks = <&clockgen 4 3>;
+			clock-names = "apb_pclk";
+		};
+
+		cluster4_core0_watchdog: wdt at c300000 {
+			compatible = "arm,sp805-wdt", "arm,primecell";
+			reg = <0x0 0xc300000 0x0 0x1000>;
+			interrupts = <1 12 0x8>; /* PPI, Level low type */
+			clocks = <&clockgen 4 3>;
+			clock-names = "apb_pclk";
+		};
+
+		cluster4_core1_watchdog: wdt at c310000 {
+			compatible = "arm,sp805-wdt", "arm,primecell";
+			reg = <0x0 0xc310000 0x0 0x1000>;
+			interrupts = <1 12 0x8>; /* PPI, Level low type */
+			clocks = <&clockgen 4 3>;
+			clock-names = "apb_pclk";
+		};
+
 		fsl_mc: fsl-mc at 80c000000 {
 			compatible = "fsl,qoriq-mc";
 			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
-- 
1.7.9.5
