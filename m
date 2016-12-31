From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 31 Dec 2016 23:03:16 +0100
Subject: [PATCH 4/6] staging: vchiq_arm: Delete an error message for a failed
 memory allocation in dump_phys_mem()
In-Reply-To: <5acd65e7-0b5d-0972-5e1a-6e87d71dc1a4@users.sourceforge.net>
References: <5acd65e7-0b5d-0972-5e1a-6e87d71dc1a4@users.sourceforge.net>
Message-ID: <20128727-5313-ad6d-7938-ca9c303331a7@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 31 Dec 2016 21:30:31 +0100

Omit an extra message for a memory allocation failure in this function.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index a316cf9ac626..3b7a0c87954d 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1559,12 +1559,8 @@ dump_phys_mem(void *virt_addr, uint32_t num_bytes)
 
 	num_pages = (offset + num_bytes + PAGE_SIZE - 1) / PAGE_SIZE;
 	pages = kmalloc_array(num_pages, sizeof(*pages), GFP_KERNEL);
-	if (!pages) {
-		vchiq_log_error(vchiq_arm_log_level,
-			"Unable to allocation memory for %d pages\n",
-			num_pages);
+	if (!pages)
 		return;
-	}
 
 	down_read(&current->mm->mmap_sem);
 	rc = get_user_pages(
-- 
2.11.0
