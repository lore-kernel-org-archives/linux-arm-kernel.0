From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 9 Apr 2017 07:54:48 +0800
Subject: [arm:phy 18/50] drivers/net//phy/marvell10g.c:67:27: error:
 'PHY_INTERFACE_MODE_XAUI' undeclared
Message-ID: <201704090743.byvLHuM2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git phy
head:   2a416f7ccadf42117c5e02bb77c4af72197771c8
commit: bf9689f7fa0c6be6afd87735fb4e5f0a2f7812fd [18/50] net: phy: add Marvell Alaska X 88X3310 10Gigabit PHY support
config: x86_64-kexec (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout bf9689f7fa0c6be6afd87735fb4e5f0a2f7812fd
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net//phy/marvell10g.c: In function 'mv3310_config_init':
>> drivers/net//phy/marvell10g.c:67:27: error: 'PHY_INTERFACE_MODE_XAUI' undeclared (first use in this function)
         phydev->interface != PHY_INTERFACE_MODE_XAUI &&
                              ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/net//phy/marvell10g.c:67:27: note: each undeclared identifier is reported only once for each function it appears in

vim +/PHY_INTERFACE_MODE_XAUI +67 drivers/net//phy/marvell10g.c

    61		u32 mask;
    62		int val;
    63	
    64		/* Check that the PHY interface type is compatible */
    65		if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
    66		    phydev->interface != PHY_INTERFACE_MODE_XGMII &&
  > 67		    phydev->interface != PHY_INTERFACE_MODE_XAUI &&
    68		    phydev->interface != PHY_INTERFACE_MODE_RXAUI &&
    69		    phydev->interface != PHY_INTERFACE_MODE_10GKR)
    70			return -ENODEV;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 25141 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170409/fb36ec68/attachment-0001.gz>
