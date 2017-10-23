From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 23 Oct 2017 19:35:11 +0800
Subject: [PATCH v2 1/2] dt-bindings: add bindings doc for HiSilicon INNO USB2
 PHY
In-Reply-To: <1508758512-22900-1-git-send-email-shawnguo@kernel.org>
References: <1508758512-22900-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1508758512-22900-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pengcheng Li <lpc.li@hisilicon.com>

It adds device tree bindings document for HiSilicon INNO USB2 PHY.

Signed-off-by: Pengcheng Li <lpc.li@hisilicon.com>
Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
new file mode 100644
index 000000000000..4ef7af24a703
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
@@ -0,0 +1,31 @@
+HiSilicon INNO USB2 PHY
+
+Required properties:
+- compatible: Should be one of the following strings:
+	"hisilicon,inno-usb2-phy",
+	"hisilicon,hi3798cv200-usb2-phy".
+- #phy-cells: Should be 1. The specifier is the index of the PHY port to
+  reference.
+- hisilicon,peripheral-syscon: The phandle of syscon used to control PHY,
+  followed by a integer cell which defines the syscon register offset used
+  to talk to PHY.
+- clocks: The phandle and clock specifier pair for reference clock utmi_refclk.
+- resets: The list of phandle and reset specifier pairs for each reset signal
+  in reset-names.
+- reset-names: Should contain "power_on", "utmi0" and "utmi1". The "utmi1"
+  should exist only if the device has two PHY port.
+
+Refer to phy/phy-bindings.txt for the generic PHY binding properties
+
+Example:
+
+	usb2_phy1: usb2-phy1 {
+		compatible = "hisilicon,hi3798cv200-usb2-phy";
+		#phy-cells = <1>;
+		hisilicon,peripheral-syscon = <&peri_ctrl 0x120>;
+		clocks = <&crg HISTB_USB2_PHY1_REF_CLK>;
+		resets = <&crg 0xbc 4>,
+			 <&crg 0xbc 8>,
+			 <&crg 0xbc 9>;
+		reset-names = "power_on", "utmi0", "utmi1";
+	};
-- 
1.9.1
