From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 19 Nov 2012 14:38:00 -0200
Subject: [PATCH] ARM: Kconfig: Do not select ARCH_VEXPRESS on ARCH_MULTI_V7
Message-ID: <1353343080-19220-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Booting a kernel on a mx53qsb board (built with imx_v6_v7_defconfig) leads to:

Unable to handle kernel NULL pointer dereference at virtual address 00000008
pgd = 80004000
[00000008] *pgd=00000000
Internal error: Oops: 805 [#1] SMP ARM
Modules linked in:
CPU: 0    Not tainted  (3.7.0-rc5-next-20121115+ #715)
PC is at vexpress_sysreg_init_leds+0x30/0xb8
LR is at do_one_initcall+0x3c/0x190
pc : [<8065e170>]    lr : [<800086a0>]    psr: 60000153
sp : df855ef0  ip : df855f18  fp : df855f14
r10: 00000000  r9 : 8067eb5c  r8 : 8065e140
r7 : 80711cac  r6 : 806c2cc0  r5 : 00000000  r4 : 80673850
r3 : 00000000  r2 : 00000000  r1 : df854000  r0 : 8065e140
...

Since commit c5a0d4977 (ARM: imx: enable multi-platform build), imx_v6_v7_defconfig
selects CONFIG_ARCH_MULTI_V7=y, which in turn select ARCH_VEXPRESS.

Do not select ARCH_VEXPRESS on ARCH_MULTI_V7.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 14f8160..d40e9d3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1000,7 +1000,6 @@ config ARCH_MULTI_V7
 	bool "ARMv7 based platforms (Cortex-A, PJ4, Krait)"
 	default y
 	select ARCH_MULTI_V6_V7
-	select ARCH_VEXPRESS
 	select CPU_V7
 
 config ARCH_MULTI_V6_V7
-- 
1.7.9.5
