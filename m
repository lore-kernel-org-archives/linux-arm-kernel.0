From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 24 May 2013 10:53:33 +0200
Subject: [PATCH 2/2] ARM: sunxi: irqchip: Update the configuration
In-Reply-To: <1369385613-8166-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1369385613-8166-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1369385613-8166-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A10 and A13 have a different set of available interrupt sources, reflect
this in the documentation.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../interrupt-controller/allwinner,sun4i-ic.txt    | 87 +--------------------
 .../interrupt-controller/sunxi/sun4i-a10.txt       | 89 ++++++++++++++++++++++
 .../interrupt-controller/sunxi/sun5i-a13.txt       | 55 +++++++++++++
 3 files changed, 146 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunxi/sun4i-a10.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunxi/sun5i-a13.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
index e7f4dc1..57edb30 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
@@ -8,91 +8,8 @@ Required properties:
 - #interrupt-cells : Specifies the number of cells needed to encode an
   interrupt source. The value shall be 1.
 
-The interrupt sources are as follows:
-
-0: ENMI
-1: UART0
-2: UART1
-3: UART2
-4: UART3
-5: IR0
-6: IR1
-7: I2C0
-8: I2C1
-9: I2C2
-10: SPI0
-11: SPI1
-12: SPI2
-13: SPDIF
-14: AC97
-15: TS
-16: I2S
-17: UART4
-18: UART5
-19: UART6
-20: UART7
-21: KEYPAD
-22: TIMER0
-23: TIMER1
-24: TIMER2
-25: TIMER3
-26: CAN
-27: DMA
-28: PIO
-29: TOUCH_PANEL
-30: AUDIO_CODEC
-31: LRADC
-32: SDMC0
-33: SDMC1
-34: SDMC2
-35: SDMC3
-36: MEMSTICK
-37: NAND
-38: USB0
-39: USB1
-40: USB2
-41: SCR
-42: CSI0
-43: CSI1
-44: LCDCTRL0
-45: LCDCTRL1
-46: MP
-47: DEFEBE0
-48: DEFEBE1
-49: PMU
-50: SPI3
-51: TZASC
-52: PATA
-53: VE
-54: SS
-55: EMAC
-56: SATA
-57: GPS
-58: HDMI
-59: TVE
-60: ACE
-61: TVD
-62: PS2_0
-63: PS2_1
-64: USB3
-65: USB4
-66: PLE_PFM
-67: TIMER4
-68: TIMER5
-69: GPU_GP
-70: GPU_GPMMU
-71: GPU_PP0
-72: GPU_PPMMU0
-73: GPU_PMU
-74: GPU_RSV0
-75: GPU_RSV1
-76: GPU_RSV2
-77: GPU_RSV3
-78: GPU_RSV4
-79: GPU_RSV5
-80: GPU_RSV6
-82: SYNC_TIMER0
-83: SYNC_TIMER1
+For the valid interrupt sources for your SoC, see the documentation in
+sunxi/<soc>.txt
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/interrupt-controller/sunxi/sun4i-a10.txt b/Documentation/devicetree/bindings/interrupt-controller/sunxi/sun4i-a10.txt
new file mode 100644
index 0000000..76b98c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/sunxi/sun4i-a10.txt
@@ -0,0 +1,89 @@
+Allwinner A10 (sun4i) interrupt sources
+---------------------------------------
+
+The interrupt sources available for the Allwinner A10 SoC are the
+following one:
+
+0: ENMI
+1: UART0
+2: UART1
+3: UART2
+4: UART3
+5: IR0
+6: IR1
+7: I2C0
+8: I2C1
+9: I2C2
+10: SPI0
+11: SPI1
+12: SPI2
+13: SPDIF
+14: AC97
+15: TS
+16: I2S
+17: UART4
+18: UART5
+19: UART6
+20: UART7
+21: KEYPAD
+22: TIMER0
+23: TIMER1
+24: TIMER2
+25: TIMER3
+26: CAN
+27: DMA
+28: PIO
+29: TOUCH_PANEL
+30: AUDIO_CODEC
+31: LRADC
+32: MMC0
+33: MMC1
+34: MMC2
+35: MMC3
+36: MEMSTICK
+37: NAND
+38: USB0
+39: USB1
+40: USB2
+41: SCR
+42: CSI0
+43: CSI1
+44: LCDCTRL0
+45: LCDCTRL1
+46: MP
+47: DEFEBE0
+48: DEFEBE1
+49: PMU
+50: SPI3
+51: TZASC
+52: PATA
+53: VE
+54: SS
+55: EMAC
+56: SATA
+57: GPS
+58: HDMI
+59: TVE
+60: ACE
+61: TVD
+62: PS2_0
+63: PS2_1
+64: USB3
+65: USB4
+66: PLE_PFM
+67: TIMER4
+68: TIMER5
+69: GPU_GP
+70: GPU_GPMMU
+71: GPU_PP0
+72: GPU_PPMMU0
+73: GPU_PMU
+74: GPU_RSV0
+75: GPU_RSV1
+76: GPU_RSV2
+77: GPU_RSV3
+78: GPU_RSV4
+79: GPU_RSV5
+80: GPU_RSV6
+82: SYNC_TIMER0
+83: SYNC_TIMER1
diff --git a/Documentation/devicetree/bindings/interrupt-controller/sunxi/sun5i-a13.txt b/Documentation/devicetree/bindings/interrupt-controller/sunxi/sun5i-a13.txt
new file mode 100644
index 0000000..2ec3b5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/sunxi/sun5i-a13.txt
@@ -0,0 +1,55 @@
+Allwinner A13 (sun5i) interrupt sources
+---------------------------------------
+
+The interrupt sources available for the Allwinner A13 SoC are the
+following one:
+
+0: ENMI
+2: UART1
+4: UART3
+5: IR
+7: I2C0
+8: I2C1
+9: I2C2
+10: SPI0
+11: SPI1
+12: SPI2
+22: TIMER0
+23: TIMER1
+24: TIMER2
+25: TIMER3
+27: DMA
+28: PIO
+29: TOUCH_PANEL
+30: AUDIO_CODEC
+31: LRADC
+32: MMC0
+33: MMC1
+34: MMC2
+37: NAND
+38: USB OTG
+39: USB EHCI
+40: USB OHCI
+42: CSI
+44: LCDCTRL
+47: DEFEBE
+49: PMU
+53: VE
+54: SS
+66: PLE_PFM
+67: TIMER4
+68: TIMER5
+69: GPU_GP
+70: GPU_GPMMU
+71: GPU_PP0
+72: GPU_PPMMU0
+73: GPU_PMU
+74: GPU_RSV0
+75: GPU_RSV1
+76: GPU_RSV2
+77: GPU_RSV3
+78: GPU_RSV4
+79: GPU_RSV5
+80: GPU_RSV6
+82: SYNC_TIMER0
+83: SYNC_TIMER1
-- 
1.8.1.2
