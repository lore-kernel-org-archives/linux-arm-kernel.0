From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Dec 2015 11:06:21 +0100
Subject: [PATCH 09/10] ARM: realview: make all header files local
In-Reply-To: <1448469143-447355-10-git-send-email-arnd@arndb.de>
References: <1448469143-447355-1-git-send-email-arnd@arndb.de>
 <1448469143-447355-10-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdZOi-R-Bxo2qnka7BxW-gw4E1S+joti6sxETdi3qEMcLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 5:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Nothing includes these files any more, so we can simply move them
> from arch/arm/mach-realview/include/mach/ to arch/arm/mach-realview.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

This patchset has problems because the boardfiles aren't really
compiled even if CONFIG_ATAGS is set. I had to apply this:

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 7cd543b1eace..baf174542e36 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -46,7 +46,6 @@
 #include <asm/mach/map.h>

 #include "platform.h"
-#include "irqs.h"

 #include <plat/sched_clock.h>

diff --git a/arch/arm/mach-realview/irqs-pb1176.h
b/arch/arm/mach-realview/irqs-pb1176.h
index e96c63e4ac72..778edfd430e7 100644
--- a/arch/arm/mach-realview/irqs-pb1176.h
+++ b/arch/arm/mach-realview/irqs-pb1176.h
@@ -74,6 +74,4 @@

 #define IRQ_PB1176_SCTL                -1

-#endif /* CONFIG_MACH_REALVIEW_PB1176 */
-
 #endif /* __MACH_IRQS_PB1176_H */

Yours,
Linus Walleij
