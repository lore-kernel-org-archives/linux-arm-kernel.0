From: pankaj.bansal@nxp.com (Pankaj Bansal)
Date: Fri,  5 Oct 2018 14:25:04 +0530
Subject: [PATCH 1/2] dt-bindings: soc: fsl: Document Qixis FPGA usage
In-Reply-To: <20181005085505.29024-1-pankaj.bansal@nxp.com>
References: <20181005085505.29024-1-pankaj.bansal@nxp.com>
Message-ID: <20181005085505.29024-2-pankaj.bansal@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

an FPGA-based system controller, called ?Qixis?, which
manages several critical system features, including:
? Reset sequencing
? Power supply configuration
? Board configuration
? hardware configuration

The qixis registers are accessible over one or more system-specific
interfaces, typically I2C, JTAG or an embedded processor.

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
---
 .../bindings/soc/fsl/qixis_ctrl.txt          | 33 ++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/fsl/qixis_ctrl.txt b/Documentation/devicetree/bindings/soc/fsl/qixis_ctrl.txt
new file mode 100644
index 000000000000..bc2950cab71d
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/fsl/qixis_ctrl.txt
@@ -0,0 +1,33 @@
+* QIXIS FPGA block
+
+an FPGA-based system controller, called ?Qixis?, which
+manages several critical system features, including:
+? Configuration switch monitoring
+? Power on/off sequencing
+? Reset sequencing
+? Power supply configuration
+? Board configuration
+? hardware configuration
+? Background power data collection (DCM)
+? Fault monitoring
+? RCW bypass SRAM (replace flash RCW with internal RCW) (NOR only)
+? Dedicated functional validation blocks (POSt/IRS, triggered event, and so on)
+? I2C master for remote board control even with no DUT available
+
+The qixis registers are accessible over one or more system-specific interfaces,
+typically I2C, JTAG or an embedded processor.
+
+Required properties:
+
+ - compatible : string, must contain "fsl,fpga-qixis-i2c"
+ - reg : i2c address of the qixis device.
+
+Examples:
+	/* The FPGA node */
+        fpga at 66 {
+		compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c";
+		reg = <0x66>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	}
+
-- 
2.17.1
