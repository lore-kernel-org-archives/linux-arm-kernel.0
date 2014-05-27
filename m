From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 27 May 2014 10:48:47 +1000
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20140527104847.1842b04e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-rockchip/rockchip.c between commit fc2553457ccd ("ARM:
l2c: rockchip: convert to generic l2c OF initialisation") from the arm
tree and commit 26ab69cb4c1f ("ARM: rockchip: convert smp bringup to
CPU_METHOD_OF_DECLARE") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-rockchip/rockchip.c
index 138b9975313a,4499b0a31a27..000000000000
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@@ -33,8 -39,6 +33,7 @@@ static const char * const rockchip_boar
  };
  
  DT_MACHINE_START(ROCKCHIP_DT, "Rockchip Cortex-A9 (Device Tree)")
 -	.init_machine	= rockchip_dt_init,
 +	.l2c_aux_val	= 0,
 +	.l2c_aux_mask	= ~0,
- 	.smp		= smp_ops(rockchip_smp_ops),
  	.dt_compat	= rockchip_board_dt_compat,
  MACHINE_END
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140527/e9902405/attachment-0001.sig>
