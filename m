From: rogerq@ti.com (Roger Quadros)
Date: Fri, 7 Mar 2014 12:15:04 +0200
Subject: [PATCH v3 4/8] ARM: dts: omap5: Add clocks to USB3 PHY node
In-Reply-To: <1394187308-19622-1-git-send-email-rogerq@ti.com>
References: <1394187308-19622-1-git-send-email-rogerq@ti.com>
Message-ID: <1394187308-19622-5-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB3 PHY driver now expects named clocks. Add the
relevant clocks to the USB3 PHY node.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 859a800..88bd327 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -779,6 +779,12 @@
 				      <0x4a084c00 0x40>;
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
 				ctrl-module = <&omap_control_usb3phy>;
+				clocks = <&usb_phy_cm_clk32k>,
+					 <&sys_clkin>,
+					 <&usb_otg_ss_refclk960m>;
+				clock-names =	"wkupclk",
+						"sysclk",
+						"refclk";
 				#phy-cells = <0>;
 			};
 		};
-- 
1.8.3.2
