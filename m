From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 May 2013 11:44:12 +0200
Subject: [PATCH 13/14] ARM: virt: Remove init_irq declaration in machine
 description
In-Reply-To: <1368438253-28218-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1368438253-28218-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1368438253-28218-14-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
specified") removed the need to explictly setup the init_irq field in
the machine description when using only irqchip_init. Remove that
declaration for virt as well.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-virt/virt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-virt/virt.c b/arch/arm/mach-virt/virt.c
index 061f283..2370a61 100644
--- a/arch/arm/mach-virt/virt.c
+++ b/arch/arm/mach-virt/virt.c
@@ -39,7 +39,6 @@ static const char *virt_dt_match[] = {
 extern struct smp_operations virt_smp_ops;
 
 DT_MACHINE_START(VIRT, "Dummy Virtual Machine")
-	.init_irq	= irqchip_init,
 	.init_machine	= virt_init,
 	.smp		= smp_ops(virt_smp_ops),
 	.dt_compat	= virt_dt_match,
-- 
1.8.1.2
