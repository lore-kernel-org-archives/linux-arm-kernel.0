From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Wed, 16 Jul 2014 10:26:02 +0200
Subject: [PATCH v3 08/12] Documentation: bindings: add doc for the USB2
 ChipIdea USB driver
In-Reply-To: <1405499166-6726-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1405499166-6726-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1405499166-6726-9-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the USB2 ChipIdea driver (ci13xxx) bindings.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 .../devicetree/bindings/usb/ci-hdrc-usb2.txt       | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
new file mode 100644
index 000000000000..fb3157183e6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
@@ -0,0 +1,23 @@
+* USB2 ChipIdea USB controller for ci13xxx
+
+Required properties:
+- compatible: should be "chipidea,usb2"
+- reg: base address and length of the registers
+- interrupts: interrupt for the USB controller
+
+Optional properties:
+- clocks: reference to the USB clock
+- usb-phy: reference to the USB PHY
+- vbus-supply: reference to the VBUS regulator
+- dma-mask: DMA bit mask
+
+Example:
+
+	usb at f7ed0000 {
+		compatible = "chipidea,usb2";
+		reg = <0xf7ed0000 0x10000>;
+		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&chip CLKID_USB0>;
+		usb-phy = <&usb_phy0>;
+		vbus-supply = <&reg_usb0_vbus>;
+	};
-- 
1.9.1
