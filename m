From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 25 Mar 2013 11:03:45 -0300
Subject: [PATCH v2 12/17] ARM: mach-imx: tzic: Staticize *tzic_base
Message-ID: <1364220225-14476-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following sparse warning:

arch/arm/mach-imx/tzic.c:52:14: warning: symbol 'tzic_base' was not declared. Should it be static?

Also, remove the comment, as it does not apply for kernels newer than 3.2.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Remove the comment as per Sascha's suggestion.
 
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
+static void __iomem *tzic_base;
 static struct irq_domain *domain;
 
 #define TZIC_NUM_IRQS 128
-- 
1.7.9.5
