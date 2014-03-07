From: rogerq@ti.com (Roger Quadros)
Date: Fri, 7 Mar 2014 15:09:08 +0200
Subject: [PATCH 5/8] phy: omap-usb2: Add clock names to Documentation binding
In-Reply-To: <1394197751-28984-1-git-send-email-rogerq@ti.com>
References: <1394197751-28984-1-git-send-email-rogerq@ti.com>
Message-ID: <1394197751-28984-6-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "wkupclk" and "refclk" information to DT binding information.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/phy/ti-phy.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
index 4ab9cb1..49c381c 100644
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -36,6 +36,11 @@ Required properties:
  - reg : Address and length of the register set for the device.
  - #phy-cells: determine the number of cells that should be given in the
    phandle while referencing this phy.
+ - clocks: a list of phandles and clock-specifier pairs, one for each entry in
+   clock-names.
+ - clock-names: should include:
+   * "wkupclk" - wakeup clock.
+   * "refclk" - reference clock (optional).
 
 Optional properties:
  - ctrl-module : phandle of the control module used by PHY driver to power on
@@ -48,6 +53,8 @@ usb2phy at 4a0ad080 {
 	reg = <0x4a0ad080 0x58>;
 	ctrl-module = <&omap_control_usb>;
 	#phy-cells = <0>;
+	clocks = <&usb_phy_cm_clk32k>, <&usb_otg_ss_refclk960m>;
+	clock-names = "wkupclk", "refclk";
 };
 
 TI PIPE3 PHY
-- 
1.8.3.2
