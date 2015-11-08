From: carlo@caione.org (Carlo Caione)
Date: Sun,  8 Nov 2015 13:18:56 +0100
Subject: [PATCH v3 3/4] Documentation: watchdog: Add new bindings for meson8b
In-Reply-To: <1446985137-25498-1-git-send-email-carlo@caione.org>
References: <1446985137-25498-1-git-send-email-carlo@caione.org>
Message-ID: <1446985137-25498-4-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

We make the documentation not meson6 specific anymore and add the new
binding for meson8b SoC.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 Documentation/devicetree/bindings/watchdog/meson-wdt.txt  | 13 +++++++++++++
 Documentation/devicetree/bindings/watchdog/meson6-wdt.txt | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/meson-wdt.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/meson6-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/meson-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
new file mode 100644
index 0000000..ae70185
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
@@ -0,0 +1,13 @@
+Meson SoCs Watchdog timer
+
+Required properties:
+
+- compatible : should be "amlogic,meson6-wdt" or "amlogic,meson8b-wdt"
+- reg : Specifies base physical address and size of the registers.
+
+Example:
+
+wdt: watchdog at c1109900 {
+	compatible = "amlogic,meson6-wdt";
+	reg = <0xc1109900 0x8>;
+};
diff --git a/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
deleted file mode 100644
index 9200fc2..0000000
--- a/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-Meson SoCs Watchdog timer
-
-Required properties:
-
-- compatible : should be "amlogic,meson6-wdt"
-- reg : Specifies base physical address and size of the registers.
-
-Example:
-
-wdt: watchdog at c1109900 {
-	compatible = "amlogic,meson6-wdt";
-	reg = <0xc1109900 0x8>;
-};
-- 
1.9.1
