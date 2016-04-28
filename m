From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 28 Apr 2016 10:28:04 +0100
Subject: [PATCH 04/12] ARM: provide arm_has_idmap_alias() helper
In-Reply-To: <20160428092644.GX19428@n2100.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
Message-ID: <E1aviEu-0000ix-C1@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a helper to indicate whether we need to perform special handling
for boot identity mapping aliases or not.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/memory.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index ca208335fde6..31c07a2cc100 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -295,6 +295,11 @@ extern long long arch_phys_to_idmap_offset;
  * of physical memory for idmap purposes.  Most cases should leave these
  * untouched.  Note: this can only return addresses less than 4GiB.
  */
+static inline bool arm_has_idmap_alias(void)
+{
+	return IS_ENABLED(CONFIG_MMU) && arch_phys_to_idmap_offset != 0;
+}
+
 #define IDMAP_INVALID_ADDR ((u32)~0)
 
 static inline unsigned long phys_to_idmap(phys_addr_t addr)
-- 
2.1.0
