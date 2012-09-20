From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 20 Sep 2012 16:03:14 +1000
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20120920160314.b3ea668fc0766224c24bf276@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-integrator/integrator_cp.c between commit 73efd53012af
("ARM: 7519/1: integrator: convert platform devices to Device Tree") from
the arm tree and commit b7a3f8db07c1 ("ARM: integrator: use __iomem
pointers for MMIO") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-integrator/integrator_cp.c
index f51363e,3df5fc3..0000000
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@@ -55,7 -52,14 +55,7 @@@
  
  #define INTCP_PA_CLCD_BASE		0xc0000000
  
- #define INTCP_VA_CTRL_BASE		IO_ADDRESS(INTEGRATOR_CP_CTL_BASE)
 -#define INTCP_VA_CIC_BASE		__io_address(INTEGRATOR_HDR_BASE + 0x40)
 -#define INTCP_VA_PIC_BASE		__io_address(INTEGRATOR_IC_BASE)
 -#define INTCP_VA_SIC_BASE		__io_address(INTEGRATOR_CP_SIC_BASE)
 -
 -#define INTCP_ETH_SIZE			0x10
 -
+ #define INTCP_VA_CTRL_BASE		__io_address(INTEGRATOR_CP_CTL_BASE)
  #define INTCP_FLASHPROG			0x04
  #define CINTEGRATOR_FLASHPROG_FLVPPEN	(1 << 0)
  #define CINTEGRATOR_FLASHPROG_FLWREN	(1 << 1)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120920/f4dd3c5c/attachment.sig>
