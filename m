From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 6 Jan 2017 03:41:45 +0800
Subject: [arm:clearfog 21/65] drivers/net/phy/micrel.c:969:2: warning:
 initialization from incompatible pointer type
Message-ID: <201701060343.pGxeXjPX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git clearfog
head:   a0b3b7ea35687eaa7b1836bcdbbe10daf034c621
commit: adb3f9b9239ac1d683db5f1e0ac9435966d02b3d [21/65] net: phy: convert micrel to new read_mmd/write_mmd driver methods
config: openrisc-or1ksim_defconfig (attached as .config)
compiler: or32-linux-gcc (GCC) 4.5.1-or32-1.0rc1
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout adb3f9b9239ac1d683db5f1e0ac9435966d02b3d
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All warnings (new ones prefixed by >>):

>> drivers/net/phy/micrel.c:969:2: warning: initialization from incompatible pointer type

vim +969 drivers/net/phy/micrel.c

   953		.phy_id_mask	= 0x000ffffe,
   954		.name		= "Micrel KSZ9021 Gigabit PHY",
   955		.features	= (PHY_GBIT_FEATURES | SUPPORTED_Pause),
   956		.flags		= PHY_HAS_MAGICANEG | PHY_HAS_INTERRUPT,
   957		.driver_data	= &ksz9021_type,
   958		.config_init	= ksz9021_config_init,
   959		.config_aneg	= genphy_config_aneg,
   960		.read_status	= genphy_read_status,
   961		.ack_interrupt	= kszphy_ack_interrupt,
   962		.config_intr	= kszphy_config_intr,
   963		.get_sset_count = kszphy_get_sset_count,
   964		.get_strings	= kszphy_get_strings,
   965		.get_stats	= kszphy_get_stats,
   966		.suspend	= genphy_suspend,
   967		.resume		= genphy_resume,
   968		.read_mmd	= ksz9021_rd_mmd_phyreg,
 > 969		.write_mmd	= ksz9021_wr_mmd_phyreg,
   970	}, {
   971		.phy_id		= PHY_ID_KSZ9031,
   972		.phy_id_mask	= MICREL_PHY_ID_MASK,
   973		.name		= "Micrel KSZ9031 Gigabit PHY",
   974		.features	= (PHY_GBIT_FEATURES | SUPPORTED_Pause),
   975		.flags		= PHY_HAS_MAGICANEG | PHY_HAS_INTERRUPT,
   976		.driver_data	= &ksz9021_type,
   977		.config_init	= ksz9031_config_init,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 7274 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170106/58dd2493/attachment.gz>
