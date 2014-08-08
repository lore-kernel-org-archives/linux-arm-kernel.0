From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  8 Aug 2014 12:18:54 -0300
Subject: [PATCH 4/6] ARM: mvebu: Add proper pin muxing on Netgear ReadyNAS 102
In-Reply-To: <1407511136-26477-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1407511136-26477-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1407511136-26477-5-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the required pin muxing for the network interfaces and
the MDIO interface to be properly initialized. For instance, this makes
it possible for a bootloader to initialize and access the network interfaces

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-netgear-rn102.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index d6d572e..4b793da 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -101,12 +101,16 @@
 			};
 
 			mdio {
+				pinctrl-0 = <&mdio_pins>;
+				pinctrl-names = "default";
 				phy0: ethernet-phy at 0 { /* Marvell 88E1318 */
 					reg = <0>;
 				};
 			};
 
 			ethernet at 74000 {
+				pinctrl-0 = <&ge1_pins>;
+				pinctrl-names = "default";
 				status = "okay";
 				phy = <&phy0>;
 				phy-mode = "rgmii-id";
-- 
2.0.1
