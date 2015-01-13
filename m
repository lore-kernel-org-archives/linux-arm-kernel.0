From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 13 Jan 2015 11:20:16 +1100
Subject: linux-next: manual merge of the mvebu tree with the arm-soc tree
Message-ID: <20150113112016.2db3f982@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the mvebu tree got a conflict in
arch/arm/boot/dts/Makefile between commit 6f1650f15bc4 ("ARM: dts: Only
build dtb if associated Arch and/or SoC is enabled") from the arm-soc
tree and commit dd7d2be1d2b8 ("Kirkwood: add support for Seagate
BlackArmor NAS220") from the mvebu tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/Makefile
index abb810f1fe29,17ee1d6a0ac0..000000000000
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@@ -112,24 -101,18 +112,25 @@@ dtb-$(CONFIG_ARCH_EXYNOS5) += 
  	exynos5440-sd5v1.dtb \
  	exynos5440-ssdk5440.dtb \
  	exynos5800-peach-pi.dtb
 -dtb-$(CONFIG_ARCH_HI3xxx) += hi3620-hi4511.dtb
 -dtb-$(CONFIG_ARCH_HIX5HD2) += hisi-x5hd2-dkb.dtb
 -dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
 +dtb-$(CONFIG_ARCH_HI3xxx) += \
 +	hi3620-hi4511.dtb
 +dtb-$(CONFIG_ARCH_HIX5HD2) += \
 +	hisi-x5hd2-dkb.dtb
 +dtb-$(CONFIG_ARCH_HIGHBANK) += \
 +	highbank.dtb \
  	ecx-2000.dtb
 -dtb-$(CONFIG_ARCH_HIP04) += hip04-d01.dtb
 -dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
 +dtb-$(CONFIG_ARCH_HIP04) += \
 +	hip04-d01.dtb
 +dtb-$(CONFIG_ARCH_INTEGRATOR) += \
 +	integratorap.dtb \
  	integratorcp.dtb
 -dtb-$(CONFIG_ARCH_KEYSTONE) += k2hk-evm.dtb \
 +dtb-$(CONFIG_ARCH_KEYSTONE) += \
 +	k2hk-evm.dtb \
  	k2l-evm.dtb \
  	k2e-evm.dtb
 -dtb-$(CONFIG_MACH_KIRKWOOD) += kirkwood-b3.dtb \
 +dtb-$(CONFIG_MACH_KIRKWOOD) += \
 +	kirkwood-b3.dtb \
+ 	kirkwood-blackarmor-nas220.dtb \
  	kirkwood-cloudbox.dtb \
  	kirkwood-d2net.dtb \
  	kirkwood-db-88f6281.dtb \
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150113/9cd572c1/attachment.sig>
