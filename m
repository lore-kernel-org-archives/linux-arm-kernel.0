From: olof@lixom.net (Olof Johansson)
Date: Sat,  8 Nov 2014 22:42:34 -0800
Subject: [PATCH] ARM: at91: fix build breakage due to legacy board removals
Message-ID: <1415515354-7829-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the following missing includes:

arch/arm/mach-at91/at91sam9g45.c: In function 'at91sam9g45_init_time':
arch/arm/mach-at91/at91sam9g45.c:39:23: error: 'NR_IRQS_LEGACY' undeclared (first use in this function)
  at91sam926x_pit_init(NR_IRQS_LEGACY + AT91_ID_SYS);
                       ^
arch/arm/mach-at91/at91sam9g45.c:39:23: note: each undeclared identifier is reported only once for each function it appears in
make[3]: *** [arch/arm/mach-at91/at91sam9g45.o] Error 1
arch/arm/mach-at91/at91sam9rl.c: In function 'at91sam9rl_init_time':
arch/arm/mach-at91/at91sam9rl.c:51:23: error: 'NR_IRQS_LEGACY' undeclared (first use in this function)
  at91sam926x_pit_init(NR_IRQS_LEGACY + AT91_ID_SYS);

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
---

Nicolas,

I already checked this in to next/cleanup, posting mostly FYI.


-Olof

 arch/arm/mach-at91/at91sam9g45.c | 1 +
 arch/arm/mach-at91/at91sam9rl.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index dd03f652cca4..042f7c623c8f 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -11,6 +11,7 @@
  */
 
 #include <asm/system_misc.h>
+#include <asm/irq.h>
 #include <mach/cpu.h>
 #include <mach/hardware.h>
 
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 6ca7fc5ca812..97efb2ef9fb4 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -10,6 +10,7 @@
  */
 
 #include <asm/system_misc.h>
+#include <asm/irq.h>
 #include <mach/cpu.h>
 #include <mach/at91_dbgu.h>
 #include <mach/hardware.h>
-- 
2.0.1.473.gc4d58ca
