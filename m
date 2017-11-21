From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Tue, 21 Nov 2017 11:58:03 +0000
Subject: [RFC 7/9] arm64: increase PHYS_MASK to 52 bits
In-Reply-To: <1511265485-27163-1-git-send-email-kristina.martsenko@arm.com>
References: <1511265485-27163-1-git-send-email-kristina.martsenko@arm.com>
Message-ID: <1511265485-27163-8-git-send-email-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PHYS_MASK_SHIFT represents the highest possible physical address
supported by the kernel, and is used in a number of places. In order to
support 52-bit physical memory, increase PHYS_MASK_SHIFT to 52 when
52-bit physical memory is configured, and retain 48 if it is not, to
e.g. keep IDMAP_PGTABLE_LEVELS accurate.

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 69cc40695164..ab3eddb2e21b 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -199,7 +199,7 @@
 /*
  * Highest possible physical address supported.
  */
-#define PHYS_MASK_SHIFT		(48)
+#define PHYS_MASK_SHIFT		(CONFIG_ARM64_PA_BITS)
 #define PHYS_MASK		((UL(1) << PHYS_MASK_SHIFT) - 1)
 
 /*
-- 
2.1.4
