From: robherring2@gmail.com (Rob Herring)
Date: Tue, 20 Nov 2012 20:58:32 -0600
Subject: [PATCH 8/9] ARM: VIC: set handle_arch_irq in VIC initialization
In-Reply-To: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
References: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
Message-ID: <1353466713-18967-9-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Set handle_arch_irq to vic_handle_irq. Only the first VIC initialized can
setup the handler.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/common/vic.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index 7fd304b..97ea126 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -234,6 +234,7 @@ static void __init vic_register(void __iomem *base, unsigned int irq,
 	v->valid_sources = valid_sources;
 	v->resume_sources = resume_sources;
 	v->irq = irq;
+	set_handle_irq(vic_handle_irq);
 	vic_id++;
 	v->domain = irq_domain_add_legacy(node, fls(valid_sources), irq, 0,
 					  &vic_irqdomain_ops, v);
-- 
1.7.10.4
