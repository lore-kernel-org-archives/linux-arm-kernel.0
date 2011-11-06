From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:52:30 +0000
Subject: [PATCH 37/41] ARM: restart: Versatile Express: use new restart hook
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6tS-0001Z5-Df@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook the Versatile Express platform restart code into the new restart
hook.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-vexpress/v2m.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 1fafc32..b9a465b 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -437,7 +437,6 @@ static void __init v2m_init(void)
 		amba_device_register(v2m_amba_devs[i], &iomem_resource);
 
 	pm_power_off = v2m_power_off;
-	arm_pm_restart = v2m_restart;
 
 	ct_desc->init_tile();
 }
@@ -449,4 +448,5 @@ MACHINE_START(VEXPRESS, "ARM-Versatile Express")
 	.init_irq	= v2m_init_irq,
 	.timer		= &v2m_timer,
 	.init_machine	= v2m_init,
+	.restart	= v2m_restart,
 MACHINE_END
-- 
1.7.4.4
