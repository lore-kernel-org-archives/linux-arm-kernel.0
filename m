From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 3 Mar 2014 19:01:52 +1100
Subject: linux-next: manual merge of the akpm-current tree with the arm-soc
 tree
Message-ID: <20140303190152.8b87330c0d83679b10c5ca5a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Today's linux-next merge of the akpm-current tree got a conflict in
arch/arm/mach-vexpress/Kconfig between commit 9352b05b6e4e ("ARM: select
MIGHT_HAVE_CACHE_L2X0 for V6 and V7 multi-platform") from the arm-soc
tree and commit b096b0b50c4b ("Kconfig: rename HAS_IOPORT to
HAS_IOPORT_MAP") from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-vexpress/Kconfig
index 80b4be36f10a,02930d69f381..000000000000
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@@ -9,8 -10,12 +9,8 @@@ config ARCH_VEXPRES
  	select HAVE_ARM_SCU if SMP
  	select HAVE_ARM_TWD if SMP
  	select HAVE_PATA_PLATFORM
 -	select HAVE_SMP
  	select ICST
- 	select NO_IOPORT
 -	select MIGHT_HAVE_CACHE_L2X0
+ 	select NO_IOPORT_MAP
  	select PLAT_VERSATILE
  	select PLAT_VERSATILE_CLCD
  	select POWER_RESET
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/97523e28/attachment.sig>
