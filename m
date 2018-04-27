From: jan.tuerk@emtrion.com (jan.tuerk at emtrion.com)
Date: Fri, 27 Apr 2018 15:24:36 +0200
Subject: [PATCH v4 1/7] dt-bindings: display: Document the EDT et* displays in
 one file.
In-Reply-To: <20180427132445.3458-1-jan.tuerk@emtrion.com>
References: <20180420125108.14197-1-jan.tuerk@emtrion.com>
 <20180427132445.3458-1-jan.tuerk@emtrion.com>
Message-ID: <20180427132445.3458-2-jan.tuerk@emtrion.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Tuerk <jan.tuerk@emtrion.com>

Document the Emerging Display Technology Corp. (EDT) using the
simple-panel binding in one single file.

Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
---
Changes for v4:
  - re-arrange the Patch-series to match the DT-submitting-patches
  - Additional patch for the Documentation of the new DT-bindings
  - no change (re-arranged 3/6 => 1/7)

 .../bindings/display/panel/edt,et-series.txt       | 39 ++++++++++++++++++++++
 .../bindings/display/panel/edt,et057090dhu.txt     |  7 ----
 .../bindings/display/panel/edt,et070080dh6.txt     | 10 ------
 .../bindings/display/panel/edt,etm0700g0dh6.txt    | 10 ------
 4 files changed, 39 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/edt,et-series.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,et057090dhu.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,et070080dh6.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,etm0700g0dh6.txt

diff --git a/Documentation/devicetree/bindings/display/panel/edt,et-series.txt b/Documentation/devicetree/bindings/display/panel/edt,et-series.txt
new file mode 100644
index 000000000000..f56b99ebd9be
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/edt,et-series.txt
@@ -0,0 +1,39 @@
+Emerging Display Technology Corp. Displays
+==========================================
+
+
+Display bindings for EDT Display Technology Corp. Displays which are
+compatible with the simple-panel binding, which is specified in
+simple-panel.txt
+
+
+5,7" WVGA TFT Panels
+--------------------
+
++-----------------+---------------------+-------------------------------------+
+| Identifier      | compatbile          | description                         |
++=================+=====================+=====================================+
+| ET057090DHU     | edt,et057090dhu     | 5.7" VGA TFT LCD panel              |
++-----------------+---------------------+-------------------------------------+
+
+
+7,0" WVGA TFT Panels
+--------------------
+
++-----------------+---------------------+-------------------------------------+
+| Identifier      | compatbile          | description                         |
++=================+=====================+=====================================+
+| ETM0700G0DH6    | edt,etm070080dh6    | WVGA TFT Display with capacitive    |
+|                 |                     | Touchscreen                         |
++-----------------+---------------------+-------------------------------------+
+| ETM0700G0BDH6   | edt,etm070080bdh6   | Same as ETM0700G0DH6 but with       |
+|                 |                     | inverted pixel clock.               |
++-----------------+---------------------+-------------------------------------+
+| ETM0700G0EDH6   | edt,etm070080edh6   | Same display as the ETM0700G0BDH6,  |
+|                 |                     | but with changed Hardware for the   |
+|                 |                     | backlight and the touch interface   |
++-----------------+---------------------+-------------------------------------+
+| ET070080DH6     | edt,etm070080dh6    | Same timings as the ETM0700G0DH6,   |
+|                 |                     | but with resistive touch.           |
++-----------------+---------------------+-------------------------------------+
+
diff --git a/Documentation/devicetree/bindings/display/panel/edt,et057090dhu.txt b/Documentation/devicetree/bindings/display/panel/edt,et057090dhu.txt
deleted file mode 100644
index 4903d7b1d947..000000000000
--- a/Documentation/devicetree/bindings/display/panel/edt,et057090dhu.txt
+++ /dev/null
@@ -1,7 +0,0 @@
-Emerging Display Technology Corp. 5.7" VGA TFT LCD panel
-
-Required properties:
-- compatible: should be "edt,et057090dhu"
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/edt,et070080dh6.txt b/Documentation/devicetree/bindings/display/panel/edt,et070080dh6.txt
deleted file mode 100644
index 20cb38e836e4..000000000000
--- a/Documentation/devicetree/bindings/display/panel/edt,et070080dh6.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-Emerging Display Technology Corp. ET070080DH6 7.0" WVGA TFT LCD panel
-
-Required properties:
-- compatible: should be "edt,et070080dh6"
-
-This panel is the same as ETM0700G0DH6 except for the touchscreen.
-ET070080DH6 is the model with resistive touch.
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/edt,etm0700g0dh6.txt b/Documentation/devicetree/bindings/display/panel/edt,etm0700g0dh6.txt
deleted file mode 100644
index ee4b18053e40..000000000000
--- a/Documentation/devicetree/bindings/display/panel/edt,etm0700g0dh6.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-Emerging Display Technology Corp. ETM0700G0DH6 7.0" WVGA TFT LCD panel
-
-Required properties:
-- compatible: should be "edt,etm0700g0dh6"
-
-This panel is the same as ET070080DH6 except for the touchscreen.
-ETM0700G0DH6 is the model with capacitive multitouch.
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
-- 
2.11.0
