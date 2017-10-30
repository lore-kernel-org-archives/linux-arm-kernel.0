From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 Oct 2017 12:22:00 +0000
Subject: linux-next: manual merge of the sunxi tree with the arm-soc tree
Message-ID: <20171030122200.z5sj2riar4vfoiwo@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the sunxi tree got a conflict in:

   arch/arm/boot/dts/sunxi-h3-h5.dtsi
   arch/arm/boot/dts/sun7i-a20.dtsi
   arch/arm/boot/dts/sun6i-a31.dtsi
   arch/arm/boot/dts/sun4i-a10.dtsi

between commit:

   8dccafaa281aa1 ("arm: dts: fix unit-address leading 0s")

from the arm-soc tree and various commits from the sunxi tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/arm/boot/dts/sun4i-a10.dtsi
index b9b138a36686,b91300d49a31..000000000000
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
diff --cc arch/arm/boot/dts/sun6i-a31.dtsi
index ca46bd223ebb,8bfa12b548e0..000000000000
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
diff --cc arch/arm/boot/dts/sun7i-a20.dtsi
index 08bea4f5616d,228c368537a0..000000000000
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
diff --cc arch/arm/boot/dts/sunxi-h3-h5.dtsi
index f2dcf97a0d08,d7a71e726a9f..000000000000
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171030/24cfadb6/attachment.sig>
