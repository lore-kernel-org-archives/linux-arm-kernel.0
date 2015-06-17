From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 17 Jun 2015 15:28:04 +0100
Subject: [PATCH v2 3/7] xen/grant-table: Remove unused macro SPP
In-Reply-To: <1434551288-14113-1-git-send-email-julien.grall@citrix.com>
References: <1434551288-14113-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1434551288-14113-4-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPP was used by the grant table v2 code which has been removed in
commit 438b33c7145ca8a5131a30c36d8f59bce119a19a "xen/grant-table:
remove support for V2 tables".

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Reviewed-by: David Vrabel <david.vrabel@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>

---
    Changes in v2:
        - Add David's Reviewed-by
---
 drivers/xen/grant-table.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index b1c7170..62f591f 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -138,7 +138,6 @@ static struct gnttab_free_callback *gnttab_free_callback_list;
 static int gnttab_expand(unsigned int req_entries);
 
 #define RPP (PAGE_SIZE / sizeof(grant_ref_t))
-#define SPP (PAGE_SIZE / sizeof(grant_status_t))
 
 static inline grant_ref_t *__gnttab_entry(grant_ref_t entry)
 {
-- 
2.1.4
