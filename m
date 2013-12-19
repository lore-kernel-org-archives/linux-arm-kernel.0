From: mporter@linaro.org (Matt Porter)
Date: Thu, 19 Dec 2013 09:23:08 -0500
Subject: [PATCH v8 7/9] phy: add Broadcom Kona USB2 PHY DT binding
In-Reply-To: <1387462990-12039-1-git-send-email-mporter@linaro.org>
References: <1387462990-12039-1-git-send-email-mporter@linaro.org>
Message-ID: <1387462990-12039-8-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a binding that describes the Broadcom Kona USB2 PHY found
on the BCM281xx family of SoCs.

Signed-off-by: Matt Porter <mporter@linaro.org>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/phy/bcm-phy.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/bcm-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/bcm-phy.txt b/Documentation/devicetree/bindings/phy/bcm-phy.txt
new file mode 100644
index 0000000..3dc8b3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/bcm-phy.txt
@@ -0,0 +1,15 @@
+BROADCOM KONA USB2 PHY
+
+Required properties:
+ - compatible: brcm,kona-usb2-phy
+ - reg: offset and length of the PHY registers
+ - #phy-cells: must be 0
+Refer to phy/phy-bindings.txt for the generic PHY binding properties
+
+Example:
+
+	usbphy: usb-phy at 3f130000 {
+		compatible = "brcm,kona-usb2-phy";
+		reg = <0x3f130000 0x28>;
+		#phy-cells = <0>;
+	};
-- 
1.8.4
