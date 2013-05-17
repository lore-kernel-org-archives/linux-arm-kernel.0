From: jiada_wang@mentor.com (Jiada Wang)
Date: Fri, 17 May 2013 17:40:44 +0900
Subject: [PATCH 1/2] ARM: imx: disable pll8_mlb in mx6q_clks
In-Reply-To: <1368780045-6481-1-git-send-email-jiada_wang@mentor.com>
References: <1368780045-6481-1-git-send-email-jiada_wang@mentor.com>
Message-ID: <1368780045-6481-2-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MLB PLL clock's operation doesn't fit for clock framework and
it should be handled internally in MLB driver.
Remove initialization of pll8_mlb clock device but leave its
declaration in mx6q_clks to avoid affecting imx6q clock numbering.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
CC: Shawn Guo <shawn.guo@linaro.org>
CC: Dirk Behme <dirk.behme@de.bosch.com>
---
 arch/arm/mach-imx/clk-imx6q.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 1512590..795e718 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -311,7 +311,6 @@ int __init mx6q_clocks_init(void)
 	clk[pll5_video]    = imx_clk_pllv3(IMX_PLLV3_AV,	"pll5_video",	"osc", base + 0xa0, 0x7f);
 	clk[pll6_enet]     = imx_clk_pllv3(IMX_PLLV3_ENET,	"pll6_enet",	"osc", base + 0xe0, 0x3);
 	clk[pll7_usb_host] = imx_clk_pllv3(IMX_PLLV3_USB,	"pll7_usb_host","osc", base + 0x20, 0x3);
-	clk[pll8_mlb]      = imx_clk_pllv3(IMX_PLLV3_MLB,	"pll8_mlb",	"osc", base + 0xd0, 0x0);
 
 	/*
 	 * Bit 20 is the reserved and read-only bit, we do this only for:
-- 
1.8.1.1
