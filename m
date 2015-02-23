From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 23 Feb 2015 17:45:55 +0000
Subject: [PATCH v5 4/4] ARM: zynq: switch from gic_arch_extn to
 gic_set_irqchip_flags
In-Reply-To: <1424713555-7201-1-git-send-email-marc.zyngier@arm.com>
References: <1424713555-7201-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1424713555-7201-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of directly touching gic_arch_extn, which is about to
be removed, use gic_set_irqchip_flags instead.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-zynq/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index c887196..58ef2a7 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -186,7 +186,7 @@ static void __init zynq_map_io(void)
 
 static void __init zynq_irq_init(void)
 {
-	gic_arch_extn.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND;
+	gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND);
 	irqchip_init();
 }
 
-- 
2.1.4
