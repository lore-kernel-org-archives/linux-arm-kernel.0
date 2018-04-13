From: lkp@intel.com (kbuild test robot)
Date: Fri, 13 Apr 2018 14:03:59 +0800
Subject: [RFC PATCH] net: stmmac: dwmac-sun8i: single_reg_field can be static
In-Reply-To: <20180411141641.14675-4-icenowy@aosc.io>
References: <20180411141641.14675-4-icenowy@aosc.io>
Message-ID: <20180413060359.GA134752@lkp-hsx03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixes: 529123418105 ("net: stmmac: dwmac-sun8i: Allow getting syscon regmap from device")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 dwmac-sun8i.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index b61210c..842315a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -86,7 +86,7 @@ const struct reg_field old_syscon_reg_field = {
 };
 
 /* Specially exported regmap which contains only EMAC register */
-const struct reg_field single_reg_field = {
+static const struct reg_field single_reg_field = {
 	.reg = 0,
 	.lsb = 0,
 	.msb = 31,
