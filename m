From: abrestic@chromium.org (Andrew Bresticker)
Date: Mon, 27 Apr 2015 15:37:19 -0700
Subject: [PATCH V7 6/9] mailbox: Add NVIDIA Tegra XUSB mailbox binding
In-Reply-To: <1430174242-29465-1-git-send-email-abrestic@chromium.org>
References: <1430174242-29465-1-git-send-email-abrestic@chromium.org>
Message-ID: <1430174242-29465-7-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device-tree bindings for the Tegra XUSB mailbox which will be used
for communication between the Tegra xHCI controller's firmware and the
host processor.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>
---
Changes from v6:
 - Removed reg/interrupts properties.
No changes from v3/v4/v5.
Changes from v2:
 - Dropped channel specifier.
 - Added pointer to mailbox documentation.
Changes from v1:
 - Updated to use common mailbox bindings.
---
 .../bindings/mailbox/nvidia,tegra124-xusb-mbox.txt | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/nvidia,tegra124-xusb-mbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra124-xusb-mbox.txt b/Documentation/devicetree/bindings/mailbox/nvidia,tegra124-xusb-mbox.txt
new file mode 100644
index 0000000..9d89afa
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra124-xusb-mbox.txt
@@ -0,0 +1,30 @@
+NVIDIA Tegra XUSB mailbox
+=========================
+
+The Tegra XUSB mailbox is used by the Tegra xHCI controller's firmware to
+communicate requests to the host and PHY drivers.
+
+Refer to ./mailbox.txt for generic information about mailbox device-tree
+bindings.
+
+Required properties:
+--------------------
+ - compatible: For Tegra124, must contain "nvidia,tegra124-xusb-mbox".
+   Otherwise, must contain '"nvidia,<chip>-xusb-mbox",
+   "nvidia,tegra124-xusb-mbox"' where <chip> is tegra132.
+ - #mbox-cells: Should be 0.  There is only one physical channel.
+
+Example:
+--------
+	mailbox {
+		compatible = "nvidia,tegra124-xusb-mbox";
+
+		#mbox-cells = <0>;
+	};
+
+	usb-host {
+		...
+		mboxes = <&xusb_mbox>;
+		mbox-names = "xusb";
+		...
+	};
-- 
2.2.0.rc0.207.ga3a616c
