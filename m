From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 18 Nov 2010 13:50:26 +0000
Subject: [PATCH] ARM: Make the argument to virt_to_phys() "const volatile"
Message-ID: <20101118135026.10541.8683.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changing the virt_to_phys() argument to "const volatile void *" avoids
compiler warnings in some situations where this function is used.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/memory.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 23c2e8e..d0ee74b 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -188,7 +188,7 @@
  * translation for translating DMA addresses.  Use the driver
  * DMA support - see dma-mapping.h.
  */
-static inline unsigned long virt_to_phys(void *x)
+static inline unsigned long virt_to_phys(const volatile void *x)
 {
 	return __virt_to_phys((unsigned long)(x));
 }
