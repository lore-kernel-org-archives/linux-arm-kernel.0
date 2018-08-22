From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 22 Aug 2018 22:43:05 +0200
Subject: [PATCH 12/14] dt-bindings: ehci-mv: add bindings
In-Reply-To: <20180822204307.13251-1-lkundrak@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
Message-ID: <20180822204307.13251-13-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../devicetree/bindings/usb/ehci-mv.txt       | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ehci-mv.txt

diff --git a/Documentation/devicetree/bindings/usb/ehci-mv.txt b/Documentation/devicetree/bindings/usb/ehci-mv.txt
new file mode 100644
index 000000000000..335589895763
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ehci-mv.txt
@@ -0,0 +1,23 @@
+* Marvell PXA/MMP EHCI controller.
+
+Required properties:
+
+- compatible: must be "marvell,pxau2o-ehci"
+- reg: physical base addresses of the controller and length of memory mapped region
+- interrupts: one EHCI controller interrupt should be described here
+- clocks: phandle list of usb clocks
+- clock-names: should be "USBCLK"
+- phys: phandle for the PHY device
+- phy-names: should be "usb"
+
+Example:
+
+	ehci0: usb-ehci at d4208000 {
+		compatible = "marvell,pxau2o-ehci";
+		reg = <0xd4208000 0x200>;
+		interrupts = <44>;
+		clocks = <&soc_clocks MMP2_CLK_USB>;
+		clock-names = "USBCLK";
+		phys = <&usb_otg_phy>;
+		phy-names = "usb";
+	};
-- 
2.17.1
