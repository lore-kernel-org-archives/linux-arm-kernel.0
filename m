From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 11 Aug 2014 09:14:38 -0300
Subject: [PATCH v2 3/6] ARM: mvebu: Add proper pin muxing on the Armada 370 DB
 board
In-Reply-To: <1407759281-11513-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1407759281-11513-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1407759281-11513-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the required pin muxing for the network interfaces and
the MDIO interface to be properly initialized. For instance, this makes
it possible for a bootloader to initialize and access the network interfaces

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 416f4e5..a495e58 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -43,6 +43,8 @@
 			};
 
 			mdio {
+				pinctrl-0 = <&mdio_pins>;
+				pinctrl-names = "default";
 				phy0: ethernet-phy at 0 {
 					reg = <0>;
 				};
@@ -53,11 +55,15 @@
 			};
 
 			ethernet at 70000 {
+				pinctrl-0 = <&ge0_rgmii_pins>;
+				pinctrl-names = "default";
 				status = "okay";
 				phy = <&phy0>;
 				phy-mode = "rgmii-id";
 			};
 			ethernet at 74000 {
+				pinctrl-0 = <&ge1_rgmii_pins>;
+				pinctrl-names = "default";
 				status = "okay";
 				phy = <&phy1>;
 				phy-mode = "rgmii-id";
-- 
2.0.1
