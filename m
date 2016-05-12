From: joel@jms.id.au (Joel Stanley)
Date: Thu, 12 May 2016 23:47:10 +0930
Subject: [PATCH v2 1/2] doc/devicetree: Add Aspeed watchdog timer bindings
In-Reply-To: <1463062631-16432-1-git-send-email-joel@jms.id.au>
References: <1462797277-14969-1-git-send-email-joel@jms.id.au>
 <1463062631-16432-1-git-send-email-joel@jms.id.au>
Message-ID: <1463062631-16432-2-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../devicetree/bindings/watchdog/aspeed-wdt.txt          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
new file mode 100644
index 000000000000..78ad314eaab9
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
@@ -0,0 +1,16 @@
+Aspeed Watchdog Timer
+
+Required properties:
+ - compatible: must be one of:
+	- "aspeed,ast2400-wdt"
+	- "aspeed,ast2500-wdt"
+
+ - reg: physical base address of the controller and length of memory mapped
+   region
+
+Example:
+
+	watchdog1: watchdog at 1e785000 {
+		compatible = "aspeed,ast2400-wdt";
+		reg = <0x1e785000 0x1c>;
+	};
-- 
2.8.1
