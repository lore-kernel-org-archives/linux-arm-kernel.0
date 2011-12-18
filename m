From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 19 Dec 2011 10:55:37 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20111219105537.6c3346b5ed94fccd486ba136@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-omap2/board-ti8168evm.c between commit fae51fbd5b0b ("ARM:
restart: omap: use new restart hook") from the arm tree and commit
a890b6760d97 ("ARM: OMAP: TI814X: Create board support and enable build
for TI8148 EVM") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-omap2/board-ti8168evm.c
index 74713e3,5b6ad6e..0000000
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@@ -43,10 -47,19 +47,21 @@@ static void __init ti81xx_evm_init(void
  MACHINE_START(TI8168EVM, "ti8168evm")
  	/* Maintainer: Texas Instruments */
  	.atag_offset	= 0x100,
- 	.map_io		= ti8168_evm_map_io,
- 	.init_early	= ti816x_init_early,
- 	.init_irq	= ti816x_init_irq,
+ 	.map_io		= ti81xx_map_io,
+ 	.init_early	= ti81xx_init_early,
+ 	.init_irq	= ti81xx_init_irq,
+ 	.timer		= &omap3_timer,
+ 	.init_machine	= ti81xx_evm_init,
++	.restart	= omap_prcm_restart,
+ MACHINE_END
+ 
+ MACHINE_START(TI8148EVM, "ti8148evm")
+ 	/* Maintainer: Texas Instruments */
+ 	.atag_offset	= 0x100,
+ 	.map_io		= ti81xx_map_io,
+ 	.init_early	= ti81xx_init_early,
+ 	.init_irq	= ti81xx_init_irq,
  	.timer		= &omap3_timer,
- 	.init_machine	= ti8168_evm_init,
+ 	.init_machine	= ti81xx_evm_init,
 +	.restart	= omap_prcm_restart,
  MACHINE_END
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111219/1f57375f/attachment.sig>
