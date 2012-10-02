From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  2 Oct 2012 09:13:21 +0100
Subject: [PATCH 08/10] ARM: ux500: Stop calling the UIB init function when
 using Device Tree
In-Reply-To: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
References: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1349165603-24401-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As there will be a Device Tree created for the UIBs, there is no
need to call the UIB initiation functions. Each device will be
detailed and registered from the Device Tree instead.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 610ad7f..f85659b 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -345,7 +345,7 @@ DT_MACHINE_START(U8500_DT, "ST-Ericsson U8500 platform (Device Tree Support)")
 	.timer		= &ux500_timer,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= u8500_init_machine,
-	.init_late	= ux500_init_late,
+	.init_late	= NULL,
 	.dt_compat      = u8500_dt_board_compat,
 MACHINE_END
 
-- 
1.7.9.5
