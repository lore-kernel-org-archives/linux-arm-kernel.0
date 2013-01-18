From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 18 Jan 2013 14:24:57 +1100
Subject: linux-next: manual merge of the samsung tree with the arm-soc tree
Message-ID: <20130118142457.796fa6b444cfc0f8c0cdff0a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Today's linux-next merge of the samsung tree got a conflict in
arch/arm/mach-exynos/mach-exynos4-dt.c between commit 1d5cc604f42f ("ARM:
remove mach .handle_irq for GIC users") from the arm-soc tree and commit
d99de316e599 ("ARM: EXYNOS: Add support for Exynos secure firmware") from
the samsung tree.

I fixed it up (as supplied - see below) and can carry the fix as
necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-exynos/mach-exynos4-dt.c
index 112d10e,ab1dacc..0000000
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@@ -106,9 -107,11 +106,10 @@@ DT_MACHINE_START(EXYNOS4210_DT, "Samsun
  	.smp		= smp_ops(exynos_smp_ops),
  	.init_irq	= exynos4_init_irq,
  	.map_io		= exynos4_dt_map_io,
 -	.handle_irq	= gic_handle_irq,
+ 	.init_early	= exynos_firmware_init,
  	.init_machine	= exynos4_dt_machine_init,
  	.init_late	= exynos_init_late,
 -	.timer		= &exynos4_timer,
 +	.init_time	= exynos4_timer_init,
  	.dt_compat	= exynos4_dt_compat,
  	.restart        = exynos4_restart,
  MACHINE_END
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130118/28fd50d2/attachment.sig>
