From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 16 Jan 2013 14:10:16 +1100
Subject: linux-next: manual merge of the tegra tree with the arm-soc tree
Message-ID: <20130116141016.a831f6d246b0f038c4afab98@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the tegra tree got a conflict in
arch/arm/mach-tegra/board-dt-tegra20.c between commit 1d5cc604f42f ("ARM:
remove mach .handle_irq for GIC users") from the arm-soc tree and commit
ac0fd9eca3ba ("ARM: tegra: move timer.c to drivers/clocksource/") from
the tegra tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-tegra/board-dt-tegra20.c
index 5ed81bab,171ba3c..0000000
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@@ -200,7 -203,8 +201,7 @@@ DT_MACHINE_START(TEGRA_DT, "nVidia Tegr
  	.smp		= smp_ops(tegra_smp_ops),
  	.init_early	= tegra20_init_early,
  	.init_irq	= tegra_dt_init_irq,
- 	.init_time	= tegra_init_timer,
 -	.handle_irq	= gic_handle_irq,
+ 	.init_time	= clocksource_of_init,
  	.init_machine	= tegra_dt_init,
  	.init_late	= tegra_dt_init_late,
  	.restart	= tegra_assert_system_reset,
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130116/b4c2fd46/attachment.sig>
