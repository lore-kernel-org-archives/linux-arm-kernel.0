From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue,  1 Jun 2010 11:14:17 +0900
Subject: [PATCH] ARM: S5P: Bug fix on external interrupt for S5P series
Message-ID: <1275358457-27768-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boojin Kim <boojin.kim@samsung.com>

This patch fixes bug on eint type set function, s5p_irq_eint_set_type().
In the IRQ_TYPE_EDGE_FALLING case, S5P_EXTINT_FALLEDGE is right
instead of S5P_EXTINT_RISEEDGE

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s5p/irq-eint.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s5p/irq-eint.c b/arch/arm/plat-s5p/irq-eint.c
index e56c807..f36cd33 100644
--- a/arch/arm/plat-s5p/irq-eint.c
+++ b/arch/arm/plat-s5p/irq-eint.c
@@ -71,7 +71,7 @@ static int s5p_irq_eint_set_type(unsigned int irq, unsigned int type)
 		break;
 
 	case IRQ_TYPE_EDGE_FALLING:
-		newvalue = S5P_EXTINT_RISEEDGE;
+		newvalue = S5P_EXTINT_FALLEDGE;
 		break;
 
 	case IRQ_TYPE_EDGE_BOTH:
-- 
1.6.2.5
