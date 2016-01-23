From: guohanjun@huawei.com (Hanjun Guo)
Date: Sat, 23 Jan 2016 17:39:18 +0800
Subject: [PATCH v3 03/12] acpi, numa: remove duplicate NULL check
In-Reply-To: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1453541967-3744-4-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

The argument "header" for acpi_table_print_srat_entry()
is always checked before the function is called, it's
duplicate to check it again, remove it.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/numa.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index e34b5d0..2de6068 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -125,9 +125,6 @@ EXPORT_SYMBOL(acpi_map_pxm_to_online_node);
 static void __init
 acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 {
-	if (!header)
-		return;
-
 	switch (header->type) {
 	case ACPI_SRAT_TYPE_CPU_AFFINITY:
 		{
-- 
1.9.1
