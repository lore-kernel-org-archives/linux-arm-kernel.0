From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 25 Mar 2013 09:20:29 -0300
Subject: [PATCH 2/17] ARM: mach-imx: mm-imx3: Staticize imx3_init_l2x0()
In-Reply-To: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
References: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1364214044-13950-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following sparse warning:

arch/arm/mach-imx/mm-imx3.c:85:13: warning: symbol 'imx3_init_l2x0' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mm-imx3.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index cefa047..e0e69a6 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -82,7 +82,7 @@ static void __iomem *imx3_ioremap_caller(unsigned long phys_addr, size_t size,
 	return __arm_ioremap_caller(phys_addr, size, mtype, caller);
 }
 
-void __init imx3_init_l2x0(void)
+static void __init imx3_init_l2x0(void)
 {
 #ifdef CONFIG_CACHE_L2X0
 	void __iomem *l2x0_base;
-- 
1.7.9.5
