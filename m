From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 20 Oct 2012 16:17:33 +1300
Subject: [PATCH 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <1350703053-4661-1-git-send-email-linux@prisktech.co.nz>
References: <1350703053-4661-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1350703053-4661-3-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a binding document for ehci-platform driver.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 .../devicetree/bindings/usb/ehci-platform.txt      |   22 ++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ehci-platform.txt

diff --git a/Documentation/devicetree/bindings/usb/ehci-platform.txt b/Documentation/devicetree/bindings/usb/ehci-platform.txt
new file mode 100644
index 0000000..faeffe4
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ehci-platform.txt
@@ -0,0 +1,22 @@
+Generic Platform EHCI Controller
+-----------------------------------------------------
+
+Required properties:
+- compatible : "ehci-platform"
+- reg : Should contain 1 register ranges(address and length)
+- interrupts : EHCI controller interrupt
+
+Optional properties:
+- caps-offset : offset to the capabilities register (default = 0)
+- has-tt : controller has transaction translator(s).
+- big-endian-desc : descriptors are in big-endian format
+- big-endian-mmio : mmio is in big-endian format
+- has-synopsys-hc-bug : controller has the synopsys hc bug
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
