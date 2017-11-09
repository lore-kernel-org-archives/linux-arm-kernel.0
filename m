From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 9 Nov 2017 13:21:43 +1100
Subject: linux-next: manual merge of the devicetree tree with the arm-soc tree
Message-ID: <20171109132143.3e59879d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Today's linux-next merge of the devicetree tree got a conflict in:

  arch/arm64/boot/dts/allwinner/Makefile

between commit:

  d7341305863b ("arm64: allwinner: h5: add NanoPi NEO Plus2 DT support")

from the arm-soc tree and commit:

  4408a86af32e ("kbuild: handle dtb-y and CONFIG_OF_ALL_DTBS natively in Makefile.lib")

from the devicetree tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm64/boot/dts/allwinner/Makefile
index 16fa7b9839e6,4dab590d24a5..000000000000
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@@ -9,8 -8,3 +9,4 @@@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-o
  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus2.dtb
  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo2.dtb
 +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo-plus2.dtb
- 
- always		:= $(dtb-y)
- subdir-y	:= $(dts-dirs)
- clean-files	:= *.dtb
