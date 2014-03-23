From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Mar 2014 10:30:51 +1100
Subject: linux-next: manual merge of the samsung tree with the arm-soc tree
Message-ID: <20140324103051.59808436210b8b98f1bda0a1@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Today's linux-next merge of the samsung tree got a conflict in
arch/arm/Kconfig.debug between commit 886545ea7d0b ("ARM: efm32: allow
uncompress debug output") from the arm-soc tree and commit 90266754801c
("ARM: SAMSUNG: use generic uncompress.h") from the samsung tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/Kconfig.debug
index e5a00d421cc4,a160744312ab..000000000000
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@@ -1167,7 -1162,7 +1167,7 @@@ config DEBUG_UNCOMPRES
  config UNCOMPRESS_INCLUDE
  	string
  	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
- 					ARCH_EXYNOS || ARCH_EFM32
 -					PLAT_SAMSUNG
++					PLAT_SAMSUNG || ARCH_EFM32
  	default "mach/uncompress.h"
  
  config EARLY_PRINTK
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140324/82f5141f/attachment-0001.sig>
