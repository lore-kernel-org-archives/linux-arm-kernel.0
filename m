From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 13 Jun 2012 21:38:57 +0800
Subject: [PATCH] ARM: irq: add a mach/fiq.h inclusion for SPARSE_IRQ build
In-Reply-To: <20120613130753.GA31565@S2101-09.ap.freescale.net>
References: <1339592253-25142-1-git-send-email-shawn.guo@linaro.org>
 <20120613130753.GA31565@S2101-09.ap.freescale.net>
Message-ID: <20120613133855.GB31565@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 09:07:56PM +0800, Shawn Guo wrote:
> Damned.  Just realized that this will break those platforms with
> SPARSE_IRQ enabled but no mach/fiq.h provided.
> 
What about adding #ifdef CONFIG_FIQ check for the inclusion?

--8<---

diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 35c21c3..8db119a 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -7,6 +7,9 @@
 #include <mach/irqs.h>
 #else
 #define NR_IRQS NR_IRQS_LEGACY
+#ifdef CONFIG_FIQ
+#include <mach/fiq.h>
+#endif
 #endif

 #ifndef irq_canonicalize

--->8--

Regards,
Shawn
