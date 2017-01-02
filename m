From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 02 Jan 2017 15:27:16 +0000
Subject: [PATCH 2/5] ARM: dts: armada388-clearfog: move device specific
 pinctrl nodes
In-Reply-To: <E1cO4UH-0008SR-GW@rmk-PC.armlinux.org.uk>
References: <E1cO4UH-0008SR-GW@rmk-PC.armlinux.org.uk>
Message-ID: <E1cO4W4-000060-EK@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the device specific pinctrl nodes over to use the label form to
reference the pin mux controller, rather than replicating the device
node path.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/armada-388-clearfog.dtsi         | 50 +++++++++++-----------
 .../arm/boot/dts/armada-38x-solidrun-microsom.dtsi | 27 ++++++------
 2 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/arch/arm/boot/dts/armada-388-clearfog.dtsi b/arch/arm/boot/dts/armada-388-clearfog.dtsi
index 770d4bff6884..7946400b4bf2 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dtsi
+++ b/arch/arm/boot/dts/armada-388-clearfog.dtsi
@@ -217,31 +217,6 @@
 				status = "okay";
 			};
 
-			pinctrl at 18000 {
-				clearfog_i2c1_pins: i2c1-pins {
-					/* SFP, PCIe, mSATA, mikrobus */
-					marvell,pins = "mpp26", "mpp27";
-					marvell,function = "i2c1";
-				};
-				clearfog_sdhci_cd_pins: clearfog-sdhci-cd-pins {
-					marvell,pins = "mpp20";
-					marvell,function = "gpio";
-				};
-				mikro_pins: mikro-pins {
-					/* int: mpp22 rst: mpp29 */
-					marvell,pins = "mpp22", "mpp29";
-					marvell,function = "gpio";
-				};
-				mikro_spi_pins: mikro-spi-pins {
-					marvell,pins = "mpp43";
-					marvell,function = "spi1";
-				};
-				mikro_uart_pins: mikro-uart-pins {
-					marvell,pins = "mpp24", "mpp25";
-					marvell,function = "ua1";
-				};
-			};
-
 			sata at a8000 {
 				/* pinctrl? */
 				status = "okay";
@@ -297,6 +272,31 @@
 	};
 };
 
+&pinctrl {
+	clearfog_i2c1_pins: i2c1-pins {
+		/* SFP, PCIe, mSATA, mikrobus */
+		marvell,pins = "mpp26", "mpp27";
+		marvell,function = "i2c1";
+	};
+	clearfog_sdhci_cd_pins: clearfog-sdhci-cd-pins {
+		marvell,pins = "mpp20";
+		marvell,function = "gpio";
+	};
+	mikro_pins: mikro-pins {
+		/* int: mpp22 rst: mpp29 */
+		marvell,pins = "mpp22", "mpp29";
+		marvell,function = "gpio";
+	};
+	mikro_spi_pins: mikro-spi-pins {
+		marvell,pins = "mpp43";
+		marvell,function = "spi1";
+	};
+	mikro_uart_pins: mikro-uart-pins {
+		marvell,pins = "mpp24", "mpp25";
+		marvell,function = "ua1";
+	};
+};
+
 &spi1 {
 	/*
 	 * Add SPI CS pins for clearfog:
diff --git a/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi b/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
index 6608657b9994..e397421d1531 100644
--- a/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
+++ b/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
@@ -94,20 +94,6 @@
 				};
 			};
 
-			pinctrl at 18000 {
-				microsom_phy_clk_pins: microsom-phy-clk-pins {
-					marvell,pins = "mpp45";
-					marvell,function = "ref";
-				};
-				/* Optional eMMC */
-				microsom_sdhci_pins: microsom-sdhci-pins {
-					marvell,pins = "mpp21", "mpp28",
-						       "mpp37", "mpp38",
-						       "mpp39", "mpp40";
-					marvell,function = "sd0";
-				};
-			};
-
 			rtc at a3800 {
 				/*
 				 * If the rtc doesn't work, run "date reset"
@@ -134,6 +120,19 @@
 	};
 };
 
+&pinctrl {
+	microsom_phy_clk_pins: microsom-phy-clk-pins {
+		marvell,pins = "mpp45";
+		marvell,function = "ref";
+	};
+	/* Optional eMMC */
+	microsom_sdhci_pins: microsom-sdhci-pins {
+		marvell,pins = "mpp21", "mpp28", "mpp37",
+			       "mpp38", "mpp39", "mpp40";
+		marvell,function = "sd0";
+	};
+};
+
 &spi1 {
 	/* The microsom has an optional W25Q32 on board, connected to CS0 */
 	pinctrl-0 = <&spi1_pins>;
-- 
2.7.4
