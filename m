From: xiakaixu@huawei.com (Kaixu Xia)
Date: Thu, 15 Jan 2015 20:26:59 +0800
Subject: [PATCH] coresight: remove the unnecessary function
 coresight_is_bit_set()
Message-ID: <1421324819-8205-1-git-send-email-xiakaixu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function coresight_is_bit_set() isn't called, so we should
remove it.

Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
---
 include/linux/coresight.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 5d3c543..a860933 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -236,7 +236,6 @@ coresight_register(struct coresight_desc *desc);
 extern void coresight_unregister(struct coresight_device *csdev);
 extern int coresight_enable(struct coresight_device *csdev);
 extern void coresight_disable(struct coresight_device *csdev);
-extern int coresight_is_bit_set(u32 val, int position, int value);
 extern int coresight_timeout(void __iomem *addr, u32 offset,
 			     int position, int value);
 #ifdef CONFIG_OF
@@ -250,8 +249,6 @@ static inline void coresight_unregister(struct coresight_device *csdev) {}
 static inline int
 coresight_enable(struct coresight_device *csdev) { return -ENOSYS; }
 static inline void coresight_disable(struct coresight_device *csdev) {}
-static inline int coresight_is_bit_set(u32 val, int position, int value)
-					 { return 0; }
 static inline int coresight_timeout(void __iomem *addr, u32 offset,
 				     int position, int value) { return 1; }
 #ifdef CONFIG_OF
-- 
1.8.5.5
