From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 19 Apr 2013 16:59:31 +1000
Subject: linux-next: manual merge of the renesas tree with the arm-soc tree
Message-ID: <20130419165931.740d243c82497664e6bd95b1@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Today's linux-next merge of the renesas tree got a conflict in
arch/arm/mach-shmobile/setup-r8a7740.c between commit 0583fe478a7d ("ARM:
convert arm/arm64 arch timer to use CLKSRC_OF init") from the arm-soc
tree and commit 74d6523995cc ("ARM: shmobile: r8a7740: Prepare for
reference DT setup") from the renesas tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-shmobile/setup-r8a7740.c
index 326a4ab,00c5a70..0000000
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@@ -1027,9 -1016,10 +1016,9 @@@ static const char *r8a7740_boards_compa
  
  DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
  	.map_io		= r8a7740_map_io,
- 	.init_early	= r8a7740_add_early_devices_dt,
- 	.init_irq	= r8a7740_init_irq,
- 	.init_machine	= r8a7740_add_standard_devices_dt,
+ 	.init_early	= r8a7740_init_delay,
+ 	.init_irq	= r8a7740_init_irq_of,
+ 	.init_machine	= r8a7740_generic_init,
 -	.init_time	= shmobile_timer_init,
  	.dt_compat	= r8a7740_boards_compat_dt,
  MACHINE_END
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130419/364f4f13/attachment.sig>
