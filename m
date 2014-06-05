From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Thu,  5 Jun 2014 17:48:44 +0200
Subject: [PATCH 7/9] Documentation: bindings: add doc for the Berlin ChipIdea
 USB driver
In-Reply-To: <1401983326-19205-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1401983326-19205-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1401983326-19205-8-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the Marvell Berlin USB driver bindings.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 .../devicetree/bindings/usb/ci-hdrc-berlin.txt         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-berlin.txt

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-berlin.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-berlin.txt
new file mode 100644
index 000000000000..a3fc9054b830
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-berlin.txt
@@ -0,0 +1,18 @@
+* Marvell Berlin usb controllers
+
+Required properties:
+- compatible: should be "marvell,berlin-usb"
+- reg: base address and length of the registers
+- interrupts: interrupt for the USB controller
+- clocks: reference to the USB clock
+- marvell,usbphy: reference to the USB PHY
+
+Example:
+
+	usb at f7ed0000 {
+		compatible = "marvell,berlin-usb";
+		reg = <0xf7ed0000 0x10000>;
+		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&chip CLKID_USB0>;
+		marvell,usbphy = <&usb_phy0>;
+	};
-- 
1.9.1
