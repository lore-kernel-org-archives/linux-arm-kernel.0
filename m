From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 30 May 2018 09:40:40 +1000
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20180530094040.5fa6dcdd@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  arch/arm/include/asm/cputype.h

between commit:

  1067a8130b17 ("ARM: add more CPU part numbers for Cortex and Brahma B15 CPUs")

from the arm tree and commits:

  9e35ddc962a6 ("ARM: add Broadcom Brahma-B53 main ID definition")
  842fa17d6c95 ("ARM: add Broadcom Brahma-B15 main ID definition")

from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm/include/asm/cputype.h
index 26021980504d,d1b62ee69f3b..000000000000
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@@ -77,15 -75,11 +75,16 @@@
  #define ARM_CPU_PART_CORTEX_A12		0x4100c0d0
  #define ARM_CPU_PART_CORTEX_A17		0x4100c0e0
  #define ARM_CPU_PART_CORTEX_A15		0x4100c0f0
 +#define ARM_CPU_PART_CORTEX_A53		0x4100d030
 +#define ARM_CPU_PART_CORTEX_A57		0x4100d070
 +#define ARM_CPU_PART_CORTEX_A72		0x4100d080
 +#define ARM_CPU_PART_CORTEX_A73		0x4100d090
 +#define ARM_CPU_PART_CORTEX_A75		0x4100d0a0
  #define ARM_CPU_PART_MASK		0xff00fff0
  
- /* Broadcom cores */
+ /* Broadcom implemented processors */
  #define ARM_CPU_PART_BRAHMA_B15		0x420000f0
+ #define ARM_CPU_PART_BRAHMA_B53		0x42001000
  
  /* DEC implemented cores */
  #define ARM_CPU_PART_SA1100		0x4400a110
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180530/9058fefc/attachment.sig>
