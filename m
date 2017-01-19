From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Thu, 19 Jan 2017 09:59:50 +0800
Subject: [PATCH v2 1/3] dt: bindings: add documentation for zx2967 family
 watchdog controller
Message-ID: <1484791192-31674-1-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds dt-binding documentation for zx2967 family
watchdog controller.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 .../bindings/watchdog/zte,zx2967-wdt.txt           | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt b/Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt
new file mode 100644
index 0000000..6e35ce7
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt
@@ -0,0 +1,32 @@
+ZTE zx2967 Watchdog timer
+
+Required properties:
+
+- compatible : should be one of the following.
+       * zte,zx296718-wdt
+- reg : Specifies base physical address and size of the registers.
+- clocks : Pairs of phandle and specifier referencing the controller's clocks.
+- clock-names: "wdtclk" for the watchdog clock.
+- resets : Reference to the reset controller controlling the watchdog
+           controller.
+- reset-names : Must include the following entries:
+       * wdtrst
+
+Optional properties:
+
+- wdt-reset-sysctrl : should include following fields.
+	* phandle of aon-sysctrl.
+	* configuare value that be wrote to aon-sysctrl.
+	* bit mask, corresponding bits will be affected.
+
+Example:
+
+wdt_ares: watchdog at 1465000 {
+	compatible = "zte,zx296718-wdt";
+	reg = <0x1465000 0x1000>;
+	clocks = <&topcrm WDT_WCLK>;
+	clock-names = "wdtclk";
+	resets = <&toprst 35>;
+	reset-names = "wdtrst";
+	wdt-reset-sysctrl = <&aon_sysctrl 1 0x115>;
+};
-- 
2.7.4
