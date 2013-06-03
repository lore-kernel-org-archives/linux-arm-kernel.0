From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 3 Jun 2013 15:41:01 +1000
Subject: linux-next: manual merge of the imx-mxs tree with the arm-soc tree
Message-ID: <20130603154101.f35d9198796f9735f0c886ad@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Today's linux-next merge of the imx-mxs tree got a conflict in
arch/arm/mach-mxs/mach-mxs.c between commit 6aaab172c99b ("ARM: mxs:
remove the .map_io declaration") from the arm-soc tree and commit
fe7149dfa886 ("ARM: mxs: Remove init_irq declaration in machine
description") from the imx-mxs tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-mxs/mach-mxs.c
index d67ecc1,66fe810..0000000
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@@ -434,7 -433,7 +433,6 @@@ static const char *mxs_dt_compat[] __in
  };
  
  DT_MACHINE_START(MXS, "Freescale MXS (Device Tree)")
- 	.init_irq	= irqchip_init,
 -	.map_io		= debug_ll_io_init,
  	.handle_irq	= icoll_handle_irq,
  	.init_time	= mxs_timer_init,
  	.init_machine	= mxs_machine_init,
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130603/c8c6782a/attachment.sig>
