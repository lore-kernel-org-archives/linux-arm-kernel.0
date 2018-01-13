From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 12 Jan 2018 18:59:20 -0600
Subject: [PATCH v6 12/12] ACPI: Add PPTT to injectable table list
In-Reply-To: <20180113005920.28658-1-jeremy.linton@arm.com>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
Message-ID: <20180113005920.28658-13-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ACPI_SIG_PPTT to the table so initrd's can override the
system topology.

Signed-off-by: Geoffrey Blake <geoffrey.blake@arm.com>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/acpi/tables.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 80ce2a7d224b..6d254450115b 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -456,7 +456,8 @@ static const char * const table_sigs[] = {
 	ACPI_SIG_SLIC, ACPI_SIG_SPCR, ACPI_SIG_SPMI, ACPI_SIG_TCPA,
 	ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT, ACPI_SIG_WDDT,
 	ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT, ACPI_SIG_PSDT,
-	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, NULL };
+	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, ACPI_SIG_PPTT,
+	NULL };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
-- 
2.13.5
