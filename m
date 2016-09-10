From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Sat, 10 Sep 2016 12:31:30 +0000
Subject: [PATCH -next] net: ethernet: dwmac: fix non static symbol warning
Message-ID: <1473510690-25198-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warning:

drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c:172:1: warning:
 symbol 'stm32_dwmac_pm_ops' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 79d8b92..e5a926b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -169,7 +169,8 @@ static int stm32_dwmac_resume(struct device *dev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
-SIMPLE_DEV_PM_OPS(stm32_dwmac_pm_ops, stm32_dwmac_suspend, stm32_dwmac_resume);
+static SIMPLE_DEV_PM_OPS(stm32_dwmac_pm_ops,
+	stm32_dwmac_suspend, stm32_dwmac_resume);
 
 static const struct of_device_id stm32_dwmac_match[] = {
 	{ .compatible = "st,stm32-dwmac"},
