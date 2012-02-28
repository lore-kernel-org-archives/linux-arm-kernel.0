From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 28 Feb 2012 09:11:50 -0300
Subject: [PATCH] ARM: mx51: Fix build error due to missing include of
 <linux/bug.h>
Message-ID: <1330431110-22020-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following build error:

arch/arm/mach-imx/cpu_op-mx51.c: In function 'mx51_get_cpu_op':
arch/arm/mach-imx/cpu_op-mx51.c:27: error: implicit declaration of function 'BUILD_BUG_ON_ZERO'

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
This applies against linux-next

 arch/arm/mach-imx/cpu_op-mx51.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/cpu_op-mx51.c b/arch/arm/mach-imx/cpu_op-mx51.c
index 9d34c3d..9a4f77a 100644
--- a/arch/arm/mach-imx/cpu_op-mx51.c
+++ b/arch/arm/mach-imx/cpu_op-mx51.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <mach/hardware.h>
 #include <linux/kernel.h>
+#include <linux/bug.h>
 
 static struct cpu_op mx51_cpu_op[] = {
 	{
-- 
1.7.1
