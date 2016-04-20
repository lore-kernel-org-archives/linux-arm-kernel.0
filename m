From: ddaney.cavm@gmail.com (David Daney)
Date: Tue, 19 Apr 2016 18:40:28 -0700
Subject: [PATCH v5 03/14] acpi, numa: remove duplicate NULL check
In-Reply-To: <1461116439-22991-1-git-send-email-ddaney.cavm@gmail.com>
References: <1461116439-22991-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1461116439-22991-4-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

The argument "header" for acpi_table_print_srat_entry()
is always checked before the function is called, it's
duplicate to check it again, remove it.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Robert Richter <rrichter@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
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
1.7.11.7
