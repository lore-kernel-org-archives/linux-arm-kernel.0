From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 24 Oct 2012 16:53:46 +0200
Subject: [PATCH 1/9] ARM: Kirkwood: Convert TS219 to pinctrl.
In-Reply-To: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
Message-ID: <1351090434-30499-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of the pinctrl driver for configuring all the pins, instead
of using the Orion mpp code.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-ts219-6281.dts |   56 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-ts219-6282.dts |   56 +++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-ts219.c      |   25 -------------
 3 files changed, 112 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-ts219-6281.dts b/arch/arm/boot/dts/kirkwood-ts219-6281.dts
index ccbf327..4d652ce 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6281.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6281.dts
@@ -3,6 +3,62 @@
 /include/ "kirkwood-ts219.dtsi"
 
 / {
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+			compatible = "marvell,88f6281-pinctrl";
+			reg = <0x10000 0x20>;
+
+			pinctrl-0 = < &pmx_uart0 &pmx_uart1 &pmx_spi
+				      &pmx_twsi0 &pmx_sata0 &pmx_sata1
+				      &pmx_ram_size &pmx_reset_button
+				      &pmx_USB_copy_button &pmx_board_id>;
+			pinctrl-names = "default";
+
+			pmx_uart0: pmx-uart0 {
+				marvell,pins = "mpp10", "mpp11";
+				marvell,function = "uart0";
+			};
+			pmx_uart1: pmx-uart1 {
+				marvell,pins = "mpp13", "mpp14";
+				marvell,function = "uart1";
+			};
+			pmx_spi: pmx-spi {
+				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3";
+				marvell,function = "spi";
+			};
+			pmx_twsi0: pmx-twsi0 {
+				marvell,pins = "mpp8", "mpp9";
+				marvell,function = "twsi0";
+			};
+			pmx_sata0: pmx-sata0 {
+				marvell,pins = "mpp5", "mpp21", "mpp23";
+				marvell,function = "sata0";
+			};
+			pmx_sata1: pmx-sata1 {
+				marvell,pins = "mpp4", "mpp20", "mpp22";
+				marvell,function = "sata1";
+			};
+			pmx_ram_size: pmx-ram-size {
+				/* RAM: 0: 256 MB, 1: 512 MB */
+				marvell,pins = "mpp36";
+				marvell,function = "gpio";
+			};
+			pmx_USB_copy_button: pmx-USB-copy-button {
+				marvell,pins = "mpp15";
+				marvell,function = "gpio";
+			};
+			pmx_reset_button: pmx-reset-button {
+				marvell,pins = "mpp16";
+				marvell,function = "gpio";
+			};
+			pmx_board_id: pmx-board-id {
+				/* 0: TS-11x, 1: TS-21x */
+				marvell,pins = "mpp44";
+				marvell,function = "gpio";
+			};
+		};
+	};
+
 	gpio_keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/kirkwood-ts219-6282.dts b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
index fbe9932..8c3d720 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6282.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
@@ -3,6 +3,62 @@
 /include/ "kirkwood-ts219.dtsi"
 
 / {
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+			compatible = "marvell,88f6282-pinctrl";
+			reg = <0x10000 0x20>;
+
+			pinctrl-0 = < &pmx_uart0 &pmx_uart1 &pmx_spi
+				      &pmx_twsi0 &pmx_sata0 &pmx_sata1
+				      &pmx_ram_size &pmx_reset_button
+				      &pmx_USB_copy_button &pmx_board_id>;
+			pinctrl-names = "default";
+
+			pmx_uart0: pmx-uart0 {
+				marvell,pins = "mpp10", "mpp11";
+				marvell,function = "uart0";
+			};
+			pmx_uart1: pmx-uart1 {
+				marvell,pins = "mpp13", "mpp14";
+				marvell,function = "uart1";
+			};
+			pmx_spi: pmx-spi {
+				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3";
+				marvell,function = "spi";
+			};
+			pmx_twsi0: pmx-twsi0 {
+				marvell,pins = "mpp8", "mpp9";
+				marvell,function = "twsi0";
+			};
+			pmx_sata0: pmx-sata0 {
+				marvell,pins = "mpp5", "mpp21", "mpp23";
+				marvell,function = "sata0";
+			};
+			pmx_sata1: pmx-sata1 {
+				marvell,pins = "mpp4", "mpp20", "mpp22";
+				marvell,function = "sata1";
+			};
+			pmx_ram_size: pmx-ram-size {
+				/* RAM: 0: 256 MB, 1: 512 MB */
+				marvell,pins = "mpp36";
+				marvell,function = "gpio";
+			};
+			pmx_reset_button: pmx-reset-button {
+				marvell,pins = "mpp37";
+				marvell,function = "gpio";
+			};
+			pmx_USB_copy_button: pmx-USB-copy-button {
+				marvell,pins = "mpp43";
+				marvell,function = "gpio";
+			};
+			pmx_board_id: pmx-board-id {
+				/* 0: TS-11x, 1: TS-21x */
+				marvell,pins = "mpp44";
+				marvell,function = "gpio";
+			};
+		};
+	};
+
 	gpio_keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
diff --git a/arch/arm/mach-kirkwood/board-ts219.c b/arch/arm/mach-kirkwood/board-ts219.c
index 1750e68..47c8287 100644
--- a/arch/arm/mach-kirkwood/board-ts219.c
+++ b/arch/arm/mach-kirkwood/board-ts219.c
@@ -26,41 +26,16 @@
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
 #include "common.h"
-#include "mpp.h"
 #include "tsx1x-common.h"
 
 static struct mv643xx_eth_platform_data qnap_ts219_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
 };
 
-static unsigned int qnap_ts219_mpp_config[] __initdata = {
-	MPP0_SPI_SCn,
-	MPP1_SPI_MOSI,
-	MPP2_SPI_SCK,
-	MPP3_SPI_MISO,
-	MPP4_SATA1_ACTn,
-	MPP5_SATA0_ACTn,
-	MPP8_TW0_SDA,
-	MPP9_TW0_SCK,
-	MPP10_UART0_TXD,
-	MPP11_UART0_RXD,
-	MPP13_UART1_TXD,	/* PIC controller */
-	MPP14_UART1_RXD,	/* PIC controller */
-	MPP15_GPIO,		/* USB Copy button (on devices with 88F6281) */
-	MPP16_GPIO,		/* Reset button (on devices with 88F6281) */
-	MPP36_GPIO,		/* RAM: 0: 256 MB, 1: 512 MB */
-	MPP37_GPIO,		/* Reset button (on devices with 88F6282) */
-	MPP43_GPIO,		/* USB Copy button (on devices with 88F6282) */
-	MPP44_GPIO,		/* Board ID: 0: TS-11x, 1: TS-21x */
-	0
-};
-
 void __init qnap_dt_ts219_init(void)
 {
 	u32 dev, rev;
 
-	kirkwood_mpp_conf(qnap_ts219_mpp_config);
-
 	kirkwood_pcie_id(&dev, &rev);
 	if (dev == MV88F6282_DEV_ID)
 		qnap_ts219_ge00_data.phy_addr = MV643XX_ETH_PHY_ADDR(0);
-- 
1.7.10.4
