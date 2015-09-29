From: al.stone@linaro.org (Al Stone)
Date: Tue, 29 Sep 2015 17:45:46 -0600
Subject: [PATCH v5 5/5] ACPI: remove definition of BAD_MADT_ENTRY macro
In-Reply-To: <1443570346-15378-1-git-send-email-al.stone@linaro.org>
References: <1443570346-15378-1-git-send-email-al.stone@linaro.org>
Message-ID: <1443570346-15378-6-git-send-email-al.stone@linaro.org>
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
index 51a96a8..dd5bd228 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -127,10 +127,6 @@ static inline void acpi_initrd_override(void *data, size_t size)
 }
 #endif
 
-#define BAD_MADT_ENTRY(entry, end) (					    \
-		(!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
-		((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
-
 struct acpi_subtable_proc {
 	int id;
 	acpi_tbl_entry_handler handler;
-- 
2.4.3
