From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 Oct 2017 18:15:51 +0000
Subject: linux-next: manual merge of the spi-nor tree with the imx-mxs tree
Message-ID: <20171030181551.skcvt4mr4br7rtn2@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cyrille,

Today's linux-next merge of the spi-nor tree got a conflict in:

  Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt

between commit:

  b07815d4eaf65 ("dt-bindings: mtd: add sst25wf040b and en25s64 to sip-nor list")

from the imx-mxs tree and commit:

   282e45dc64d1 ("mtd: spi-nor: Add support for mr25h128")

from the spi-nor tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
index 4cab5d85cf6f,956bb046e599..000000000000
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
@@@ -13,7 -13,7 +13,8 @@@ Required properties
                   at25df321a
                   at25df641
                   at26df081a
 +                 en25s64
+                  mr25h128
                   mr25h256
                   mr25h10
                   mr25h40
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171030/7ca0a49b/attachment-0001.sig>
