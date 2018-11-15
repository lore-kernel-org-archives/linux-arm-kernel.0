From: yuehaibing@huawei.com (YueHaibing)
Date: Thu, 15 Nov 2018 11:36:28 +0000
Subject: [PATCH -next] clk: stm32mp1: drop pointless static qualifier in
 stm32_register_hw_clk()
Message-ID: <1542281788-129746-1-git-send-email-yuehaibing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to have the 'struct clk_hw **hws' variable static
since new value always be assigned before use it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clk/clk-stm32mp1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 4f48342..6a31f7f 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -2015,7 +2015,7 @@ static int stm32_register_hw_clk(struct device *dev,
 				 void __iomem *base, spinlock_t *lock,
 				 const struct clock_config *cfg)
 {
-	static struct clk_hw **hws;
+	struct clk_hw **hws;
 	struct clk_hw *hw = ERR_PTR(-ENOENT);
 
 	hws = clk_data->hws;
