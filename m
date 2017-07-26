From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Wed, 26 Jul 2017 14:06:00 +0800
Subject: [PATCH v2 1/4] dt-bindings: phy-hisi-inno-usb2: add support for
 hisi-inno-usb2 phy
In-Reply-To: <1501049163-18892-1-git-send-email-xuejiancheng@hisilicon.com>
References: <1501049163-18892-1-git-send-email-xuejiancheng@hisilicon.com>
Message-ID: <1501049163-18892-2-git-send-email-xuejiancheng@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for hisi-inno-usb2 phy.

Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
---
 .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
new file mode 100644
index 0000000..417eeaa
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
@@ -0,0 +1,31 @@
+HiSilicon INNO USB2 PHY
+-----------------------
+Required properties:
+- compatible: Should be one of the following strings:
+		"hisilicon,inno-usb2-phy",
+		"hisilicon,hi3798cv200-usb2-phy",
+- #phy-cells: Shall be 0.
+- hisilicon,peripheral-syscon: Phandle of syscon used to control phy.
+- hisilicon,phycon-reg: Offset of the phy control register in the syscon.
+- hisilicon,port-num: Number of utmi ports. Range [1,2].
+- clocks: Phandle and clock specifier pair for reference clock utmi_refclk.
+- resets: List of phandle and reset specifier pairs for each reset signal
+in reset-names.
+- reset-names: Shall be "power_on", "utmi0", "utmi1". Thereinto, utmi[n] is
+required only if port[n] exists.
+
+Refer to phy/phy-bindings.txt for the generic PHY binding properties
+
+Example:
+usb2_phy: phy {
+		 compatible = "hisilicon,inno-usb2-phy";
+		 #phy-cells = <0>;
+		 hisilicon,peripheral-syscon = <&peri_ctrl>;
+		 hisilicon,phycon-reg = <0x120>;
+		 hisilicon,port-num = <2>;
+		 clocks = <&crg USB2_PHY_UTMI_REF_CLK>;
+		 resets = <&crg 0xbc 2>,
+			  <&crg 0xbc 8>,
+			  <&crg 0xbc 9>,
+		 reset-names = "power_on", "utmi0", "utmi1";
+	 };
-- 
1.9.1
