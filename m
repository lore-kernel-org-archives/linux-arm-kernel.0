From: markus.mayer@linaro.org (Markus Mayer)
Date: Thu, 27 Feb 2014 13:56:04 -0800
Subject: [PATCH 1/3] ARM: DT: bcm21664: Device tree bindings
In-Reply-To: <1393538166-22868-1-git-send-email-markus.mayer@linaro.org>
References: <1393538166-22868-1-git-send-email-markus.mayer@linaro.org>
Message-ID: <1393538166-22868-2-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding documents for the Broadcom BCM21664 SoC.

Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
---
 .../devicetree/bindings/arm/bcm/bcm21664.txt       |   15 +++++++++++++++
 .../devicetree/bindings/arm/bcm/kona-resetmgr.txt  |   14 ++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/bcm21664.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/kona-resetmgr.txt

diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm21664.txt b/Documentation/devicetree/bindings/arm/bcm/bcm21664.txt
new file mode 100644
index 0000000..e077425
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/bcm21664.txt
@@ -0,0 +1,15 @@
+Broadcom BCM21664 device tree bindings
+--------------------------------------
+
+This document describes the device tree bindings for boards with the BCM21664
+SoC.
+
+Required root node property:
+  - compatible: brcm,bcm21664
+
+Example:
+	/ {
+		model = "BCM21664 SoC";
+		compatible = "brcm,bcm21664";
+		[...]
+	}
diff --git a/Documentation/devicetree/bindings/arm/bcm/kona-resetmgr.txt b/Documentation/devicetree/bindings/arm/bcm/kona-resetmgr.txt
new file mode 100644
index 0000000..93f31ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/kona-resetmgr.txt
@@ -0,0 +1,14 @@
+Broadcom Kona Family Reset Manager
+----------------------------------
+
+The reset manager is used on the Broadcom BCM21664 SoC.
+
+Required properties:
+  - compatible: brcm,bcm21664-resetmgr
+  - reg: memory address & range
+
+Example:
+	brcm,resetmgr at 35001f00 {
+		compatible = "brcm,bcm21664-resetmgr";
+		reg = <0x35001f00 0x24>;
+	};
-- 
1.7.9.5
