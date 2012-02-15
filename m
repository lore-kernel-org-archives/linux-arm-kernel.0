From: olof@lixom.net (Olof Johansson)
Date: Wed, 15 Feb 2012 14:24:42 -0800
Subject: [PATCH] ARM: iop: add missing includes
Message-ID: <1329344682-29962-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resolves two build breaks. One is a boatload of "unknown type name 'u32'"
in iop3xx.h due to missing include of <linux/types.h>.

The other is:
arch/arm/plat-iop/restart.c: In function 'iop3xx_restart':
arch/arm/plat-iop/restart.c:18:2: error: implicit declaration of function 'soft_restart' [-Werror=implicit-function-declaration]

Signed-off-by: Olof Johansson <olof@lixom.net>
---

 arch/arm/include/asm/hardware/iop3xx.h |    2 ++
 arch/arm/plat-iop/restart.c            |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/hardware/iop3xx.h b/arch/arm/include/asm/hardware/iop3xx.h
index 077c323..ec0224d 100644
--- a/arch/arm/include/asm/hardware/iop3xx.h
+++ b/arch/arm/include/asm/hardware/iop3xx.h
@@ -15,6 +15,8 @@
 #ifndef __IOP3XX_H
 #define __IOP3XX_H
 
+#include <linux/types.h>
+
 /*
  * IOP3XX GPIO handling
  */
diff --git a/arch/arm/plat-iop/restart.c b/arch/arm/plat-iop/restart.c
index 6a85a0c..a6ee3b6 100644
--- a/arch/arm/plat-iop/restart.c
+++ b/arch/arm/plat-iop/restart.c
@@ -8,6 +8,7 @@
  * published by the Free Software Foundation.
  */
 #include <asm/hardware/iop3xx.h>
+#include <asm/system.h>
 #include <mach/hardware.h>
 
 void iop3xx_restart(char mode, const char *cmd)
-- 
1.7.9.209.gb6b3b
