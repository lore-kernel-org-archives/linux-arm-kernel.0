From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Sat, 29 Oct 2016 16:31:17 +0000
Subject: [PATCH -next] i2c: digicolor: use clk_disable_unprepare instead of
 clk_unprepare
Message-ID: <1477758677-7831-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

since clk_prepare_enable() is used to get i2c->clk, we should
use clk_disable_unprepare() to release it for the error path.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/i2c/busses/i2c-digicolor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-digicolor.c b/drivers/i2c/busses/i2c-digicolor.c
index 49f2084..50813a2 100644
--- a/drivers/i2c/busses/i2c-digicolor.c
+++ b/drivers/i2c/busses/i2c-digicolor.c
@@ -347,7 +347,7 @@ static int dc_i2c_probe(struct platform_device *pdev)
 
 	ret = i2c_add_adapter(&i2c->adap);
 	if (ret < 0) {
-		clk_unprepare(i2c->clk);
+		clk_disable_unprepare(i2c->clk);
 		return ret;
 	}
