From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 19 Apr 2018 13:19:39 +0200
Subject: [PATCH] ARM: dts: imx6ull: add UART5 RTS input select register
Message-ID: <1524136779-13246-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The iMX6ULL UART5_RTS_B_DATA_SELECT_INPUT DAISY Register has some different
bit definitions to that same register in the i.MX6UL.

The bits for the i.MX6UL:

000 CSI_DATA03_ALT8 ? Selecting Pad: CSI_DATA03 for Mode: ALT8
001 GPIO1_IO08_ALT8 ? Selecting Pad: GPIO1_IO08 for Mode: ALT8
010 GPIO1_IO09_ALT8 ? Selecting Pad: GPIO1_IO09 for Mode: ALT8
011 ENET1_RX_EN_ALT1 ? Selecting Pad: ENET1_RX_EN for Mode: ALT1
100 ENET1_TX_DATA0_ALT1 ? Selecting Pad: ENET1_TX_DATA0 for Mode: ALT1
101 CSI_DATA02_ALT8 ? Selecting Pad: CSI_DATA02 for Mode: ALT8

But for the i.MX6ULL:

000 CSI_DATA03_ALT8 ? Selecting Pad: CSI_DATA03 for Mode: ALT8
001 GPIO1_IO08_ALT8 ? Selecting Pad: GPIO1_IO08 for Mode: ALT8
010 GPIO1_IO09_ALT8 ? Selecting Pad: GPIO1_IO09 for Mode: ALT8
011 UART1_CTS_B_ALT9 ? Selecting Pad: UART1_CTS_B for Mode: ALT9
100 UART1_RTS_B_ALT9 ? Selecting Pad: UART1_RTS_B for Mode: ALT9
101 ENET1_RX_EN_ALT1 ? Selecting Pad: ENET1_RX_EN for Mode: ALT1
110 ENET1_TX_DATA0_ALT1 ? Selecting Pad: ENET1_TX_DATA0 for Mode: ALT1
111 CSI_DATA02_ALT8 ? Selecting Pad: CSI_DATA02 for Mode: ALT8

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx6ull-pinfunc.h | 5 +++++
 1 file changed, 5 insertions(+)

Hi Shawn,
in the lack of a suitable board, this is only compile tested.

Stefan

diff --git a/arch/arm/boot/dts/imx6ull-pinfunc.h b/arch/arm/boot/dts/imx6ull-pinfunc.h
index 090846b..fdc46bb 100644
--- a/arch/arm/boot/dts/imx6ull-pinfunc.h
+++ b/arch/arm/boot/dts/imx6ull-pinfunc.h
@@ -16,8 +16,12 @@
  */
 #define MX6ULL_PAD_UART1_TX_DATA__UART5_DTE_RX                    0x0084 0x0310 0x0644 0x9 0x4
 #define MX6ULL_PAD_UART1_RX_DATA__UART5_DCE_RX                    0x0088 0x0314 0x0644 0x9 0x5
+#define MX6ULL_PAD_UART1_CTS_B__UART5_DCE_RTS                     0x008C 0x0318 0x0640 0x9 0x3
+#define MX6ULL_PAD_UART1_RTS_B__UART5_DTE_RTS                     0x0090 0x031C 0x0640 0x9 0x4
 #define MX6ULL_PAD_UART5_TX_DATA__UART5_DTE_RX                    0x00BC 0x0348 0x0644 0x0 0x6
 #define MX6ULL_PAD_UART5_RX_DATA__UART5_DCE_RX                    0x00C0 0x034C 0x0644 0x0 0x7
+#define MX6ULL_PAD_ENET1_RX_EN__UART5_DCE_RTS                     0x00CC 0x0358 0x0640 0x1 0x5
+#define MX6ULL_PAD_ENET1_TX_DATA0__UART5_DTE_RTS                  0x00D0 0x035C 0x0640 0x1 0x6
 #define MX6ULL_PAD_ENET2_RX_DATA0__EPDC_SDDO08                    0x00E4 0x0370 0x0000 0x9 0x0
 #define MX6ULL_PAD_ENET2_RX_DATA1__EPDC_SDDO09                    0x00E8 0x0374 0x0000 0x9 0x0
 #define MX6ULL_PAD_ENET2_RX_EN__EPDC_SDDO10                       0x00EC 0x0378 0x0000 0x9 0x0
@@ -51,6 +55,7 @@
 #define MX6ULL_PAD_CSI_DATA00__ESAI_TX_HF_CLK                     0x01E4 0x0470 0x0000 0x9 0x0
 #define MX6ULL_PAD_CSI_DATA01__ESAI_RX_HF_CLK                     0x01E8 0x0474 0x0000 0x9 0x0
 #define MX6ULL_PAD_CSI_DATA02__ESAI_RX_FS                         0x01EC 0x0478 0x0000 0x9 0x0
+#define MX6ULL_PAD_CSI_DATA02__UART5_DCE_RTS                      0x01EC 0x0478 0x0640 0x8 0x7
 #define MX6ULL_PAD_CSI_DATA03__ESAI_RX_CLK                        0x01F0 0x047C 0x0000 0x9 0x0
 #define MX6ULL_PAD_CSI_DATA04__ESAI_TX_FS                         0x01F4 0x0480 0x0000 0x9 0x0
 #define MX6ULL_PAD_CSI_DATA05__ESAI_TX_CLK                        0x01F8 0x0484 0x0000 0x9 0x0
-- 
2.7.4
