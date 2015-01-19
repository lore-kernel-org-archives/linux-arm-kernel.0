From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 19 Jan 2015 09:44:13 +0000
Subject: [PATCH v4 19/21] ARM: ux500: switch from gic_arch_extn to
 gic_set_irqchip_flags
In-Reply-To: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
References: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1421660655-21394-20-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of directly touching gic_arch_extn, which is about to
be removed, use gic_set_irqchip_flags instead.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-ux500/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index dbb2970..6ced0f6 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -52,7 +52,7 @@ void ux500_restart(enum reboot_mode mode, const char *cmd)
 */
 void __init ux500_init_irq(void)
 {
-	gic_arch_extn.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND;
+	gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND);
 	irqchip_init();
 
 	/*
-- 
2.1.4
