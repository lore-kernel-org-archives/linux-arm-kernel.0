From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 23 Jun 2014 10:57:41 +1000
Subject: linux-next: manual merge of the mvebu tree with Linus' tree
Message-ID: <20140623105741.70094961@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the mvebu tree got a conflict in
arch/arm/mach-mvebu/Kconfig between commit 21278aeafbfa ("ARM: use
menuconfig for sub-arch menus") from Linus' tree and commit
55fc83023212 ("ARM: Kirkwood: Add setup file for netxbig LEDs") from
the mvebu tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-mvebu/Kconfig
index 4a7c250c9a30,8e3b5f12cd7c..000000000000
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@@ -94,4 -99,13 +96,11 @@@ config MACH_KIRKWOO
  	  Say 'Y' here if you want your kernel to support boards based
  	  on the Marvell Kirkwood device tree.
  
+ config MACH_NETXBIG
+ 	bool "LaCie 2Big and 5Big Network v2"
+ 	depends on MACH_KIRKWOOD
+ 	help
+ 	  Say 'Y' here if you want your kernel to support the
+ 	  LaCie 2Big and 5Big Network v2
+ 
 -endmenu
 -
  endif
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140623/cd9098b3/attachment.sig>
