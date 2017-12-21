From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 22 Dec 2017 08:29:16 +1100
Subject: linux-next: manual merge of the aspeed tree with the arm-soc tree
Message-ID: <20171222082916.35bceb49@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joel,

Today's linux-next merge of the aspeed tree got conflicts in:

  arch/arm/boot/dts/Makefile
  arch/arm/boot/dts/aspeed-g4.dtsi

between commits:

  d2271826e58b ("ARM: dts: aspeed-g4: Correct VUART IRQ number")
  ea04d6b456b2 ("ARM: make ARCH_S3C24XX select USE_OF and clean-up boot/dts/Makefile")

from the arm-soc tree and commits:

  bb8155ada490 ("ARM: dts: aspeed: Add proper clock references")
  8b42ae23ee0a ("ARM: dts: aspeed: Sort ASPEED entries in makefile")
  2e3de60a1034 ("ARM: dts: aspeed: Add Witherspoon BMC machine")
  46d83989fde3 ("ARM: dts: aspeed: Add Ingrasys Zaius BMC machine")
  f88bc8e15f1c ("ARM: dts: aspeed: Add Qanta Q71L BMC machine")

from the aspeed tree.

I fixed it up (see below (the dtsi file has a common patch part between
d2271826e58b and bb8155ada490) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your
tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm/boot/dts/Makefile
index 032138d9c60b,5ab5d9169511..000000000000
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@@ -1102,6 -1101,11 +1102,10 @@@ dtb-$(CONFIG_ARCH_MEDIATEK) += 
  	mt8127-moose.dtb \
  	mt8135-evbp1.dtb
  dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
- dtb-$(CONFIG_ARCH_ASPEED) += aspeed-bmc-opp-palmetto.dtb \
+ dtb-$(CONFIG_ARCH_ASPEED) += \
+ 	aspeed-ast2500-evb.dtb \
+ 	aspeed-bmc-opp-palmetto.dtb \
  	aspeed-bmc-opp-romulus.dtb \
- 	aspeed-ast2500-evb.dtb
+ 	aspeed-bmc-opp-witherspoon.dtb \
+ 	aspeed-bmc-opp-zaius.dtb \
+ 	aspeed-bmc-quanta-q71l.dtb
 -endif
