From: jeremy.linton@arm.com (Jeremy Linton)
Date: Thu,  9 Nov 2017 15:03:03 -0600
Subject: [PATCH v4 1/9] ACPICA: Add additional PPTT flags for cache properties
In-Reply-To: <20171109210311.25655-1-jeremy.linton@arm.com>
References: <20171109210311.25655-1-jeremy.linton@arm.com>
Message-ID: <20171109210311.25655-2-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PPTT table has a number of flags that can be set
to describe whether the cache is I/D/U and the allocation
and write policies. Add these flags.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 include/acpi/actbl1.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 6b8714a428b6..71f874e2790d 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1346,6 +1346,20 @@ struct acpi_pptt_cache {
 #define ACPI_PPTT_MASK_CACHE_TYPE           (0x0C)	/* Cache type */
 #define ACPI_PPTT_MASK_WRITE_POLICY         (0x10)	/* Write policy */
 
+/* Attributes describing cache */
+#define ACPI_PPTT_CACHE_READ_ALLOCATE	    (0x0)   /* Cache line is allocated on read */
+#define ACPI_PPTT_CACHE_WRITE_ALLOCATE	    (0x01)  /* Cache line is allocated on write */
+#define ACPI_PPTT_CACHE_RW_ALLOCATE	    (0x02)  /* Cache line is allocated on read and write */
+#define ACPI_PPTT_CACHE_RW_ALLOCATE_ALT	    (0x03)  /* Alternate representation of above */
+
+#define ACPI_PPTT_CACHE_TYPE_DATA	    (0x0)   /* Data cache */
+#define ACPI_PPTT_CACHE_TYPE_INSTR	    (1<<2)  /* Instruction cache */
+#define ACPI_PPTT_CACHE_TYPE_UNIFIED	    (2<<2)  /* Unified I & D cache */
+#define ACPI_PPTT_CACHE_TYPE_UNIFIED_ALT    (3<<2)  /* Alternate representation of above */
+
+#define ACPI_PPTT_CACHE_POLICY_WB	    (0x0)   /* Cache is write back */
+#define ACPI_PPTT_CACHE_POLICY_WT	    (1<<4)  /* Cache is write through */
+
 /* 2: ID Structure */
 
 struct acpi_pptt_id {
-- 
2.13.5
