From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 22 Dec 2014 13:05:40 +0300
Subject: [PATCH 5/5] ARM: sa1100: use handle_domain_irq
In-Reply-To: <1419242740-20219-1-git-send-email-dbaryshkov@gmail.com>
References: <1419242740-20219-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1419242740-20219-5-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use handle_domain_irq instead of handle_IRQ to automatically map
hardware irq number to virq.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index a7d116a..65aebfa 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -147,7 +147,8 @@ sa1100_handle_irq(struct pt_regs *regs)
 		if (mask == 0)
 			break;
 
-		handle_IRQ(ffs(mask) - 1 + IRQ_GPIO0_SC, regs);
+		handle_domain_irq(sa1100_normal_irqdomain,
+				ffs(mask) - 1, regs);
 	} while (1);
 }
 
-- 
2.1.3
