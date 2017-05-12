From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 12 May 2017 20:53:16 +0200
Subject: [PATCH 3/3] coresight: etb10: Improve a size determination in
 etb_alloc_buffer()
In-Reply-To: <5d5cd752-f2f2-b511-6b1e-daf5bf1bc522@users.sourceforge.net>
References: <5d5cd752-f2f2-b511-6b1e-daf5bf1bc522@users.sourceforge.net>
Message-ID: <b8ed57f7-cdcf-9b35-4fdd-8833db008ff0@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 12 May 2017 20:36:03 +0200

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index d5b96423e1a5..7096c4562e15 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -278,8 +278,7 @@ static void *etb_alloc_buffer(struct coresight_device *csdev, int cpu,
 	if (cpu == -1)
 		cpu = smp_processor_id();
 	node = cpu_to_node(cpu);
-
-	buf = kzalloc_node(sizeof(struct cs_buffers), GFP_KERNEL, node);
+	buf = kzalloc_node(sizeof(*buf), GFP_KERNEL, node);
 	if (!buf)
 		return NULL;
 
-- 
2.12.3
