From: gerg@linux-m68k.org (Greg Ungerer)
Date: Thu, 29 Mar 2018 00:22:23 +1000
Subject: [PATCHv2] ARM: dts: imx6ull: add UART5 input select register
 definitions
Message-ID: <1522246943-2269-1-git-send-email-gerg@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The iMX6ULL UART5_RX_DATA_SELECT_INPUT DAISY Register has some different
bit definitions to that same register in the iMX6UL.

The bits for the iMX6UL:

000 CSI_DATA00_ALT8 ? Selecting Pad: CSI_DATA00 for Mode: ALT8
001 CSI_DATA01_ALT8 ? Selecting Pad: CSI_DATA01 for Mode: ALT8
010 GPIO1_IO04_ALT8 ? Selecting Pad: GPIO1_IO04 for Mode: ALT8
011 GPIO1_IO05_ALT8 ? Selecting Pad: GPIO1_IO05 for Mode: ALT
100 UART5_TX_DATA_ALT0 ? Selecting Pad: UART5_TX_DATA for Mode: ALT
101 UART5_RX_DATA_ALT0 ? Selecting Pad: UART5_RX_DATA for Mode: ALT

But for the iMX6ULL:

000 CSI_DATA00_ALT8 ? Selecting Pad: CSI_DATA00 for Mode: ALT8
001 CSI_DATA01_ALT8 ? Selecting Pad: CSI_DATA01 for Mode: ALT8
010 GPIO1_IO04_ALT8 ? Selecting Pad: GPIO1_IO04 for Mode: ALT8
011 GPIO1_IO05_ALT8 ? Selecting Pad: GPIO1_IO05 for Mode: ALT
100 UART1_TX_DATA_ALT9 ? Selecting Pad: UART1_TX_DATA for Mode: ALT9
101 UART1_RX_DATA_ALT9 ? Selecting Pad: UART1_RX_DATA for Mode: ALT9
110 UART5_TX_DATA_ALT0 ? Selecting Pad: UART5_TX_DATA for Mode: ALT0
111 UART5_RX_DATA_ALT0 ? Selecting Pad: UART5_RX_DATA for Mode: ALT0

Specifically for a board I am working on with the serial console on UART5
I need to be able to enable UART5_RX_DATA_ALT0 mode. There is no definition
for the iMX6ULL version of that in imx6ul-pinfunc.h or imx6ull-pinfunc.h.

Add definitions for the missing UART5 input select register bits of the
iMX6ULL.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/arm/boot/dts/imx6ull-pinfunc.h | 4 ++++
 1 file changed, 4 insertions(+)

v2: add definitions for all missing bits

diff --git a/arch/arm/boot/dts/imx6ull-pinfunc.h b/arch/arm/boot/dts/imx6ull-pinfunc.h
index 1182023..090846b 100644
--- a/arch/arm/boot/dts/imx6ull-pinfunc.h
+++ b/arch/arm/boot/dts/imx6ull-pinfunc.h
@@ -14,6 +14,10 @@
  * The pin function ID is a tuple of
  * <mux_reg conf_reg input_reg mux_mode input_val>
  */
+#define MX6ULL_PAD_UART1_TX_DATA__UART5_DTE_RX                    0x0084 0x0310 0x0644 0x9 0x4
+#define MX6ULL_PAD_UART1_RX_DATA__UART5_DCE_RX                    0x0088 0x0314 0x0644 0x9 0x5
+#define MX6ULL_PAD_UART5_TX_DATA__UART5_DTE_RX                    0x00BC 0x0348 0x0644 0x0 0x6
+#define MX6ULL_PAD_UART5_RX_DATA__UART5_DCE_RX                    0x00C0 0x034C 0x0644 0x0 0x7
 #define MX6ULL_PAD_ENET2_RX_DATA0__EPDC_SDDO08                    0x00E4 0x0370 0x0000 0x9 0x0
 #define MX6ULL_PAD_ENET2_RX_DATA1__EPDC_SDDO09                    0x00E8 0x0374 0x0000 0x9 0x0
 #define MX6ULL_PAD_ENET2_RX_EN__EPDC_SDDO10                       0x00EC 0x0378 0x0000 0x9 0x0
-- 
1.9.1
