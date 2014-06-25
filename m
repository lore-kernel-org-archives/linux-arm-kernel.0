From: fkan@apm.com (Feng Kan)
Date: Wed, 25 Jun 2014 16:03:22 -0700
Subject: [PATCH V7 2/6] Documentation: power: reset: Add documentation for
 generic SYSCON reboot driver
In-Reply-To: <1403737406-6474-1-git-send-email-fkan@apm.com>
References: <1403737406-6474-1-git-send-email-fkan@apm.com>
Message-ID: <1403737406-6474-3-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for generic SYSCON reboot driver.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 .../bindings/power/reset/syscon-reboot.txt         | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot.txt

diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt b/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
new file mode 100644
index 0000000..1190631
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
@@ -0,0 +1,23 @@
+Generic SYSCON mapped register reset driver
+
+This is a generic reset driver using syscon to map the reset register.
+The reset is generally performed with a write to the reset register
+defined by the register map pointed by syscon reference plus the offset
+with the mask defined in the reboot node.
+
+Required properties:
+- compatible: should contain "syscon-reboot"
+- regmap: this is phandle to the register map node
+- offset: offset in the register map for the reboot register (in bytes)
+- mask: the reset value written to the reboot register (32 bit access)
+
+Default will be little endian mode, 32 bit access only.
+
+Examples:
+
+	reboot {
+	   compatible = "syscon-reboot";
+	   regmap = <&regmapnode>;
+	   offset = <0x0>;
+	   mask = <0x1>;
+	};
-- 
1.9.1
