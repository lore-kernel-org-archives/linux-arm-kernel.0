From: marex@denx.de (Marek Vasut)
Date: Wed,  3 Apr 2013 02:20:25 +0200
Subject: [PATCH] pinctrl: imx5: fix SD2_DATA1 pad AUDMUX_AUD4 configuration
Message-ID: <1364948425-15372-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IOMUXC_AUDMUX_P4_INPUT_TXCLK_AMX_SELECT_INPUT must be configured as 1
instead of 0 to have AUD4 muxed on SD2 pins working.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx53-pinfunc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-pinfunc.h b/arch/arm/boot/dts/imx53-pinfunc.h
index 1362060..aec406b 100644
--- a/arch/arm/boot/dts/imx53-pinfunc.h
+++ b/arch/arm/boot/dts/imx53-pinfunc.h
@@ -1073,7 +1073,7 @@
 #define MX53_PAD_SD2_DATA1__ESDHC2_DAT1				0x30c 0x698 0x000 0x0 0x0
 #define MX53_PAD_SD2_DATA1__GPIO1_14				0x30c 0x698 0x000 0x1 0x0
 #define MX53_PAD_SD2_DATA1__KPP_COL_7				0x30c 0x698 0x848 0x2 0x1
-#define MX53_PAD_SD2_DATA1__AUDMUX_AUD4_TXFS			0x30c 0x698 0x744 0x3 0x0
+#define MX53_PAD_SD2_DATA1__AUDMUX_AUD4_TXFS			0x30c 0x698 0x744 0x3 0x1
 #define MX53_PAD_SD2_DATA1__CSPI_SS0				0x30c 0x698 0x78c 0x5 0x4
 #define MX53_PAD_SD2_DATA1__RTIC_SEC_VIO			0x30c 0x698 0x000 0x7 0x0
 #define MX53_PAD_SD2_DATA0__ESDHC2_DAT0				0x310 0x69c 0x000 0x0 0x0
-- 
1.7.10.4
