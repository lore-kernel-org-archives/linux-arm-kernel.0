From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Wed, 28 Apr 2010 04:15:51 +0200
Subject: [RESUBMIT] [PATCH v4 0.1/5(7)] OMAP: add missing FIQ_START definition
	required for arch/arm/kernel/fiq.c compilation
In-Reply-To: <201004280258.27281.jkrzyszt@tis.icnet.pl>
References: <201004280252.58420.jkrzyszt@tis.icnet.pl>
	<201004280258.27281.jkrzyszt@tis.icnet.pl>
Message-ID: <201004280415.53609.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several ARM platforms/machines that use FIQ define their value of FIQ_START. 
Since FIQ is not implemented for OMAP yet, this definition is missing from 
OMAP header files.

Put an arbitrary value for FIQ_START into plat/irqs.h for OMAP. Even if not 
used by the FIQ handler for Amstrad Delta, this is required for successfull 
compilation of arch/arm/kernel/fiq.c that provides several usefull functions.

Created and tested against linux-omap master, 
commit 104a77440f05430f29f9d3f4ecb88c1536819585 dated 2010-04-27.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
Affected file name was still wrong in the changelog text, sorry.

Provided as a separate patch since v3 of the patch set.
v4 changes: none (refreshed)

 arch/arm/plat-omap/include/plat/irqs.h |    4 ++++
 1 file changed, 4 insertions(+)

--- git.orig/arch/arm/plat-omap/include/plat/irqs.h	2010-04-27 21:40:24.000000000 +0200
+++ git/arch/arm/plat-omap/include/plat/irqs.h	2010-04-27 22:20:18.000000000 +0200
@@ -428,4 +428,8 @@ void omap3_intc_resume_idle(void);
 
 #include <mach/hardware.h>
 
+#ifdef CONFIG_FIQ
+#define FIQ_START		1024
+#endif
+
 #endif
