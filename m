From: jochen@scram.de (Jochen Friedrich)
Date: Sat, 19 Nov 2011 19:24:01 +0100
Subject: [PATCH] ARM: sa1100: Fix nanoengine compile error.
Message-ID: <1321727041-26594-1-git-send-email-jochen@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  CC      arch/arm/mach-sa1100/nanoengine.o
arch/arm/mach-sa1100/nanoengine.c:75:11: error: 'PAGE_SHIFT' undeclared here (not in a function)
make[1]: *** [arch/arm/mach-sa1100/nanoengine.o] Error 1
make: *** [arch/arm/mach-sa1100] Error 2

Add missing include of asm/page.h

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/arm/mach-sa1100/nanoengine.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-sa1100/nanoengine.c b/arch/arm/mach-sa1100/nanoengine.c
index 032f388..d480438 100644
--- a/arch/arm/mach-sa1100/nanoengine.c
+++ b/arch/arm/mach-sa1100/nanoengine.c
@@ -19,6 +19,7 @@
 
 #include <asm/mach-types.h>
 #include <asm/setup.h>
+#include <asm/page.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
-- 
1.7.7.3
