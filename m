From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 16 Jan 2013 14:12:11 +1100
Subject: linux-next: manual merge of the tegra tree with the arm-soc tree
In-Reply-To: <20130116141016.a831f6d246b0f038c4afab98@canb.auug.org.au>
References: <20130116141016.a831f6d246b0f038c4afab98@canb.auug.org.au>
Message-ID: <20130116141211.c051e57f1b5281ea23fecb99@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

On Wed, 16 Jan 2013 14:10:16 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Today's linux-next merge of the tegra tree got a conflict in
> arch/arm/mach-tegra/board-dt-tegra20.c between commit 1d5cc604f42f ("ARM:
> remove mach .handle_irq for GIC users") from the arm-soc tree and commit
> ac0fd9eca3ba ("ARM: tegra: move timer.c to drivers/clocksource/") from
> the tegra tree.

This also affected arch/arm/mach-tegra/board-dt-tegra30.c.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-tegra/board-dt-tegra30.c
index 12dc2dd,cfe5fc0..0000000
--- a/arch/arm/mach-tegra/board-dt-tegra30.c
+++ b/arch/arm/mach-tegra/board-dt-tegra30.c
@@@ -111,7 -113,8 +112,7 @@@ DT_MACHINE_START(TEGRA30_DT, "NVIDIA Te
  	.map_io		= tegra_map_common_io,
  	.init_early	= tegra30_init_early,
  	.init_irq	= tegra_dt_init_irq,
- 	.init_time	= tegra_init_timer,
 -	.handle_irq	= gic_handle_irq,
+ 	.init_time	= clocksource_of_init,
  	.init_machine	= tegra30_dt_init,
  	.init_late	= tegra_init_late,
  	.restart	= tegra_assert_system_reset,
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130116/e1702c0c/attachment-0001.sig>
