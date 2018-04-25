From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 25 Apr 2018 18:31:20 -0500
Subject: [PATCH v8 12/13] ACPI: Add PPTT to injectable table list
In-Reply-To: <20180425233121.13270-1-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
Message-ID: <20180425233121.13270-13-jeremy.linton@arm.com>
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
index 849c4fb19b03..30d93bf7c6a2 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -457,7 +457,7 @@ static const char * const table_sigs[] = {
 	ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT, ACPI_SIG_WDDT,
 	ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT, ACPI_SIG_PSDT,
 	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, ACPI_SIG_IORT,
-	ACPI_SIG_NFIT, ACPI_SIG_HMAT, NULL };
+	ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT, NULL };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
-- 
2.13.6
