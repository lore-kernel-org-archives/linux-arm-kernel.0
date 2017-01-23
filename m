From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 23 Jan 2017 18:00:43 +0100
Subject: [PATCH v6 01/14] devicetree: bindings: add bindings for ahci-da850
In-Reply-To: <1485190856-4711-1-git-send-email-bgolaszewski@baylibre.com>
References: <1485190856-4711-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1485190856-4711-2-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings for the TI DA850 AHCI SATA controller.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/devicetree/bindings/ata/ahci-da850.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt

diff --git a/Documentation/devicetree/bindings/ata/ahci-da850.txt b/Documentation/devicetree/bindings/ata/ahci-da850.txt
new file mode 100644
index 0000000..5f81934
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ahci-da850.txt
@@ -0,0 +1,18 @@
+Device tree binding for the TI DA850 AHCI SATA Controller
+---------------------------------------------------------
+
+Required properties:
+  - compatible: must be "ti,da850-ahci"
+  - reg: physical base addresses and sizes of the two register regions
+         used by the controller: the register map as defined by the
+         AHCI 1.1 standard and the Power Down Control Register (PWRDN)
+         for enabling/disabling the SATA clock receiver
+  - interrupts: interrupt specifier (refer to the interrupt binding)
+
+Example:
+
+	sata: sata at 218000 {
+		compatible = "ti,da850-ahci";
+		reg = <0x218000 0x2000>, <0x22c018 0x4>;
+		interrupts = <67>;
+	};
-- 
2.9.3
