From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  8 Aug 2014 12:18:56 -0300
Subject: [PATCH 6/6] ARM: mvebu: Add proper pin muxing on Armada 370 RD board
In-Reply-To: <1407511136-26477-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1407511136-26477-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1407511136-26477-7-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the required pin muxing for the network interfaces and
the MDIO interface to be properly initialized. For instance, this makes
it possible for a bootloader to initialize and access the network interfaces

Only the second network interface is pin muxed. The first network interface is
connected to the PHY using SGMII, which uses a dedicated SerDes lane.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-rd.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 4169f40..7fcd36c 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -59,6 +59,8 @@
 			};
 
 			mdio {
+				pinctrl-0 = <&mdio_pins>;
+				pinctrl-names = "default";
 				phy0: ethernet-phy at 0 {
 					reg = <0>;
 				};
@@ -74,6 +76,8 @@
 				phy-mode = "sgmii";
 			};
 			ethernet at 74000 {
+				pinctrl-0 = <&ge1_pins>;
+				pinctrl-names = "default";
 				status = "okay";
 				phy = <&phy1>;
 				phy-mode = "rgmii-id";
-- 
2.0.1
