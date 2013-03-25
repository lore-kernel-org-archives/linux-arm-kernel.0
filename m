From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 25 Mar 2013 09:20:39 -0300
Subject: [PATCH 12/17] ARM: mach-imx: tzic: Staticize *tzic_base
In-Reply-To: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
References: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1364214044-13950-12-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following sparse warning:

arch/arm/mach-imx/tzic.c:52:14: warning: symbol 'tzic_base' was not declared. Should it be static?

Also, reduce the comment in order to fit into 80 characters.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/tzic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/tzic.c b/arch/arm/mach-imx/tzic.c
index 9721161..1488a4a 100644
--- a/arch/arm/mach-imx/tzic.c
+++ b/arch/arm/mach-imx/tzic.c
@@ -49,7 +49,7 @@
 #define TZIC_SWINT	0x0F00	/* Software Interrupt Rigger Register */
 #define TZIC_ID0	0x0FD0	/* Indentification Register 0 */
 
-void __iomem *tzic_base; /* Used as irq controller base in entry-macro.S */
+static void __iomem *tzic_base; /* irq controller base in entry-macro.S */
 static struct irq_domain *domain;
 
 #define TZIC_NUM_IRQS 128
-- 
1.7.9.5
