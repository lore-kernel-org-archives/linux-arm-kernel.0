From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 25 Mar 2013 09:20:40 -0300
Subject: [PATCH 13/17] ARM: mach-imx: avic: Staticize *avic_base
In-Reply-To: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
References: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1364214044-13950-13-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following sparse warning:

arch/arm/mach-imx/avic.c:54:14: warning: symbol 'avic_base' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/avic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/avic.c b/arch/arm/mach-imx/avic.c
index 0eff23e..9c3e014 100644
--- a/arch/arm/mach-imx/avic.c
+++ b/arch/arm/mach-imx/avic.c
@@ -51,7 +51,7 @@
 
 #define AVIC_NUM_IRQS 64
 
-void __iomem *avic_base;
+static void __iomem *avic_base;
 static struct irq_domain *domain;
 
 static u32 avic_saved_mask_reg[2];
-- 
1.7.9.5
