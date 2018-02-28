From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 28 Feb 2018 16:06:18 -0600
Subject: [PATCH v7 12/13] ACPI: Add PPTT to injectable table list
In-Reply-To: <20180228220619.6992-1-jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
Message-ID: <20180228220619.6992-13-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ACPI_SIG_PPTT to the table so initrd's can override the
system topology.

Signed-off-by: Geoffrey Blake <geoffrey.blake@arm.com>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/acpi/tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 7bcb66ccccf3..b2efaa503c34 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -457,7 +457,7 @@ static const char * const table_sigs[] = {
 	ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT, ACPI_SIG_WDDT,
 	ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT, ACPI_SIG_PSDT,
 	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, ACPI_SIG_IORT,
-	NULL };
+	ACPI_SIG_PPTT, NULL };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
-- 
2.13.6
