From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 3 Mar 2014 18:56:57 +1100
Subject: linux-next: manual merge of the akpm-current tree with the arm-soc
 tree
Message-ID: <20140303185657.64cf0ef850f86ec92ffd240d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Today's linux-next merge of the akpm-current tree got a conflict in
arch/arm/mach-picoxcell/Kconfig between commit ddb902cc3459 ("ARM:
centralize common multi-platform kconfig options") from the arm-soc tree
and commit b096b0b50c4b ("Kconfig: rename HAS_IOPORT to HAS_IOPORT_MAP")
from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-picoxcell/Kconfig
index eca9eb1c5931,c03cd6ffb429..000000000000
--- a/arch/arm/mach-picoxcell/Kconfig
+++ b/arch/arm/mach-picoxcell/Kconfig
@@@ -1,7 -1,12 +1,7 @@@
  config ARCH_PICOXCELL
  	bool "Picochip PicoXcell" if ARCH_MULTI_V6
  	select ARCH_REQUIRE_GPIOLIB
 -	select ARM_PATCH_PHYS_VIRT
  	select ARM_VIC
 -	select CPU_V6K
  	select DW_APB_TIMER_OF
 -	select GENERIC_CLOCKEVENTS
  	select HAVE_TCM
- 	select NO_IOPORT
+ 	select NO_IOPORT_MAP
 -	select SPARSE_IRQ
 -	select USE_OF
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/9de9a25f/attachment.sig>
