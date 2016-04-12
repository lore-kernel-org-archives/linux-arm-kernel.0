From: lipengcheng8@huawei.com (lipengcheng)
Date: Tue, 12 Apr 2016 16:58:37 +0800
Subject: [PATCH] coresight: etm4x: modify q_support type
Message-ID: <1460451517-171713-1-git-send-email-lipengcheng8@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because this operation exceed the range of boolean, so we should
modify q_support to unit32 bit.
drvdata->q_support = BMVAL(etmidr0, 15, 16)

Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
Signed-off-by: Li Zhong <lizhong11@hisilicon.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index c341002..305b29a 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -330,7 +330,7 @@ struct etmv4_drvdata {
 	u32				ccctlr;
 	bool				trcbb;
 	u32				bb_ctrl;
-	bool				q_support;
+	u32				q_support;
 	u32				vinst_ctrl;
 	u32				viiectlr;
 	u32				vissctlr;
-- 
1.8.3.2
