From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Mon, 26 Jan 2015 09:22:25 -0700
Subject: [PATCH 9/9] coresight: fix function etm_writel_cp14() parameter order
In-Reply-To: <1422289345-2084-1-git-send-email-mathieu.poirier@linaro.org>
References: <1422289345-2084-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1422289345-2084-10-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kaixu Xia <xiakaixu@huawei.com>

Function etm_writel_cp14() takes an offset and a value rather
than the other way around, something this patch is correcting.
The semantic remains the same since it is only a function stub.

Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/coresight/coresight-priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/coresight/coresight-priv.h b/drivers/coresight/coresight-priv.h
index 7b3372fca4f6..62fcd98cc7cf 100644
--- a/drivers/coresight/coresight-priv.h
+++ b/drivers/coresight/coresight-priv.h
@@ -57,7 +57,7 @@ extern int etm_readl_cp14(u32 off, unsigned int *val);
 extern int etm_writel_cp14(u32 off, u32 val);
 #else
 static inline int etm_readl_cp14(u32 off, unsigned int *val) { return 0; }
-static inline int etm_writel_cp14(u32 val, u32 off) { return 0; }
+static inline int etm_writel_cp14(u32 off, u32 val) { return 0; }
 #endif
 
 #endif
-- 
1.9.1
