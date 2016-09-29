From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 29 Sep 2016 21:00:10 +0200
Subject: [PATCH] ARM: dts: armada-xp-rn2120: add pinmuxing for ethernet
Message-ID: <20160929190010.11753-1-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Up to now working ethernet depended on the bootloader to configure the
pinmuxing. Make it explicit.

As a side effect this change makes ethernet work in barebox.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index 3e930fdbaabc..b6bf5344fbbe 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -164,12 +164,18 @@
 			};
 
 			ethernet at 70000 {
+				pinctrl-0 = <&ge0_rgmii_pins>;
+				pinctrl-names = "default";
+
 				status = "okay";
 				phy = <&phy0>;
 				phy-mode = "rgmii-id";
 			};
 
 			ethernet at 74000 {
+				pinctrl-0 = <&ge1_rgmii_pins>;
+				pinctrl-names = "default";
+
 				status = "okay";
 				phy = <&phy1>;
 				phy-mode = "rgmii-id";
-- 
2.9.3
