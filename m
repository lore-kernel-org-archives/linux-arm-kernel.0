From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 5 Jun 2013 18:02:02 +0100
Subject: [PATCH v4 1/6] arm/xen: define xen_remap as ioremap_cached
In-Reply-To: <alpine.DEB.2.02.1306051605030.4589@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1306051605030.4589@kaball.uk.xensource.com>
Message-ID: <1370451727-26826-1-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define xen_remap as ioremap_cache (MT_MEMORY and MT_DEVICE_CACHED end up
having the same AttrIndx encoding).

Remove include asm/mach/map.h, not unneeded.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/include/asm/xen/page.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/page.h
index 30cdacb..359a7b5 100644
--- a/arch/arm/include/asm/xen/page.h
+++ b/arch/arm/include/asm/xen/page.h
@@ -1,7 +1,6 @@
 #ifndef _ASM_ARM_XEN_PAGE_H
 #define _ASM_ARM_XEN_PAGE_H
 
-#include <asm/mach/map.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 
@@ -88,6 +87,6 @@ static inline bool set_phys_to_machine(unsigned long pfn, unsigned long mfn)
 	return __set_phys_to_machine(pfn, mfn);
 }
 
-#define xen_remap(cookie, size) __arm_ioremap((cookie), (size), MT_MEMORY);
+#define xen_remap(cookie, size) ioremap_cached((cookie), (size));
 
 #endif /* _ASM_ARM_XEN_PAGE_H */
-- 
1.7.2.5
