From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Oct 2009 13:22:04 +0100
Subject: [PATCH 3/4] Revert 75f4aa1 (unconditionally define __virt_to_phys and
	__phys_to_virt)
In-Reply-To: <20091015121927.739.32071.stgit@pc1117.cambridge.arm.com>
References: <20091015121927.739.32071.stgit@pc1117.cambridge.arm.com>
Message-ID: <20091015122204.739.25384.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPARSEMEM support for RealView PBX requires non-linear physical to
virtual address translation.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Pitre <nico@cam.org>
---
 arch/arm/include/asm/memory.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index cefedf0..bc2ff8b 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -125,8 +125,10 @@
  * private definitions which should NOT be used outside memory.h
  * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
  */
+#ifndef __virt_to_phys
 #define __virt_to_phys(x)	((x) - PAGE_OFFSET + PHYS_OFFSET)
 #define __phys_to_virt(x)	((x) - PHYS_OFFSET + PAGE_OFFSET)
+#endif
 
 /*
  * Convert a physical address to a Page Frame Number and back
