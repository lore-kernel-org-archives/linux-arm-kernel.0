From: robert.smigielski@timesys.com (Robert Smigielski)
Date: Tue, 10 Mar 2015 09:45:42 -0400
Subject: [PATCH] ARM: dts: imx: imx6q uart2 pin mux correction
Message-ID: <CAPvN=VTSMxtjs6QQ=VFPCDgJ3LJ2xfC+Ryh-rXU4-xnqk+i67w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch contains a correction to the file imx6q-pinfunc.h for the
definition of the UART2 GPIO pin mux setting.

Issue found when testing UART2 configured as the console in Linux
GPIO_7 is a transmit pin not a transmit and receive pin
GPIO_8 is a receive pin not a transmit and receive pin

Verified the correction with Freescale in posting to the Freescale
forum https://community.freescale.com/thread/343349

commit c383bbb4d17037435305858f488db7ae17dc1c85
Author: robert.smigielski <robert.smigielski@timesys.com>
Date:   Fri Mar 6 11:53:20 2015 -0500

    UART2 Tx and Rx values corrected based on IMX6Q datasheet

diff --git a/arch/arm/boot/dts/imx6q-pinfunc.h
b/arch/arm/boot/dts/imx6q-pinfunc.h
index c68c21d..4d4cc49 100644
--- a/arch/arm/boot/dts/imx6q-pinfunc.h
+++ b/arch/arm/boot/dts/imx6q-pinfunc.h
@@ -696,8 +696,7 @@
 #define MX6QDL_PAD_GPIO_7__ECSPI5_RDY               0x240 0x610 0x000 0x1 0x0
 #define MX6QDL_PAD_GPIO_7__EPIT1_OUT                0x240 0x610 0x000 0x2 0x0
 #define MX6QDL_PAD_GPIO_7__FLEXCAN1_TX              0x240 0x610 0x000 0x3 0x0
-#define MX6QDL_PAD_GPIO_7__UART2_TX_DATA            0x240 0x610 0x000 0x4 0x0
-#define MX6QDL_PAD_GPIO_7__UART2_RX_DATA            0x240 0x610 0x928 0x4 0x2
+#define MX6QDL_PAD_GPIO_7__UART2_TX_DATA            0x240 0x610 0x928 0x4 0x2
 #define MX6QDL_PAD_GPIO_7__GPIO1_IO07               0x240 0x610 0x000 0x5 0x0
 #define MX6QDL_PAD_GPIO_7__SPDIF_LOCK               0x240 0x610 0x000 0x6 0x0
 #define MX6QDL_PAD_GPIO_7__USB_OTG_HOST_MODE        0x240 0x610 0x000 0x7 0x0
@@ -706,7 +705,6 @@
 #define MX6QDL_PAD_GPIO_8__EPIT2_OUT                0x244 0x614 0x000 0x2 0x0
 #define MX6QDL_PAD_GPIO_8__FLEXCAN1_RX              0x244 0x614 0x7e4 0x3 0x1
 #define MX6QDL_PAD_GPIO_8__UART2_RX_DATA            0x244 0x614 0x928 0x4 0x3
-#define MX6QDL_PAD_GPIO_8__UART2_TX_DATA            0x244 0x614 0x000 0x4 0x0
 #define MX6QDL_PAD_GPIO_8__GPIO1_IO08               0x244 0x614 0x000 0x5 0x0
 #define MX6QDL_PAD_GPIO_8__SPDIF_SR_CLK             0x244 0x614 0x000 0x6 0x0
 #define MX6QDL_PAD_GPIO_8__USB_OTG_PWR_CTL_WAKE     0x244 0x614 0x000 0x7 0x0

Robert Smigielski
