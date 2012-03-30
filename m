From: olof@lixom.net (Olof Johansson)
Date: Fri, 30 Mar 2012 07:38:46 -0700
Subject: [PATCH 2/2] ARM: clps711x: fix missing include file
Message-ID: <1333118326-25438-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

linux/bug.h is needed due to an ARRAY_SIZE being used:

arch/arm/mach-clps711x/edb7211-mm.c: In function 'edb7211_map_io':
arch/arm/mach-clps711x/edb7211-mm.c:79:9: error: implicit declaration of function 'BUILD_BUG_ON_ZERO'

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-clps711x/edb7211-mm.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-clps711x/edb7211-mm.c b/arch/arm/mach-clps711x/edb7211-mm.c
index 0bea145..4372f06 100644
--- a/arch/arm/mach-clps711x/edb7211-mm.c
+++ b/arch/arm/mach-clps711x/edb7211-mm.c
@@ -21,6 +21,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/bug.h>
 
 #include <mach/hardware.h>
 #include <asm/page.h>
-- 
1.7.9.2.359.gebfc2
