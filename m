From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 20 Feb 2014 13:40:08 +0100
Subject: [PATCH v4 1/7 fixup] drivers: of: add initialization code for reserved
 memory (fixup)
In-Reply-To: <1392893567-31623-2-git-send-email-m.szyprowski@samsung.com>
References: <1392893567-31623-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1392900008-8331-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename 'align' property to 'alignment' to match documentation.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/of/of_reserved_mem.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index cacf04810b87..49cf430a9e2a 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -112,10 +112,10 @@ __reserved_mem_alloc_size(unsigned long node, const char *uname,
 
 	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
 
-	prop = of_get_flat_dt_prop(node, "align", &len);
+	prop = of_get_flat_dt_prop(node, "alignment", &len);
 	if (prop) {
 		if (len != dt_root_addr_cells * sizeof(__be32)) {
-			pr_err("Reserved memory: invalid align property in '%s' node.\n",
+			pr_err("Reserved memory: invalid alignment property in '%s' node.\n",
 				uname);
 			return -EINVAL;
 		}
-- 
1.7.9.5
