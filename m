From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 16 Nov 2014 18:37:44 +0100
Subject: [PATCHv2 6/8] arm: mvebu: add common ge0/1 and spi0 pintcrl entries
 for Armada XP MV78230
In-Reply-To: <cover.1416158990.git.arno@natisbad.org>
References: <cover.1416158990.git.arno@natisbad.org>
Message-ID: <8c861a1fe1026289bf17f02dc8d69539019f28b7.1416158990.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


pinctrl entries for the two GbE interfaces using RGMII signaling w/ the PHY
via MPP0-11/MPP12-23 and the spi0 interface using MPP36-39 are common
configurations. Instead of replicating them in each .dts file, put those in
armada-xp-mv78230.dtsi file so that they can be referenced.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 2592e1c13560..85a39aed00dd 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -171,6 +171,26 @@
 				compatible = "marvell,mv78230-pinctrl";
 				reg = <0x18000 0x38>;
 
+				ge0_rgmii_pins: ge0-rgmii-pins {
+					marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
+						       "mpp4", "mpp5", "mpp6", "mpp7",
+						       "mpp8", "mpp9", "mpp10", "mpp11";
+					marvell,function = "ge0";
+				};
+
+				ge1_rgmii_pins: ge1-rgmii-pins {
+					marvell,pins = "mpp12", "mpp13", "mpp14", "mpp15",
+						       "mpp16", "mpp17", "mpp18", "mpp19",
+						       "mpp20", "mpp21", "mpp22", "mpp23";
+					marvell,function = "ge1";
+				};
+
+				spi0_pins: spi0-pins {
+					marvell,pins = "mpp36", "mpp37",
+						       "mpp38", "mpp39";
+					marvell,function = "spi";
+				};
+
 				sdio_pins: sdio-pins {
 					marvell,pins = "mpp30", "mpp31", "mpp32",
 						       "mpp33", "mpp34", "mpp35";
-- 
2.1.1
