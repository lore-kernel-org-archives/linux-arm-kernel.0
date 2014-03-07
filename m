From: rogerq@ti.com (Roger Quadros)
Date: Fri, 7 Mar 2014 12:15:02 +0200
Subject: [PATCH v3 2/8] phy: ti-pipe3: Add clocks to PIPE3 PHY Documentation
 binding
In-Reply-To: <1394187308-19622-1-git-send-email-rogerq@ti.com>
References: <1394187308-19622-1-git-send-email-rogerq@ti.com>
Message-ID: <1394187308-19622-3-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add wakeup, system and reference clocks to DT binding documentation.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/phy/ti-phy.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
index 073a623..96ba29e 100644
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -59,6 +59,12 @@ Required properties:
    filled in "reg".
  - #phy-cells: determine the number of cells that should be given in the
    phandle while referencing this phy.
+ - clocks: a list of phandles and clock-specifier pairs, one for each entry in
+   clock-names.
+ - clock-names: should include:
+   * "wkupclk" - wakeup clock.
+   * "sysclk" - system clock.
+   * "refclk" - reference clock.
 
 Optional properties:
  - ctrl-module : phandle of the control module used by PHY driver to power on
@@ -74,4 +80,10 @@ usb3phy at 4a084400 {
 	reg-names = "phy_rx", "phy_tx", "pll_ctrl";
 	ctrl-module = <&omap_control_usb>;
 	#phy-cells = <0>;
+	clocks = <&usb_phy_cm_clk32k>,
+		 <&sys_clkin>,
+		 <&usb_otg_ss_refclk960m>;
+	clock-names =	"wkupclk",
+			"sysclk",
+			"refclk";
 };
-- 
1.8.3.2
