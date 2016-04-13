From: lipengcheng8@huawei.com (lipengcheng)
Date: Wed, 13 Apr 2016 15:40:38 +0800
Subject: [PATCH] coresight: etm4x: modify q_support type
Message-ID: <1460533238-120289-1-git-send-email-lipengcheng8@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because this operation exceed the range of boolean,
so we should modify q_support to unit8 bit.
drvdata->q_support = BMVAL(etmidr0, 15, 16)

Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
Signed-off-by: Li Zhong <lizhong11@hisilicon.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index a291d4c..5359c51 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -372,6 +372,7 @@ struct etmv4_drvdata {
 	u8				ccitmin;
 	u8				s_ex_level;
 	u8				ns_ex_level;
+	u8				q_support;
 	bool				sticky_enable;
 	bool				boot_enable;
 	bool				os_unlock;
@@ -380,7 +381,6 @@ struct etmv4_drvdata {
 	bool				trccond;
 	bool				retstack;
 	bool				trccci;
-	bool				q_support;
 	bool				trc_error;
 	bool				syncpr;
 	bool				stallctl;
-- 
1.8.3.2
