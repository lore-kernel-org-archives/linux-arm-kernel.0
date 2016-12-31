From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 31 Dec 2016 23:01:27 +0100
Subject: [PATCH 3/6] staging: vchiq_arm: One check less in dump_phys_mem()
 after error detection
In-Reply-To: <5acd65e7-0b5d-0972-5e1a-6e87d71dc1a4@users.sourceforge.net>
References: <5acd65e7-0b5d-0972-5e1a-6e87d71dc1a4@users.sourceforge.net>
Message-ID: <7b97ce90-64c9-7327-9e03-1e22bf7d7f53@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 31 Dec 2016 21:26:09 +0100

Adjust a jump target according to the Linux coding style convention
so that a redundant check for a null pointer can be avoided
in this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 2a260034189d..a316cf9ac626 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1581,7 +1581,7 @@ dump_phys_mem(void *virt_addr, uint32_t num_bytes)
 	if (rc < 0) {
 		vchiq_log_error(vchiq_arm_log_level,
 				"Failed to get user pages: %d\n", rc);
-		goto out;
+		goto put_pages;
 	}
 
 	while (offset < end_offset) {
@@ -1607,10 +1607,9 @@ dump_phys_mem(void *virt_addr, uint32_t num_bytes)
 		offset += 16;
 	}
 
-out:
 	if (page)
 		kunmap(page);
-
+put_pages:
 	for (page_idx = 0; page_idx < num_pages; page_idx++)
 		put_page(pages[page_idx]);
 
-- 
2.11.0
