From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 02 Jan 2017 14:58:46 +0000
Subject: [PATCH 2/9] ARM: dts: armada388-clearfog: move sdhci pinctrl node to
 microsom
In-Reply-To: <E1cO43Q-0007yJ-ON@rmk-PC.armlinux.org.uk>
References: <E1cO43Q-0007yJ-ON@rmk-PC.armlinux.org.uk>
Message-ID: <E1cO44U-00082N-TY@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the SDHCI pinctrl node to the microsom file - the microsom can have
optional eMMC support which uses these same pinctrl settings, so it is
sensible to have these here.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/armada-388-clearfog.dts           | 8 +-------
 arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi | 7 +++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/armada-388-clearfog.dts b/arch/arm/boot/dts/armada-388-clearfog.dts
index 3980d05f5ece..9bf399dd1786 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/armada-388-clearfog.dts
@@ -257,12 +257,6 @@
 					marvell,pins = "mpp20";
 					marvell,function = "gpio";
 				};
-				clearfog_sdhci_pins: clearfog-sdhci-pins {
-					marvell,pins = "mpp21", "mpp28",
-						       "mpp37", "mpp38",
-						       "mpp39", "mpp40";
-					marvell,function = "sd0";
-				};
 				clearfog_spi1_cs_pins: spi1-cs-pins {
 					marvell,pins = "mpp55";
 					marvell,function = "spi1";
@@ -300,7 +294,7 @@
 				bus-width = <4>;
 				cd-gpios = <&gpio0 20 GPIO_ACTIVE_LOW>;
 				no-1-8-v;
-				pinctrl-0 = <&clearfog_sdhci_pins
+				pinctrl-0 = <&microsom_sdhci_pins
 					     &clearfog_sdhci_cd_pins>;
 				pinctrl-names = "default";
 				status = "okay";
diff --git a/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi b/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
index 8a84fe3e9c28..6608657b9994 100644
--- a/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
+++ b/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
@@ -99,6 +99,13 @@
 					marvell,pins = "mpp45";
 					marvell,function = "ref";
 				};
+				/* Optional eMMC */
+				microsom_sdhci_pins: microsom-sdhci-pins {
+					marvell,pins = "mpp21", "mpp28",
+						       "mpp37", "mpp38",
+						       "mpp39", "mpp40";
+					marvell,function = "sd0";
+				};
 			};
 
 			rtc at a3800 {
-- 
2.7.4
