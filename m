From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 8 Oct 2018 13:32:40 +1100
Subject: linux-next: manual merge of the tip tree with the arm-soc tree
Message-ID: <20181008133158.773196b8@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  MAINTAINERS

between commits:

  81aa283c6924 ("MAINTAINERS: Add Actions Semi S900 clk entries")
  677309b0e9e6 ("MAINTAINERS: Add entry for Actions Semi Owl SoCs DMA driver")

from the arm-soc tree and commit:

  9d8d47ea6ec6 ("clocksource/drivers: Unify the names to timer-* format")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index c4d323faa764,2a83f2339651..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -1218,10 -1180,7 +1218,10 @@@ N:	ow
  F:	arch/arm/mach-actions/
  F:	arch/arm/boot/dts/owl-*
  F:	arch/arm64/boot/dts/actions/
 +F:	drivers/clk/actions/
- F:	drivers/clocksource/owl-*
+ F:	drivers/clocksource/timer-owl*
 +F:	drivers/dma/owl-dma.c
 +F:	drivers/i2c/busses/i2c-owl.c
  F:	drivers/pinctrl/actions/*
  F:	drivers/soc/actions/
  F:	include/dt-bindings/power/owl-*
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181008/5c90f9a5/attachment-0001.sig>
