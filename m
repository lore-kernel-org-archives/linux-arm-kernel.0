From: hs@denx.de (Heiko Schocher)
Date: Thu, 30 Aug 2018 14:47:02 +0200
Subject: [PATCH] ARM: dts: imx6ull: fix pinmux input_val for uart5 rx pin
Message-ID: <20180830124702.12572-1-hs@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

on the imx6ull the input_val for uart5 rx function
of pin MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX
is 7 and not 5 as on the imx6ul. With this
patch, console on an imx6ull based board works
with uart5.

Signed-off-by: Heiko Schocher <hs@denx.de>

---

 arch/arm/boot/dts/imx6ull-pinfunc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6ull-pinfunc.h b/arch/arm/boot/dts/imx6ull-pinfunc.h
index fdc46bb09cc1a..d835aeae5485b 100644
--- a/arch/arm/boot/dts/imx6ull-pinfunc.h
+++ b/arch/arm/boot/dts/imx6ull-pinfunc.h
@@ -61,5 +61,6 @@
 #define MX6ULL_PAD_CSI_DATA05__ESAI_TX_CLK                        0x01F8 0x0484 0x0000 0x9 0x0
 #define MX6ULL_PAD_CSI_DATA06__ESAI_TX5_RX0                       0x01FC 0x0488 0x0000 0x9 0x0
 #define MX6ULL_PAD_CSI_DATA07__ESAI_T0                            0x0200 0x048C 0x0000 0x9 0x0
+#define MX6ULL_PAD_UART5_RX_DATA__UART5_DCE_RX		0x00C0 0x034C 0x0644 0 7
 
 #endif /* __DTS_IMX6ULL_PINFUNC_H */
-- 
2.14.4
