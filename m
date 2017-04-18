From: code@mmayer.net (Markus Mayer)
Date: Tue, 18 Apr 2017 13:17:01 -0700
Subject: [PATCH 1/2] dt/bindings: Add bindings for Broadcom STB DRAM Sensors
In-Reply-To: <20170418201702.57019-1-code@mmayer.net>
References: <20170418201702.57019-1-code@mmayer.net>
Message-ID: <20170418201702.57019-2-code@mmayer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Mayer <mmayer@broadcom.com>

Provide bindings for the Broadcom STB DDR PHY Front End (DPFE).

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 .../devicetree/bindings/hwmon/brcmstb-dpfe.txt     | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/brcmstb-dpfe.txt

diff --git a/Documentation/devicetree/bindings/hwmon/brcmstb-dpfe.txt b/Documentation/devicetree/bindings/hwmon/brcmstb-dpfe.txt
new file mode 100644
index 0000000..3519197
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/brcmstb-dpfe.txt
@@ -0,0 +1,68 @@
+DDR PHY Front End (DPFE) for Broadcom STB
+=========================================
+
+DPFE and the DPFE firmware provide an interface for the host CPU to
+communicate with the DCPU, which resides inside the DDR PHY.
+
+There are three memory regions for interacting with the DCPU.
+
+The DCPU Register Space
+-----------------------
+
+Required properties:
+  - compatible: must be one of brcm,bcm7271-dpfe-cpu, brcm,dpfe-cpu-v12.0.0.0
+    or brcm,dpfe-cpu
+  - reg: must reference the start address and length of the DCPU register
+    space
+
+Optional properties:
+  - cell-index: the index of the DPFE instance; will default to 0 if not set
+
+Example:
+	dpfe_cpu0: dpfe-cpu at f1132000 {
+		compatible = "brcm,bcm7271-dpfe-cpu",
+			"brcm,dpfe-cpu-v12.0.0.0",
+			"brcm,dpfe-cpu";
+		reg = <0xf1132000 0x180>;
+		cell-index = <0>;
+	};
+
+The DCPU Data Memory Space
+--------------------------
+
+Required properties:
+  - compatible: must be one of brcm,bcm7271-dpfe-dmem, brcm,dpfe-dmem-v12.0.0.0
+    or brcm,dpfe-dmem
+  - reg: must reference the start address and length of the DCPU DMEM space
+
+Optional properties:
+  - cell-index: the index of the DPFE instance; will default to 0 if not set
+
+Example:
+	dpfe_dmem0: dpfe-dmem at f1134000 {
+		compatible = "brcm,bcm7271-dpfe-dmem",
+			"brcm,dpfe-dmem-v12.0.0.0",
+			"brcm,dpfe-dmem";
+		reg = <0xf1134000 0x1000>;
+		cell-index = <0>;
+	};
+
+The DCPU Instruction Memory Space
+---------------------------------
+
+Required properties:
+  - compatible: must be one of brcm,bcm7271-dpfe-imem, brcm,dpfe-imem-v12.0.0.0
+    or brcm,dpfe-imem
+  - reg: must reference the start address and length of the DCPU IMEM space
+
+Optional properties:
+  - cell-index: the index of the DPFE instance; will default to 0 if not set
+
+Example:
+	dpfe_imem0: dpfe-imem at f1138000 {
+		compatible = "brcm,bcm7271-dpfe-imem",
+			"brcm,dpfe-imem-v12.0.0.0",
+			"brcm,dpfe-imem";
+		reg = <0xf1138000 0x4000>;
+		cell-index = <0>;
+	};
-- 
2.7.4
