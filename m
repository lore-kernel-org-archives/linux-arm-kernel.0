From: olof@lixom.net (Olof Johansson)
Date: Sun,  1 Jan 2012 21:52:27 -0800
Subject: [PATCH] ARM: include linux/kernel.h in asm/bug.h
Message-ID: <1325483547-13853-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__BUG() has a dependency on BUILD_BUG_ON() which comes from
include/linux/kernel.h. Found with mini2440_defconfig:

In file included from include/linux/mtd/qinfo.h:4:0,
                 from include/linux/mtd/pfow.h:7,
                 from drivers/mtd/lpddr/lpddr_cmds.c:27:
include/linux/mtd/map.h: In function 'inline_map_read':
include/linux/mtd/map.h:408:3: error: implicit declaration of function 'BUILD_BUG_ON' [-Werror=implicit-function-declaration]

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/include/asm/bug.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
index 9abe7a0..0291594 100644
--- a/arch/arm/include/asm/bug.h
+++ b/arch/arm/include/asm/bug.h
@@ -1,6 +1,7 @@
 #ifndef _ASMARM_BUG_H
 #define _ASMARM_BUG_H
 
+#include <linux/kernel.h>
 
 #ifdef CONFIG_BUG
 
-- 
1.7.8.GIT
