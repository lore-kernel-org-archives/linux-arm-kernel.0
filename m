From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  3 Jul 2012 22:25:44 -0300
Subject: [PATCH] ARM: imx: Fix build error due to missing irqs.h include
Message-ID: <1341365144-4549-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

commit bc8966 (ARM: fiq: change FIQ_START to a variable) introduced the 
following build error for imx_v4_v5_defconfig:

arch/arm/plat-mxc/avic.c:220:11: error: 'FIQ_START' undeclared (first use in this function)

Include the missing header file to fix it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/plat-mxc/avic.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
index f3d671f..cbd55c3 100644
--- a/arch/arm/plat-mxc/avic.c
+++ b/arch/arm/plat-mxc/avic.c
@@ -26,6 +26,7 @@
 #include <asm/mach/irq.h>
 #include <asm/exception.h>
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 
 #include "irq-common.h"
 
-- 
1.7.1
