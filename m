From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 2 Jun 2015 08:47:46 +1000
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20150602084746.3a931067@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-socfpga/core.h between commit 02b4e2756e01 ("ARM: v7
setup function should invalidate L1 cache") from the arm tree and
commit 122694a0c712 ("ARM: socfpga: use of_iomap to map the SCU") from
the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-socfpga/core.h
index 767c09e954a0,5913bbb50036..000000000000
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@@ -31,8 -31,8 +31,6 @@@
  
  #define RSTMGR_MPUMODRST_CPU1		0x2     /* CPU1 Reset */
  
- extern void __iomem *socfpga_scu_base_addr;
 -extern void socfpga_secondary_startup(void);
--
  extern void socfpga_init_clocks(void);
  extern void socfpga_sysmgr_init(void);
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150602/90494ea3/attachment.sig>
