From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 22 Jan 2012 04:02:31 -0700
Subject: [PATCH 1/3] ARM: OMAP: PRM: fix missing plat/irqs.h build breakage
In-Reply-To: <20120122105942.6508.82335.stgit@dusk>
References: <20120122105942.6508.82335.stgit@dusk>
Message-ID: <20120122110229.6508.90255.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 22f51371f8c35869ed850f46aa76b6cc2b502110 ("ARM: OMAP3: pm: use
prcm chain handler") breaks the build on a 2420-only config, due to
a missing include for plat/irqs.h:

  CC      arch/arm/mach-omap2/prm2xxx_3xxx.o
arch/arm/mach-omap2/prm2xxx_3xxx.c:41:11: error: 'INT_34XX_PRCM_MPU_IRQ' undeclared here (not in a function)

Fix by explicitly including it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/prm2xxx_3xxx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index c1c4d86..9ce7654 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -19,6 +19,7 @@
 #include "common.h"
 #include <plat/cpu.h>
 #include <plat/prcm.h>
+#include <plat/irqs.h>
 
 #include "vp.h"
 
