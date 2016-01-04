From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  4 Jan 2016 02:22:08 +0100
Subject: [PATCH 2/2] mmc: mmci: support 8bit mode on the Nomadik
Message-ID: <1451870528-21095-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Nomadik variant supports 8bit mode for (e)MMC cards.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index acece3299756..0d6ca4116f3d 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -151,6 +151,7 @@ static struct variant_data variant_nomadik = {
 	.fifosize		= 16 * 4,
 	.fifohalfsize		= 8 * 4,
 	.clkreg			= MCI_CLK_ENABLE,
+	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
 	.datalength_bits	= 24,
 	.datactrl_mask_sdio	= MCI_ST_DPSM_SDIOEN,
 	.st_sdio		= true,
-- 
2.4.3
