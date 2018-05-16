From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 17 May 2018 08:57:28 +1000
Subject: linux-next: manual merge of the renesas tree with the mvebu tree
Message-ID: <20180517085728.680dd1bd@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the renesas tree got a conflict in:

  arch/arm/configs/multi_v7_defconfig

between commit:

  873edb2930ef ("ARM: multi_v7_defconfig: Update with current configuration")

from the mvebu tree and commits:

  57eec170e954 ("ARM: multi_v7_defconfig: Disable CONFIG_FB_SH_MOBILE_MERAM")
  eedd7902366b ("ARM: multi_v7_defconfig: Enable RENESAS_WDT")

from the renesas tree.

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
index 8bcf3be58047,374a40945b0f..000000000000
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@@ -463,23 -489,20 +464,24 @@@ CONFIG_XILINX_WATCHDOG=
  CONFIG_ARM_SP805_WATCHDOG=y
  CONFIG_AT91SAM9X_WATCHDOG=y
  CONFIG_SAMA5D4_WATCHDOG=y
 +CONFIG_DW_WATCHDOG=y
 +CONFIG_DAVINCI_WATCHDOG=m
  CONFIG_ORION_WATCHDOG=y
  CONFIG_RN5T618_WATCHDOG=y
 -CONFIG_ST_LPC_WATCHDOG=y
  CONFIG_SUNXI_WATCHDOG=y
  CONFIG_IMX2_WDT=y
 +CONFIG_ST_LPC_WATCHDOG=y
  CONFIG_TEGRA_WATCHDOG=m
  CONFIG_MESON_WATCHDOG=y
 -CONFIG_DW_WATCHDOG=y
  CONFIG_DIGICOLOR_WATCHDOG=y
+ CONFIG_RENESAS_WDT=m
 -CONFIG_BCM2835_WDT=y
  CONFIG_BCM47XX_WDT=y
 -CONFIG_BCM7038_WDT=m
 +CONFIG_BCM2835_WDT=y
  CONFIG_BCM_KONA_WDT=y
 +CONFIG_BCM7038_WDT=m
 +CONFIG_BCMA_HOST_SOC=y
 +CONFIG_BCMA_DRIVER_GMAC_CMN=y
 +CONFIG_BCMA_DRIVER_GPIO=y
  CONFIG_MFD_ACT8945A=y
  CONFIG_MFD_AS3711=y
  CONFIG_MFD_AS3722=y
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180517/3abedbbc/attachment.sig>
