From: abrestic@chromium.org (Andrew Bresticker)
Date: Tue, 17 Jun 2014 23:16:12 -0700
Subject: [PATCH v1 1/9] of: Add NVIDIA Tegra XUSB mailbox binding
In-Reply-To: <1403072180-4944-1-git-send-email-abrestic@chromium.org>
References: <1403072180-4944-1-git-send-email-abrestic@chromium.org>
Message-ID: <1403072180-4944-2-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device-tree bindings for the Tegra XUSB mailbox which will be used
for communication between the Tegra XHCI controller and the host.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 .../bindings/mailbox/nvidia,tegra124-xusb-mbox.txt | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/nvidia,tegra124-xusb-mbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra124-xusb-mbox.txt b/Documentation/devicetree/bindings/mailbox/nvidia,tegra124-xusb-mbox.txt
new file mode 100644
index 0000000..c1833e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra124-xusb-mbox.txt
@@ -0,0 +1,25 @@
+NVIDIA Tegra XUSB mailbox
+=========================
+
+The Tegra XUSB mailbox is used by the Tegra XHCI controller's firmware to
+communicate with the host.
+
+Required properties:
+--------------------
+ - compatible: Should be "nvidia,tegra124-xusb-mbox".
+ - reg: Address and length of the XUSB FPCI registers.
+ - interrupts: XUSB mailbox interrupt.
+
+Example:
+--------
+	mbox: mailbox at 0,70098000 {
+		compatible = "nvidia,tegra124-xusb-mbox";
+		reg = <0x0 0x70098000 0x0 0x1000>;
+		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	usb at 0,70090000 {
+		...
+		nvidia,xusb-mbox = <&mbox>;
+		...
+	};
-- 
2.0.0.526.g5318336
