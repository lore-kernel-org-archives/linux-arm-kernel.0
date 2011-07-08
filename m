From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Fri, 8 Jul 2011 19:24:57 +0400
Subject: [PATCH] DaVinci: correct MDSTAT_STATE_MASK
Message-ID: <201107081924.57577.sshtylyov@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MDSTAT.STATE occupies bits 0..5 according to all available documentation, so fix
the #define MDSTAT_STATE_MASK at last. Using the wrong value seems to have been
harmless though...

This was noticed by me back in 2009 but I didn't follow up with the patch back
then... :-/

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent DaVinci tree.

 arch/arm/mach-davinci/include/mach/psc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-davinci/arch/arm/mach-davinci/include/mach/psc.h
===================================================================
--- linux-davinci.orig/arch/arm/mach-davinci/include/mach/psc.h
+++ linux-davinci/arch/arm/mach-davinci/include/mach/psc.h
@@ -243,7 +243,7 @@
 #define PSC_STATE_DISABLE	2
 #define PSC_STATE_ENABLE	3
 
-#define MDSTAT_STATE_MASK	0x1f
+#define MDSTAT_STATE_MASK	0x3f
 #define MDCTL_FORCE		BIT(31)
 
 #ifndef __ASSEMBLER__
