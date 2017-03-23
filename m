From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Thu, 23 Mar 2017 12:53:22 +0800
Subject: [PATCH v2 5/8] soc: imx: gpc: fix comment when power up domain
In-Reply-To: <1490244805-3921-1-git-send-email-aisheng.dong@nxp.com>
References: <1490244805-3921-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1490244805-3921-6-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The correct comment should be power up domain.

Cc: Shawn Guo <shawnguo@kernel.org>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/soc/imx/gpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 9a2354e..afb02f9 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -104,7 +104,7 @@ static int imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
 	regmap_update_bits(pd->regmap, pd->reg_offs + GPC_PGC_PDN_OFFS,
 			   0x1, 0x1);
 
-	/* Read ISO and ISO2SW power down delays */
+	/* Read ISO and ISO2SW power up delays */
 	regmap_read(pd->regmap, pd->reg_offs + GPC_PGC_PUPSCR_OFFS, &val);
 	sw = val & 0x3f;
 	sw2iso = (val >> 8) & 0x3f;
-- 
2.7.4
