From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 8 Sep 2017 22:52:30 +0200
Subject: [PATCH 2/3] [media] s5p-mfc: Improve a size determination in
 s5p_mfc_alloc_memdev()
In-Reply-To: <482a6c92-a85e-0bcd-edf7-3c2f63ea74c5@users.sourceforge.net>
References: <482a6c92-a85e-0bcd-edf7-3c2f63ea74c5@users.sourceforge.net>
Message-ID: <003abb1f-4dc6-91ca-9d03-cae13dc4ff6f@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 8 Sep 2017 22:30:09 +0200

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/media/platform/s5p-mfc/s5p_mfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index 8af45d53846f..abfb70b07032 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -1083,7 +1083,7 @@ static struct device *s5p_mfc_alloc_memdev(struct device *dev,
 	struct device *child;
 	int ret;
 
-	child = devm_kzalloc(dev, sizeof(struct device), GFP_KERNEL);
+	child = devm_kzalloc(dev, sizeof(*child), GFP_KERNEL);
 	if (!child)
 		return NULL;
 
-- 
2.14.1
