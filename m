From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 22 Mar 2013 15:09:41 +1100
Subject: linux-next: manual merge of the imx-mxs tree with the arm-soc tree
Message-ID: <20130322150941.dd103b83bc0da8a4bcb1647f@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Today's linux-next merge of the imx-mxs tree got a conflict in
arch/arm/mach-imx/mach-imx6q.c between commit da4a686a2cfb ("ARM:
smp_twd: convert to use CLKSRC_OF init") from the arm-soc tree and commit
371287432334 ("ARM: imx: enable anatop suspend/resume") from the imx-mxs
tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-imx/mach-imx6q.c
index b59ddcb,31aee4d..0000000
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@@ -291,8 -257,7 +256,7 @@@ static void __init imx6q_init_irq(void
  static void __init imx6q_timer_init(void)
  {
  	mx6q_clocks_init();
 -	twd_local_timer_of_register();
 +	clocksource_of_init();
- 	imx_print_silicon_rev("i.MX6Q", imx6q_revision());
  }
  
  static const char *imx6q_dt_compat[] __initdata = {
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130322/da4ce0d1/attachment.sig>
