From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 1 Jun 2017 18:00:53 +0200
Subject: [PATCH 2/3] ARM: dmabounce: Delete an error message for a failed
 memory allocation in two functions
In-Reply-To: <697e7810-d280-08f3-2a24-026ff41e15a3@users.sourceforge.net>
References: <697e7810-d280-08f3-2a24-026ff41e15a3@users.sourceforge.net>
Message-ID: <f03717c9-9cc8-d339-0e04-b6888a4ce90b@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Jun 2017 17:10:39 +0200

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/common/dmabounce.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index fcdecb2de242..9ef7ab64b3d8 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -127,7 +127,5 @@ alloc_safe_buffer(struct dmabounce_device_info *device_info, void *ptr,
-	if (buf == NULL) {
-		dev_warn(dev, "%s: kmalloc failed\n", __func__);
+	if (!buf)
 		return NULL;
-	}
 
 	buf->ptr = ptr;
 	buf->size = size;
@@ -491,8 +489,5 @@ int dmabounce_register_dev(struct device *dev, unsigned long small_buffer_size,
-	if (!device_info) {
-		dev_err(dev,
-			"Could not allocated dmabounce_device_info\n");
+	if (!device_info)
 		return -ENOMEM;
-	}
 
 	ret = dmabounce_init_pool(&device_info->small, dev,
 				  "small_dmabounce_pool", small_buffer_size);
-- 
2.13.0
