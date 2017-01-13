From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Fri, 13 Jan 2017 13:37:57 +0100
Subject: [PATCH 03/10] devicetree: bindings: add bindings for ahci-da850
In-Reply-To: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1484311084-31547-4-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings for the TI DA850 AHCI SATA controller.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../devicetree/bindings/ata/ahci-da850.txt          | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt

diff --git a/Documentation/devicetree/bindings/ata/ahci-da850.txt b/Documentation/devicetree/bindings/ata/ahci-da850.txt
new file mode 100644
index 0000000..d07c241
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ahci-da850.txt
@@ -0,0 +1,21 @@
+Device tree binding for the TI DA850 AHCI SATA Controller
+---------------------------------------------------------
+
+Required properties:
+  - compatible: must be "ti,da850-ahci"
+  - reg: physical base addresses and sizes of the controller's register areas
+  - interrupts: interrupt specifier (refer to the interrupt binding)
+
+Optional properties:
+  - clocks: clock specifier (refer to the common clock binding)
+  - da850,clk_multiplier: the multiplier for the reference clock needed
+                          for 1.5GHz PLL output
+
+Example:
+
+	sata: ahci at 0x218000 {
+		compatible = "ti,da850-ahci";
+		reg = <0x218000 0x2000>, <0x22c018 0x4>;
+		interrupts = <67>;
+		da850,clk_multiplier = <7>;
+	};
-- 
2.9.3
