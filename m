From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 26 Feb 2012 13:27:04 -0300
Subject: [PATCH] ARM: mach-imx: mx3: Fix section mismatch in imx3_init_l2x0()
Message-ID: <1330273624-5757-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following section mismatch:

WARNING: vmlinux.o(.text+0x11be8): Section mismatch in reference from the function imx3_init_l2x0() to the function .init.text:l2x0_init()
The function imx3_init_l2x0() references
the function __init l2x0_init().
This is often because imx3_init_l2x0 lacks a __init 
annotation or the annotation of l2x0_init is wrong.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mm-imx3.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 8404ee7..6222151 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -76,7 +76,7 @@ static void __iomem *imx3_ioremap(unsigned long phys_addr, size_t size,
 	return __arm_ioremap(phys_addr, size, mtype);
 }
 
-void imx3_init_l2x0(void)
+void __init imx3_init_l2x0(void)
 {
 	void __iomem *l2x0_base;
 	void __iomem *clkctl_base;
-- 
1.7.1
