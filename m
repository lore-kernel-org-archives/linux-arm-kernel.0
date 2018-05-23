From: broonie@kernel.org (Mark Brown)
Date: Wed, 23 May 2018 13:25:30 +0100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20180523122530.GJ4828@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  arch/arm/include/asm/cputype.h

between commit:

  b2ccaa851e9882c10 ("ARM: add CPU part numbers for Cortex A73, A75 and Brahma B15")

from the arm tree and several commits from the arm-soc tree:

  842fa17d6c95368d7 ("ARM: add Broadcom Brahma-B15 main ID definition")
  9e35ddc962a656bf4 ("ARM: add Broadcom Brahma-B53 main ID definition")

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/arm/include/asm/cputype.h
index adc4a3eef815,d1b62ee69f3b..000000000000
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@@ -77,12 -75,11 +75,13 @@@
  #define ARM_CPU_PART_CORTEX_A12		0x4100c0d0
  #define ARM_CPU_PART_CORTEX_A17		0x4100c0e0
  #define ARM_CPU_PART_CORTEX_A15		0x4100c0f0
 +#define ARM_CPU_PART_CORTEX_A73		0x4100d090
 +#define ARM_CPU_PART_CORTEX_A75		0x4100d0a0
  #define ARM_CPU_PART_MASK		0xff00fff0
  
 -/* Broadcom implemented processors */
 +/* Broadcom cores */
  #define ARM_CPU_PART_BRAHMA_B15		0x420000f0
+ #define ARM_CPU_PART_BRAHMA_B53		0x42001000
  
  /* DEC implemented cores */
  #define ARM_CPU_PART_SA1100		0x4400a110
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180523/54e23a7b/attachment.sig>
