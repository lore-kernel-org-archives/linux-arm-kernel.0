From: al.stone@linaro.org (Al Stone)
Date: Thu,  6 Aug 2015 14:59:30 -0600
Subject: [PATCH 5/5] ACPI: remove definition of BAD_MADT_ENTRY macro
In-Reply-To: <1438894770-31163-1-git-send-email-al.stone@linaro.org>
References: <1438894770-31163-1-git-send-email-al.stone@linaro.org>
Message-ID: <1438894770-31163-6-git-send-email-al.stone@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have introduced to bad_madt_entry(), and we have removed
all the usages of the BAD_MADT_ENTRY macro from all of the various
architectures that use it (arm64, ia64, x86), we can remove the macro
definition since it is no longer used.

Signed-off-by: Al Stone <al.stone@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
---
 include/linux/acpi.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d2445fa..06072d8 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -131,10 +131,6 @@ static inline void acpi_initrd_override(void *data, size_t size)
 }
 #endif
 
-#define BAD_MADT_ENTRY(entry, end) (					    \
-		(!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
-		((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
-
 char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
 void __acpi_unmap_table(char *map, unsigned long size);
 int early_acpi_boot_init(void);
-- 
2.4.3
