From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sat, 08 Jul 2017 20:16:44 +0100
Subject: [PATCH 4/6] arm64: dts: marvell: mcbin: properly add GPIO
In-Reply-To: <20170708191317.GM4902@n2100.armlinux.org.uk>
References: <20170708191317.GM4902@n2100.armlinux.org.uk>
Message-ID: <E1dTvDg-0007Ew-Tv@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Proprely add GPIO specifications for the USB 5V regulator.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index 773a157e4af5..b20c17160cbb 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -79,12 +79,13 @@
 
 	v_5v0_usb3_hst_vbus: regulator-usb3-vbus0 {
 		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&cpm_gpio2 15 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cpm_xhci_vbus_pins>;
 		regulator-name = "v_5v0_usb3_hst_vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		gpio = <&cpm_gpio2 15 GPIO_ACTIVE_HIGH>;
-		regulator-always-on;
-		enable-active-high;
 		status = "okay";
 	};
 
@@ -139,6 +140,10 @@
 		marvell,pins = "mpp37", "mpp38";
 		marvell,function = "i2c0";
 	};
+	cpm_xhci_vbus_pins: xhci0-vbus-pins {
+		marvell,pins = "mpp47";
+		marvell,function = "gpio";
+	};
 	cpm_sdhci_pins: sdhci-pins {
 		marvell,pins = "mpp55", "mpp56", "mpp57", "mpp58", "mpp59",
 			       "mpp60", "mpp61";
-- 
2.7.4
