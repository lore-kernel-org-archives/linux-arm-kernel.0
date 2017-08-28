From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 28 Aug 2017 13:35:29 +0200
Subject: [PATCH 1/3] dt-bindings: watchdog: Add Realtek RTD1295
In-Reply-To: <20170828113532.32627-1-afaerber@suse.de>
References: <20170828113532.32627-1-afaerber@suse.de>
Message-ID: <20170828113532.32627-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a binding for the Realtek RTD1295 watchdog.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 .../devicetree/bindings/watchdog/realtek,rtd119x.txt    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/realtek,rtd119x.txt

diff --git a/Documentation/devicetree/bindings/watchdog/realtek,rtd119x.txt b/Documentation/devicetree/bindings/watchdog/realtek,rtd119x.txt
new file mode 100644
index 000000000000..05653054bd5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/realtek,rtd119x.txt
@@ -0,0 +1,17 @@
+Realtek RTD1295 Watchdog
+========================
+
+Required properties:
+
+- compatible :  Should be "realtek,rtd1295-watchdog"
+- reg        :  Specifies the physical base address and size of registers
+- clocks     :  Specifies one clock input
+
+
+Example:
+
+	watchdog at 98007680 {
+		compatible = "realtek,rtd1295-watchdog";
+		reg = <0x98007680 0x100>;
+		clocks = <&osc27M>;
+	};
-- 
2.12.3
