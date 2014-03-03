From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 3 Mar 2014 18:59:40 +1100
Subject: linux-next: manual merge of the akpm-current tree with the arm-soc
 tree
Message-ID: <20140303185940.a4fd9da2d758967f3bc52a09@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Today's linux-next merge of the akpm-current tree got a conflict in
arch/arm/mach-prima2/Kconfig between commit 9352b05b6e4e ("ARM: select
MIGHT_HAVE_CACHE_L2X0 for V6 and V7 multi-platform") from the arm-soc
tree and commit b096b0b50c4b ("Kconfig: rename HAS_IOPORT to
HAS_IOPORT_MAP") from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-prima2/Kconfig
index 2c726b4f9356,850ff5500821..000000000000
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@@ -1,8 -1,10 +1,8 @@@
  config ARCH_SIRF
  	bool "CSR SiRF" if ARCH_MULTI_V7
  	select ARCH_REQUIRE_GPIOLIB
 -	select GENERIC_CLOCKEVENTS
  	select GENERIC_IRQ_CHIP
- 	select NO_IOPORT
 -	select MIGHT_HAVE_CACHE_L2X0
+ 	select NO_IOPORT_MAP
  	select PINCTRL
  	select PINCTRL_SIRF
  	help
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/ac7c85d0/attachment.sig>
