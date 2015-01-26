From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Mon, 26 Jan 2015 09:22:22 -0700
Subject: [PATCH 6/9] coresight: remove the unnecessary function
 coresight_is_bit_set()
In-Reply-To: <1422289345-2084-1-git-send-email-mathieu.poirier@linaro.org>
References: <1422289345-2084-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1422289345-2084-7-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kaixu Xia <xiakaixu@huawei.com>

This function coresight_is_bit_set() isn't called, so we should
remove it.

Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/coresight.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index cd6d4c384ca3..3486b9082adb 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -227,7 +227,6 @@ coresight_register(struct coresight_desc *desc);
 extern void coresight_unregister(struct coresight_device *csdev);
 extern int coresight_enable(struct coresight_device *csdev);
 extern void coresight_disable(struct coresight_device *csdev);
-extern int coresight_is_bit_set(u32 val, int position, int value);
 extern int coresight_timeout(void __iomem *addr, u32 offset,
 			     int position, int value);
 #else
@@ -237,8 +236,6 @@ static inline void coresight_unregister(struct coresight_device *csdev) {}
 static inline int
 coresight_enable(struct coresight_device *csdev) { return -ENOSYS; }
 static inline void coresight_disable(struct coresight_device *csdev) {}
-static inline int coresight_is_bit_set(u32 val, int position, int value)
-					 { return 0; }
 static inline int coresight_timeout(void __iomem *addr, u32 offset,
 				     int position, int value) { return 1; }
 #endif
-- 
1.9.1
