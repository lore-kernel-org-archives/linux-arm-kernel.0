From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Wed, 13 Dec 2017 17:07:22 +0000
Subject: [PATCH 07/10] arm64: increase PHYS_MASK to 52 bits
In-Reply-To: <1513184845-8711-1-git-send-email-kristina.martsenko@arm.com>
References: <1513184845-8711-1-git-send-email-kristina.martsenko@arm.com>
Message-ID: <1513184845-8711-8-git-send-email-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PHYS_MASK_SHIFT represents the highest possible physical address
supported by the kernel, and is used in a number of places. In order to
support 52-bit physical memory, increase PHYS_MASK_SHIFT to 52 when
52-bit physical memory is configured, and retain 48 if it is not, to
e.g. keep IDMAP_PGTABLE_LEVELS accurate. (The kconfig option to set
ARM64_PA_BITS to 52 will be added in a later patch.)

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 60e0432df559..03fe82057bd1 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -206,7 +206,7 @@
 /*
  * Highest possible physical address supported.
  */
-#define PHYS_MASK_SHIFT		(48)
+#define PHYS_MASK_SHIFT		(CONFIG_ARM64_PA_BITS)
 #define PHYS_MASK		((UL(1) << PHYS_MASK_SHIFT) - 1)
 
 /*
-- 
2.1.4
