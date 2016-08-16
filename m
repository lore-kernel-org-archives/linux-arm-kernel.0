From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 16 Aug 2016 16:59:52 +0100
Subject: [PATCH 1/2] drivers: acpi: fix typo in ACPI_DECLARE_PROBE_ENTRY macro
Message-ID: <1471363193-16559-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the ACPI_DECLARE_PROBE_ENTRY macro was added in
commit e647b532275b ("ACPI: Add early device probing infrastructure"),
a stub macro adding an unused entry was added for the !CONFIG_ACPI
Kconfig option case to make sure kernel code making use of the
macro did not require to be guarded within CONFIG_ACPI in order to
be compiled.

The stub macro was never used since all kernel code that defines
ACPI_DECLARE_PROBE_ENTRY entries is currently guarded within
CONFIG_ACPI; it contains a typo that should be nonetheless fixed.

Fix the typo in the stub (ie !CONFIG_ACPI) ACPI_DECLARE_PROBE_ENTRY()
macro so that it can actually be used if needed.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Fixes: e647b532275b ("ACPI: Add early device probing infrastructure")
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>
---
 include/linux/acpi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4d8452c..c5eaf2f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1056,7 +1056,7 @@ static inline struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
 	return NULL;
 }
 
-#define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable, validate, data, fn) \
+#define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable, valid, data, fn) \
 	static const void * __acpi_table_##name[]			\
 		__attribute__((unused))					\
 		 = { (void *) table_id,					\
-- 
2.6.4
