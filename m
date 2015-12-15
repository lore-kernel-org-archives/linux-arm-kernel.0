From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Tue, 15 Dec 2015 20:00:24 +0530
Subject: [PATCH v3 1/2] Documentation: DT: Add entry for ARM SP805-WDT
In-Reply-To: <1450189825-29065-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1450189825-29065-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1450189825-29065-2-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a devicetree binding documentation for ARM's
SP805 WatchDog Timer.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 .../devicetree/bindings/watchdog/sp805-wdt.txt     |   29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/sp805-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
new file mode 100644
index 0000000..45b5afc
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
@@ -0,0 +1,29 @@
+* ARM SP805 Watchdog Timer (WDT) Controller
+
+SP805 WDT is a ARM Primecell Peripheral and has a standard-id register that
+can be used to identify the peripheral type, vendor, and revision.
+This value can be used for driver matching.
+
+As SP805 WDT is a primecell IP, it follows the base bindings specified in
+'arm/primecell.txt'
+
+Required properties:
+- compatible : Should be "arm,sp805-wdt", "arm,primecell"
+- reg : Base address and size of the watchdog timer registers.
+- clocks : From common clock binding.
+           First clock is PCLK and the second is WDOGCLK.
+           WDOGCLK can be equal to or be a sub-multiple of the PCLK frequency.
+- clock-names : From common clock binding. Shall be "apb_pclk" for first clock.
+
+Optional properties:
+- interrupts : Should specify WDT interrupt number.
+
+Examples:
+
+		cluster1_core0_watchdog: wdt at c000000 {
+			compatible = "arm,sp805-wdt", "arm,primecell";
+			reg = <0x0 0xc000000 0x0 0x1000>;
+			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clock-names = "apb_pclk", "wdog_clk";
+		};
+
-- 
1.7.9.5
