From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 1 Jun 2017 17:59:55 +0200
Subject: [PATCH 1/3] ARM: dmabounce: Improve a size determination in two
 functions
In-Reply-To: <697e7810-d280-08f3-2a24-026ff41e15a3@users.sourceforge.net>
References: <697e7810-d280-08f3-2a24-026ff41e15a3@users.sourceforge.net>
Message-ID: <d78ce917-3920-7858-b866-48a61b1c8fc3@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Jun 2017 17:00:17 +0200

Replace the specification of two data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/common/dmabounce.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 9b1b7be2ec0e..fcdecb2de242 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -123,5 +123,5 @@ alloc_safe_buffer(struct dmabounce_device_info *device_info, void *ptr,
 		pool = NULL;
 	}
 
-	buf = kmalloc(sizeof(struct safe_buffer), GFP_ATOMIC);
+	buf = kmalloc(sizeof(*buf), GFP_ATOMIC);
 	if (buf == NULL) {
@@ -487,5 +487,5 @@ int dmabounce_register_dev(struct device *dev, unsigned long small_buffer_size,
 	struct dmabounce_device_info *device_info;
 	int ret;
 
-	device_info = kmalloc(sizeof(struct dmabounce_device_info), GFP_ATOMIC);
+	device_info = kmalloc(sizeof(*device_info), GFP_ATOMIC);
 	if (!device_info) {
-- 
2.13.0
