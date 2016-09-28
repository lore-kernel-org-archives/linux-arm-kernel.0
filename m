From: atull@opensource.altera.com (Alan Tull)
Date: Wed, 28 Sep 2016 13:21:51 -0500
Subject: [PATCH v19 03/12] add bindings document for altera freeze bridge
In-Reply-To: <20160928182200.15800-1-atull@opensource.altera.com>
References: <20160928182200.15800-1-atull@opensource.altera.com>
Message-ID: <20160928182200.15800-4-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings document for the Altera Freeze Bridge.  A Freeze
Bridge is used to gate traffic to/from a region of a FPGA
such that that region can be reprogrammed.  The Freeze Bridge
exist in FPGA fabric that is not currently being reconfigured.

Signed-off-by: Alan Tull <atull@opensource.altera.com>
Signed-off-by: Matthew Gerlach <mgerlach@opensource.altera.com>
---
v19: Added in v19 of patchset, uses fpga image info struct
---
 .../bindings/fpga/altera-freeze-bridge.txt         | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt

diff --git a/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
new file mode 100644
index 0000000..97ecc11
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
@@ -0,0 +1,23 @@
+Altera Freeze Bridge Controller Driver
+
+The Altera Freeze Bridge Controller manages one or more freeze bridges.
+The controller can freeze/disable the bridges which prevents signal
+changes from passing through the bridge.  The controller can also
+unfreeze/enable the bridges which allows traffic to pass through the
+bridge normally.
+
+Required properties:
+- compatible		: Should contain "altr,freeze-bridge-controller"
+- regs			: base address and size for freeze bridge module
+
+Optional properties:
+- bridge-enable		: 0 if driver should disable bridge at startup
+			  1 if driver should enable bridge at startup
+			  Default is to leave bridge in current state.
+
+Example:
+	freeze_controller at 100000450 {
+		compatible = "altr,freeze-bridge-controller";
+		regs = <0x1000 0x10>;
+		bridge-enable = <0>;
+	};
-- 
2.9.3
