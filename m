From: linux@prisktech.co.nz (Tony Prisk)
Date: Sun, 21 Oct 2012 11:10:32 +1300
Subject: [PATCH v2 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <1350771032-11527-1-git-send-email-linux@prisktech.co.nz>
References: <1350771032-11527-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1350771032-11527-3-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a binding document for ehci-platform driver.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 .../devicetree/bindings/usb/ehci-platform.txt      |   27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ehci-platform.txt

diff --git a/Documentation/devicetree/bindings/usb/ehci-platform.txt b/Documentation/devicetree/bindings/usb/ehci-platform.txt
new file mode 100644
index 0000000..930b19e
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ehci-platform.txt
@@ -0,0 +1,27 @@
+Generic Platform EHCI Controller
+-----------------------------------------------------
+
+Required properties:
+- compatible : "linux,ehci-platform"
+- reg : Should contain 1 register ranges(address and length)
+- interrupts : EHCI controller interrupt
+
+Optional properties:
+- caps-offset : offset to the capabilities register (default = 0)
+- has-tt : controller has transaction translator(s).
+- has-synopsys-hc-bug : controller has the synopsys hc bug
+- no-io-watchdog : controller does not need io watchdog
+
+- big-endian : descriptors and registers are both big endian. This
+  is the equivalent of specifying big-endian-desc and big-endian-regs.
+OR
+- big-endian-desc : descriptors are in big-endian format
+- big-endian-regs : mmio is in big-endian format
+
+Example:
+	ehci at d8007c00 {
+		compatible = "ehci-platform";
+		reg = <0xd8007c00 0x200>;
+		interrupts = <43>;
+		has-tt;
+	};
-- 
1.7.9.5
