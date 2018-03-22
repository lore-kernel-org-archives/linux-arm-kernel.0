From: lkp@intel.com (kbuild test robot)
Date: Thu, 22 Mar 2018 15:42:18 +0800
Subject: [RFC PATCH] net: stmmac: dwmac-sun8i: sun8i_syscon_reg_field can be
 static
In-Reply-To: <20180317092857.4396-7-wens@csie.org>
References: <20180317092857.4396-7-wens@csie.org>
Message-ID: <20180322074217.GA7358@ivytown2.lkp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixes: e3c10deef23c ("net: stmmac: dwmac-sun8i: Use regmap_field for syscon register access")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 dwmac-sun8i.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index de93f0f..bbc0514 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -79,7 +79,7 @@ struct sunxi_priv_data {
 };
 
 /* EMAC clock register @ 0x30 in the "system control" address range */
-const struct reg_field sun8i_syscon_reg_field = {
+static const struct reg_field sun8i_syscon_reg_field = {
 	.reg = 0x30,
 	.lsb = 0,
 	.msb = 31,
