From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 14 Apr 2016 09:29:20 +1000
Subject: linux-next: manual merge of the mvebu tree with the arm-soc tree
Message-ID: <20160414092920.41fb4ebe@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the mvebu tree got a conflict in:

  arch/arm/configs/multi_v7_defconfig

between commit:

  6d54fb8a08a7 ("ARM: multi_v7_defconfig: Enable ST's HW Random Number Generator")

from the arm-soc tree and commit:

  fe767240934f ("ARM: configs: Enabling the new Marvell's cryptographic engine driver for multi_v7_defconfig")

from the mvebu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm/configs/multi_v7_defconfig
index 811b41823baa,392e970b60c7..000000000000
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@@ -837,8 -829,7 +837,9 @@@ CONFIG_LOCKUP_DETECTOR=
  CONFIG_CRYPTO_DEV_TEGRA_AES=y
  CONFIG_CPUFREQ_DT=y
  CONFIG_KEYSTONE_IRQ=y
 +CONFIG_HW_RANDOM=y
 +CONFIG_HW_RANDOM_ST=y
+ CONFIG_CRYPTO_DEV_MARVELL_CESA=m
  CONFIG_CRYPTO_DEV_SUN4I_SS=m
  CONFIG_CRYPTO_DEV_ROCKCHIP=m
  CONFIG_ARM_CRYPTO=y
