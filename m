From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  3 May 2016 11:33:36 -0600
Subject: [PATCH 02/27] coresight: etm4x: modify q_support type
In-Reply-To: <1462296841-12327-1-git-send-email-mathieu.poirier@linaro.org>
References: <1462296841-12327-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1462296841-12327-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: lipengcheng <lipengcheng8@huawei.com>

Because this operation exceed the range of boolean,
so we should modify q_support to unit8 bit.
drvdata->q_support = BMVAL(etmidr0, 15, 16)

Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
Signed-off-by: Li Zhong <lizhong11@hisilicon.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index a291d4cc8bd8..5359c5197c1d 100644
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
2.5.0
