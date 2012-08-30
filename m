From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 Aug 2012 19:22:36 +0200
Subject: [PATCH] ARM: gemini: fix the gemini build
Message-ID: <1346347356-18786-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Test-compiling obscure machines I notice that the gemini (which
by the way lacks a defconfig) is broken since some time back.
Adding a simple missing include makes it build again.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC guys: please apply this patch directly to the -rc:s
unless there is some obvious problem with it.
---
 arch/arm/mach-gemini/irq.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-gemini/irq.c b/arch/arm/mach-gemini/irq.c
index ca70e5f..020852d 100644
--- a/arch/arm/mach-gemini/irq.c
+++ b/arch/arm/mach-gemini/irq.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
+#include <asm/system_misc.h>
 #include <mach/hardware.h>
 
 #define IRQ_SOURCE(base_addr)	(base_addr + 0x00)
-- 
1.7.7.6
