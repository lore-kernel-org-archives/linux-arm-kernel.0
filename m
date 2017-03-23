From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Thu, 23 Mar 2017 12:53:25 +0800
Subject: [PATCH v2 8/8] soc: imx: gpc: remove unnecessary readable_reg callback
In-Reply-To: <1490244805-3921-1-git-send-email-aisheng.dong@nxp.com>
References: <1490244805-3921-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1490244805-3921-9-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not really necessary to provide the current .readable_reg
implementation as we know what we're doing in our driver
and the regmap core has already done the partial check for
available maximum regs.

Cc: Shawn Guo <shawnguo@kernel.org>
Acked-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/soc/imx/gpc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 3c61248..4294287e 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -284,18 +284,10 @@ static const struct of_device_id imx_gpc_dt_ids[] = {
 	{ }
 };
 
-static bool imx_gpc_readable_reg(struct device *dev, unsigned int reg)
-{
-	return (reg % 4 == 0) && (reg <= 0x2ac);
-}
-
 static const struct regmap_config imx_gpc_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-
-	.readable_reg = imx_gpc_readable_reg,
-
 	.max_register = 0x2ac,
 };
 
-- 
2.7.4
