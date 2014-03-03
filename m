From: rogerq@ti.com (Roger Quadros)
Date: Mon, 3 Mar 2014 17:07:26 +0200
Subject: [PATCH 04/12] ARM: dts: omap5: Add clocks to usb3_phy node
In-Reply-To: <1393859254-10937-1-git-send-email-rogerq@ti.com>
References: <1393859254-10937-1-git-send-email-rogerq@ti.com>
Message-ID: <1393859254-10937-5-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pipe3-phy driver expects certain named clocks.
Provide the necessary clocks.

CC: Beno?t Cousson <bcousson@baylibre.com>
CC: Tony Lindgren <tony@atomide.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 1c68558..a7f5930 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -760,6 +760,8 @@
 				      <0x4a084c00 0x40>;
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
 				ctrl-module = <&omap_control_usb3phy>;
+				clocks = <&usb_phy_cm_clk32k>, <&sys_clkin>;
+				clock-names = "wkupclk", "sysclk";
 				#phy-cells = <0>;
 			};
 		};
-- 
1.8.3.2
