From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Aug 2014 11:03:37 +0100
Subject: [PATCH v2 22/26] ARM: imx: avic: convert to handle_domain_irq
In-Reply-To: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1409047421-27649-23-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new handle_domain_irq method to handle interrupts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-imx/avic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/avic.c b/arch/arm/mach-imx/avic.c
index 24b103c..1a89323 100644
--- a/arch/arm/mach-imx/avic.c
+++ b/arch/arm/mach-imx/avic.c
@@ -144,7 +144,7 @@ static void __exception_irq_entry avic_handle_irq(struct pt_regs *regs)
 		if (nivector == 0xffff)
 			break;
 
-		handle_IRQ(irq_find_mapping(domain, nivector), regs);
+		handle_domain_irq(domain, nivector, regs);
 	} while (1);
 }
 
-- 
2.0.4
