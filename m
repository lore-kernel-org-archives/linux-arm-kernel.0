From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 11 Jan 2013 14:51:59 +1100
Subject: linux-next: manual merge of the arm-soc tree with the xilinx tree
Message-ID: <20130111145159.dfc665289a312bf4b069eb16@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-zynq/common.c between commit 453708c6da9b ("arm: zynq:
timer: Replace PSS through PS") from the xilinx tree and commit
6bb27d7349db ("ARM: delete struct sys_timer") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-zynq/common.c
index 892f65e,2ae4bce..0000000
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@@ -90,16 -90,9 +90,9 @@@ static void __init xilinx_zynq_timer_in
  
  	xilinx_zynq_clocks_init(slcr);
  
 -	xttcpss_timer_init();
 +	xttcps_timer_init();
  }
  
- /*
-  * Instantiate and initialize the system timer structure
-  */
- static struct sys_timer xttcps_sys_timer = {
- 	.init		= xilinx_zynq_timer_init,
- };
- 
  /**
   * xilinx_map_io() - Create memory mappings needed for early I/O.
   */
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130111/5c13c9dd/attachment.sig>
