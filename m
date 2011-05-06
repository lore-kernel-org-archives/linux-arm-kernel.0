From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 6 May 2011 11:58:16 +0200
Subject: [PATCH] mach-ux500: fix SMP secondary startup regression
Message-ID: <1304675896-2747-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e2a083dc0da9aa6437e14811198379b18cdfa7f8
"ARM: consolidate SMP cross call implementation" broke the ux500
compilation since the smp.h header declared a function called
from headsmp.S. This fixes it up by declaring it locally instead.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/platsmp.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 4e33846..0c527fe 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -23,6 +23,9 @@
 #include <mach/hardware.h>
 #include <mach/setup.h>
 
+/* This is called from headsmp.S to wakeup the secondary core */
+extern void u8500_secondary_startup(void);
+
 /*
  * control for which core is the next to come out of the secondary
  * boot "holding pen"
-- 
1.7.3.2
