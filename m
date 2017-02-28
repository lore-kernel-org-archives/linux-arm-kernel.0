From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 28 Feb 2017 14:30:33 -0600
Subject: [PATCH] [v2][for 4.11]tty: acpi/spcr: QDF2400 E44 checks for wrong
 OEM revision
Message-ID: <1488313833-12430-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For Qualcomm Technologies QDF2400 SOCs that are affected by erratum E44,
the ACPI oem_revision field is actually set to 1, not 0.

Fixes: d8a4995bcea1 ("tty: pl011: Work around QDF2400 E44 stuck BUSY bit")

Tested-by: Manoj Iyer <manoj.iyer@canonical.com>
Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/acpi/spcr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 2b5d0fa..2051a8c 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -30,7 +30,7 @@ static bool qdf2400_erratum_44_present(struct acpi_table_header *h)
 		return true;
 
 	if (!memcmp(h->oem_table_id, "QDF2400 ", ACPI_OEM_TABLE_ID_SIZE) &&
-			h->oem_revision == 0)
+			h->oem_revision == 1)
 		return true;
 
 	return false;
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
