From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Tue, 24 Jun 2014 12:35:17 +0200
Subject: [PATCH v2 08/12] Documentation: bindings: add doc for the generic
 ChipIdea USB driver
In-Reply-To: <1403606121-6368-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1403606121-6368-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1403606121-6368-9-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the generic ChipIdea USB driver bindings.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 .../devicetree/bindings/usb/ci-hdrc-generic.txt    | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-generic.txt

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-generic.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-generic.txt
new file mode 100644
index 000000000000..4c85f9944077
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-generic.txt
@@ -0,0 +1,22 @@
+* Generic ChipIdea USB controller
+
+Required properties:
+- compatible: should be "chipidea-usb"
+- reg: base address and length of the registers
+- interrupts: interrupt for the USB controller
+
+Optional properties:
+- clocks: reference to the USB clock
+- usb-phy: reference to the USB PHY
+- vbus-supply: reference to the VBUS regulator
+
+Example:
+
+	usb at f7ed0000 {
+		compatible = "chipidea-usb";
+		reg = <0xf7ed0000 0x10000>;
+		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&chip CLKID_USB0>;
+		usb-phy = <&usb_phy0>;
+		vbus-supply = <&reg_usb0_vbus>;
+	};
-- 
1.9.1
