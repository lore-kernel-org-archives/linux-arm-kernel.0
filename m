From: michel.pollet@bp.renesas.com (Michel Pollet)
Date: Tue, 10 Apr 2018 09:30:04 +0100
Subject: [PATCH v4 4/8] dt-bindings: reset: renesas,
 rzn1-reboot: document RZ/N1 reboot driver
In-Reply-To: <1523349015-37985-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1523349015-37985-1-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <1523349015-37985-5-git-send-email-michel.pollet@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Renesas RZ/N1 Family (Part #R9A06G0xx) requires a driver
as part of the sysctrl MFD to handle rebooting the CA7 cores.
This documents the driver bindings.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 .../bindings/power/renesas,rzn1-reboot.txt         | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt

diff --git a/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt b/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
new file mode 100644
index 0000000..8516ab0
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
@@ -0,0 +1,23 @@
+DT bindings for the Renesas RZ/N1 Reboot Driver
+
+== Reboot Driver Node ==
+
+The reboot driver is always a subnode of the system controller node, see
+renesas,rzn1-sysctrl.txt for details.
+
+Bindings:
++ Required:
+	compatible = "renesas,r9a06g032-reboot", "renesas,rzn1-reboot";
+
+Example:
+	sysctrl: sysctrl at 4000c000 {
+		compatible = "renesas,r9a06g032-sysctrl",
+				"renesas,rzn1-sysctrl",
+				"syscon", "simple-mfd";
+		reg = <0x4000c000 0x1000>;
+
+		reboot {
+			compatible = "renesas,r9a06g032-reboot",
+					"renesas,rzn1-reboot";
+		};
+	};
-- 
2.7.4
