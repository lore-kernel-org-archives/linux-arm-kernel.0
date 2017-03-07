From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 7 Mar 2017 20:39:56 +0800
Subject: [PATCH v9 01/15] ACPI/IORT: Fix the indentation in iort_scan_node()
In-Reply-To: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
References: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1488890410-15503-2-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

The indentation in the iort_scan_node() function is wrong, fix it.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
[lorenzo.pieralisi at arm.com: massaged commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Ming Lei <ming.lei@canonical.com>
Tested-by: Wei Xu <xuwei5@hisilicon.com>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 4a5bb96..2e368a6 100644
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
1.7.12.4
