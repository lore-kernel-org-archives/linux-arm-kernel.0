From: code@mmayer.net (Markus Mayer)
Date: Tue, 13 Jun 2017 15:37:09 -0700
Subject: [PATCH v2 1/2] dt/bindings: Add bindings for Broadcom STB DRAM Sensors
In-Reply-To: <20170613223710.31719-1-code@mmayer.net>
References: <20170613223710.31719-1-code@mmayer.net>
Message-ID: <20170613223710.31719-2-code@mmayer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Mayer <mmayer@broadcom.com>

Provide bindings for the Broadcom STB DDR PHY Front End (DPFE).

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 .../devicetree/bindings/soc/bcm/brcm,dpfe-cpu.txt  | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,dpfe-cpu.txt

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,dpfe-cpu.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,dpfe-cpu.txt
new file mode 100644
index 0000000..82d923e
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,dpfe-cpu.txt
@@ -0,0 +1,27 @@
+DDR PHY Front End (DPFE) for Broadcom STB
+=========================================
+
+DPFE and the DPFE firmware provide an interface for the host CPU to
+communicate with the DCPU, which resides inside the DDR PHY.
+
+There are three memory regions for interacting with the DCPU. These are
+specified in a single reg property.
+
+Required properties:
+  - compatible: must be "brcm,bcm7271-dpfe-cpu", "brcm,bcm7268-dpfe-cpu"
+    or "brcm,dpfe-cpu"
+  - reg: must reference three register ranges
+      - start address and length of the DCPU register space
+      - start address and length of the DCPU data memory space
+      - start address and length of the DCPU instruction memory space
+  - reg-names: must contain "dpfe-cpu", "dpfe-dmem", and "dpfe-imem";
+        they must be in the same order as the register declarations
+
+Example:
+	dpfe_cpu0: dpfe-cpu at f1132000 {
+		compatible = "brcm,bcm7271-dpfe-cpu", "brcm,dpfe-cpu";
+		reg =  <0xf1132000 0x180
+			0xf1134000 0x1000
+			0xf1138000 0x4000>;
+		reg-names = "dpfe-cpu", "dpfe-dmem", "dpfe-imem";
+	};
-- 
2.7.4
