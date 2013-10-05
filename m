From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat,  5 Oct 2013 16:17:55 +0200
Subject: [PATCH 3/4] Documentation: dt: Remove interrupt sources list for
 Allwinner SoCs
In-Reply-To: <1380982676-10055-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1380982676-10055-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1380982676-10055-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That documentation was mostly useful when we didn't have any
documentation for those SoCs, which is not the case anymore. Remove
this, since it should live in the DT anyway.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 .../interrupt-controller/allwinner,sun4i-ic.txt    |  3 -
 .../interrupt-controller/sunxi/sun4i-a10.txt       | 89 ----------------------
 .../interrupt-controller/sunxi/sun5i-a13.txt       | 55 -------------
 3 files changed, 147 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunxi/sun4i-a10.txt
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunxi/sun5i-a13.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
index 57edb30..3d3b2b9 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
@@ -8,9 +8,6 @@ Required properties:
 - #interrupt-cells : Specifies the number of cells needed to encode an
   interrupt source. The value shall be 1.
 
-For the valid interrupt sources for your SoC, see the documentation in
-sunxi/<soc>.txt
-
 Example:
 
 intc: interrupt-controller {
diff --git a/Documentation/devicetree/bindings/interrupt-controller/sunxi/sun4i-a10.txt b/Documentation/devicetree/bindings/interrupt-controller/sunxi/sun4i-a10.txt
deleted file mode 100644
index 76b98c8..0000000
--- a/Documentation/devicetree/bindings/interrupt-controller/sunxi/sun4i-a10.txt
+++ /dev/null
@@ -1,89 +0,0 @@
-Allwinner A10 (sun4i) interrupt sources
----------------------------------------
-
-The interrupt sources available for the Allwinner A10 SoC are the
-following one:
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
-32: MMC0
-33: MMC1
-34: MMC2
-35: MMC3
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
diff --git a/Documentation/devicetree/bindings/interrupt-controller/sunxi/sun5i-a13.txt b/Documentation/devicetree/bindings/interrupt-controller/sunxi/sun5i-a13.txt
deleted file mode 100644
index 2ec3b5c..0000000
--- a/Documentation/devicetree/bindings/interrupt-controller/sunxi/sun5i-a13.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-Allwinner A13 (sun5i) interrupt sources
----------------------------------------
-
-The interrupt sources available for the Allwinner A13 SoC are the
-following one:
-
-0: ENMI
-2: UART1
-4: UART3
-5: IR
-7: I2C0
-8: I2C1
-9: I2C2
-10: SPI0
-11: SPI1
-12: SPI2
-22: TIMER0
-23: TIMER1
-24: TIMER2
-25: TIMER3
-27: DMA
-28: PIO
-29: TOUCH_PANEL
-30: AUDIO_CODEC
-31: LRADC
-32: MMC0
-33: MMC1
-34: MMC2
-37: NAND
-38: USB OTG
-39: USB EHCI
-40: USB OHCI
-42: CSI
-44: LCDCTRL
-47: DEFEBE
-49: PMU
-53: VE
-54: SS
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
-- 
1.8.4
