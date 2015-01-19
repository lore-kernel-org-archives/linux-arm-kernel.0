From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 19 Jan 2015 09:44:14 +0000
Subject: [PATCH v4 20/21] ARM: zynq: switch from gic_arch_extn to
 gic_set_irqchip_flags
In-Reply-To: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
References: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1421660655-21394-21-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of directly touching gic_arch_extn, which is about to
be removed, use gic_set_irqchip_flags instead.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-zynq/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 26f92c2..82734d5 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -188,7 +188,7 @@ static void __init zynq_map_io(void)
 
 static void __init zynq_irq_init(void)
 {
-	gic_arch_extn.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND;
+	gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND);
 	irqchip_init();
 }
 
-- 
2.1.4
