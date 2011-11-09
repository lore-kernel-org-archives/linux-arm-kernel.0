From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 9 Nov 2011 10:10:48 -0200
Subject: [PATCH v2] ARM: arch.h: Declare 'pt_regs' locally
Message-ID: <1320840648-3197-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following warning when building imx_v4_v5_defconfig target:

  CC      arch/arm/mach-imx/mach-imx27ipcam.o
In file included from arch/arm/mach-imx/mach-imx27ipcam.c:18:
/home/fabio/linus/linux-2.6/arch/arm/include/asm/mach/arch.h:47: warning: 'struct pt_regs' declared inside parameter list
/home/fabio/linus/linux-2.6/arch/arm/include/asm/mach/arch.h:47: warning: its scope is only this definition or declaration, which is probably not what you want
arch/arm/mach-imx/mach-imx27ipcam.c:78: warning: initialization from incompatible pointer type

Declare 'struct pt_regs' locally.

Cc: Eric Miao <eric.miao@canonical.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Define struct pt_regs locally instead of adding <asm/mach/irq.h>
- Change the Subject accordingly

 arch/arm/include/asm/mach/arch.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 7d19425..2b0efc3 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -13,6 +13,7 @@
 struct tag;
 struct meminfo;
 struct sys_timer;
+struct pt_regs;
 
 struct machine_desc {
 	unsigned int		nr;		/* architecture number	*/
-- 
1.7.1
