From: b.galvani@gmail.com (Beniamino Galvani)
Date: Tue, 18 Nov 2014 21:22:33 +0100
Subject: [PATCH v3 1/3] media: rc: meson: document device tree bindings
In-Reply-To: <1416342155-26820-1-git-send-email-b.galvani@gmail.com>
References: <1416342155-26820-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1416342155-26820-2-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds binding documentation for the infrared remote control
receiver available in Amlogic Meson SoCs.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 Documentation/devicetree/bindings/media/meson-ir.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/meson-ir.txt

diff --git a/Documentation/devicetree/bindings/media/meson-ir.txt b/Documentation/devicetree/bindings/media/meson-ir.txt
new file mode 100644
index 0000000..407848e
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/meson-ir.txt
@@ -0,0 +1,14 @@
+* Amlogic Meson IR remote control receiver
+
+Required properties:
+ - compatible	: should be "amlogic,meson6-ir"
+ - reg		: physical base address and length of the device registers
+ - interrupts	: a single specifier for the interrupt from the device
+
+Example:
+
+	ir-receiver at c8100480 {
+		compatible= "amlogic,meson6-ir";
+		reg = <0xc8100480 0x20>;
+		interrupts = <0 15 1>;
+	};
-- 
1.9.1
