From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Thu, 12 Jan 2017 14:53:41 +0000
Subject: [PATCH -next] soc: ti: wkup_m3_ipc: Fix error return code in
 wkup_m3_ipc_probe()
Message-ID: <20170112145341.783-1-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix to return a negative error code from the kthread_run() error
handling case instead of 0, as done elsewhere in this function.

Fixes: cdd5de500b2c ("soc: ti: Add wkup_m3_ipc driver")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/soc/ti/wkup_m3_ipc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 8bfa44b..369aef5 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -457,6 +457,7 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 
 	if (IS_ERR(task)) {
 		dev_err(dev, "can't create rproc_boot thread\n");
+		ret = PTR_ERR(task);
 		goto err_put_rproc;
 	}
