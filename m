From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 25 Mar 2014 10:55:01 +1100
Subject: linux-next: manual merge of the keystone tree with the arm-soc tree
Message-ID: <20140325105501.e63fcdd78d0d604b4e5309a1@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

Today's linux-next merge of the keystone tree got a conflict in
arch/arm/boot/dts/Makefile between commit ba5a37e52194 ("ARM: mvebu: Move
kirkwood DT boards into mach-mvebu") from the arm-soc tree and commit
400550ae7e77 ("ARM: dts: Build all keystone dt blobs") from the keystone
tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/Makefile
index 94939ee0c10b,49ff796dc02e..000000000000
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@@ -82,9 -81,11 +82,12 @@@ dtb-$(CONFIG_ARCH_HIGHBANK) += highbank
  	ecx-2000.dtb
  dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
  	integratorcp.dtb
+ dtb-$(CONFIG_ARCH_KEYSTONE) += k2hk-evm.dtb \
+ 	k2l-evm.dtb \
+ 	k2e-evm.dtb
 -dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
 -dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
 +kirkwood := \
 +	kirkwood-b3.dtb \
 +	kirkwood-cloudbox.dtb \
  	kirkwood-db-88f6281.dtb \
  	kirkwood-db-88f6282.dtb \
  	kirkwood-dns320.dtb \
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140325/43ee91e7/attachment.sig>
