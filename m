From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 Oct 2012 15:45:26 +0100
Subject: [PATCH 6/6] ARM: ux500: Convert DT_MACHINE_START to use SMP operations
In-Reply-To: <1351089926-32161-1-git-send-email-lee.jones@linaro.org>
References: <1351089926-32161-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1351089926-32161-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Device Tree machine description for the ux5x0 was moved
recently and as a consequence missed the addition of SMP
operations. Without this patch SMP doesn't work and only one
CPU is present after booting.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index c65e7e3..4a0c40a 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -339,6 +339,7 @@ static const char * stericsson_dt_platform_compat[] = {
 };
 
 DT_MACHINE_START(U8500_DT, "ST-Ericsson Ux5x0 platform (Device Tree Support)")
+	.smp            = smp_ops(ux500_smp_ops),
 	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
 	/* we re-use nomadik timer here */
-- 
1.7.9.5
