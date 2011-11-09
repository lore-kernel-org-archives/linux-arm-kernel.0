From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  9 Nov 2011 02:02:44 -0200
Subject: [PATCH] ARM: arch.h: Include irq.h
Message-ID: <1320811364-12122-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix the following warning when building imx_v4_v5_defconfig target:

  CC      arch/arm/mach-imx/mach-imx27ipcam.o
In file included from arch/arm/mach-imx/mach-imx27ipcam.c:18:
/home/fabio/linus/linux-2.6/arch/arm/include/asm/mach/arch.h:47: warning: 'struct pt_regs' declared inside parameter list
/home/fabio/linus/linux-2.6/arch/arm/include/asm/mach/arch.h:47: warning: its scope is only this definition or declaration, which is probably not what you want
arch/arm/mach-imx/mach-imx27ipcam.c:78: warning: initialization from incompatible pointer type

'struct pt_regs' is declared in arch/arm/include/asm/irq.h, so include this header.

Cc: Eric Miao <eric.miao@canonical.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/include/asm/mach/arch.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 7d19425..71f8bec 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -7,6 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <asm/mach/irq.h>
 
 #ifndef __ASSEMBLY__
 
-- 
1.7.1
