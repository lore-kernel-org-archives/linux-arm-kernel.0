From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 11 Jan 2017 23:06:25 +0800
Subject: [PATCH v7 01/15] ACPI: IORT: fix the indentation in iort_scan_node()
In-Reply-To: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1484147199-4267-2-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The indentation is wrong when return the iort_node, fix it.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ba156c5..ce3084b 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -225,7 +225,7 @@ static struct acpi_iort_node *iort_scan_node(enum acpi_iort_node_type type,
 
 		if (iort_node->type == type &&
 		    ACPI_SUCCESS(callback(iort_node, context)))
-				return iort_node;
+			return iort_node;
 
 		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
 					 iort_node->length);
-- 
1.9.1
