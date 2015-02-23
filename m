From: jdelvare@suse.de (Jean Delvare)
Date: Mon, 23 Feb 2015 10:05:21 +0100
Subject: [PATCH v2] iommu/io-pgtable-arm: Add built time dependency
Message-ID: <20150223100521.45108573@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If io-pgtable-arm is an ARM-specific driver then configuration option
IOMMU_IO_PGTABLE_LPAE should not be presented to the user by default
for non-ARM kernels.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
---
Changes since v1:
 * Added ARM64 as suggested by Will Deacon.

 drivers/iommu/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-4.0-rc1.orig/drivers/iommu/Kconfig	2015-02-20 17:24:46.838955014 +0100
+++ linux-4.0-rc1/drivers/iommu/Kconfig	2015-02-23 10:03:06.487667832 +0100
@@ -23,6 +23,7 @@ config IOMMU_IO_PGTABLE
 config IOMMU_IO_PGTABLE_LPAE
 	bool "ARMv7/v8 Long Descriptor Format"
 	select IOMMU_IO_PGTABLE
+	depends on ARM || ARM64 || COMPILE_TEST
 	help
 	  Enable support for the ARM long descriptor pagetable format.
 	  This allocator supports 4K/2M/1G, 16K/32M and 64K/512M page


-- 
Jean Delvare
SUSE L3 Support
