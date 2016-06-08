From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  8 Jun 2016 18:16:10 +0100
Subject: [PATCH] ARM: versatile: fix missing <plat/platsmp.h> include
Message-ID: <1465406170-24420-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix two missing function declarations by including the
<plat/platsmp.h> file where they are defined. Fixes:

arch/arm/plat-versatile/platsmp.c:35:6: warning: symbol 'versatile_secondary_init' was not declared. Should it be static?
arch/arm/plat-versatile/platsmp.c:50:5: warning: symbol 'versatile_boot_secondary' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/plat-versatile/platsmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
index 53feb90..c236651 100644
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -18,6 +18,8 @@
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 
+#include <plat/platsmp.h>
+
 /*
  * Write pen_release in a way that is guaranteed to be visible to all
  * observers, irrespective of whether they're taking part in coherency
-- 
2.8.1
