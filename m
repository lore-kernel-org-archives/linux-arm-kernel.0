From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 16 Dec 2017 06:38:55 +0800
Subject: [arm:phy 46/61] drivers/net//ethernet/marvell/mvneta.c:3425:12:
 error: too few arguments to function 'phylink_of_phy_connect'
Message-ID: <201712160648.ksSLnc1o%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git phy
head:   ed4a36b32c63ac8a795692a49f5df6471cbf3793
commit: 3d2e7b55772fe50d021ba4af7fb487ef57c41bd9 [46/61] net: mvneta: convert to phylink
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        git checkout 3d2e7b55772fe50d021ba4af7fb487ef57c41bd9
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net//ethernet/marvell/mvneta.c: In function 'mvneta_mdio_probe':
>> drivers/net//ethernet/marvell/mvneta.c:3425:12: error: too few arguments to function 'phylink_of_phy_connect'
     int err = phylink_of_phy_connect(pp->phylink, pp->dn);
               ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net//ethernet/marvell/mvneta.c:31:0:
   include/linux/phylink.h:191:5: note: declared here
    int phylink_of_phy_connect(struct phylink *, struct device_node *, u32 flags);
        ^~~~~~~~~~~~~~~~~~~~~~

sparse warnings: (new ones prefixed by >>)


vim +/phylink_of_phy_connect +3425 drivers/net//ethernet/marvell/mvneta.c

  3421	
  3422	static int mvneta_mdio_probe(struct mvneta_port *pp)
  3423	{
  3424		struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
> 3425		int err = phylink_of_phy_connect(pp->phylink, pp->dn);
  3426	
  3427		if (err)
  3428			netdev_err(pp->dev, "could not attach PHY: %d\n", err);
  3429	
  3430		phylink_ethtool_get_wol(pp->phylink, &wol);
  3431		device_set_wakeup_capable(&pp->dev->dev, !!wol.supported);
  3432	
  3433		return err;
  3434	}
  3435	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62411 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171216/fe29fcd1/attachment-0001.gz>
