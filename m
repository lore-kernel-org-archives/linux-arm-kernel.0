From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 16 Oct 2016 12:22:44 +0800
Subject: [arm-soc:to-build 23/23]
 drivers/net/ethernet/broadcom/bcm63xx_enet.c:1129:2: warning: 'phydev' may
 be used uninitialized in this function
Message-ID: <201610161237.XbpVNEgU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git to-build
head:   0f460ef4d0b0e50f64b03962048dec6fa1d40d20
commit: 0f460ef4d0b0e50f64b03962048dec6fa1d40d20 [23/23] Revert "Disable "maybe-uninitialized" warning globally"
config: mips-bcm63xx_defconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 0f460ef4d0b0e50f64b03962048dec6fa1d40d20
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/broadcom/bcm63xx_enet.c: In function 'bcm_enet_open':
>> drivers/net/ethernet/broadcom/bcm63xx_enet.c:1129:2: warning: 'phydev' may be used uninitialized in this function [-Wmaybe-uninitialized]
     phy_disconnect(phydev);
     ^~~~~~~~~~~~~~~~~~~~~~

vim +/phydev +1129 drivers/net/ethernet/broadcom/bcm63xx_enet.c

9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1113  			  priv->tx_desc_cpu, priv->tx_desc_dma);
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1114  
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1115  out_free_rx_ring:
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1116  	dma_free_coherent(kdev, priv->rx_desc_alloc_size,
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1117  			  priv->rx_desc_cpu, priv->rx_desc_dma);
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1118  
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1119  out_freeirq_tx:
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1120  	free_irq(priv->irq_tx, dev);
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1121  
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1122  out_freeirq_rx:
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1123  	free_irq(priv->irq_rx, dev);
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1124  
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1125  out_freeirq:
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1126  	free_irq(dev->irq, dev);
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1127  
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1128  out_phy_disconnect:
625eb866 drivers/net/ethernet/broadcom/bcm63xx_enet.c Philippe Reynes 2016-09-18 @1129  	phy_disconnect(phydev);
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1130  
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1131  	return ret;
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1132  }
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1133  
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1134  /*
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1135   * disable mac
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1136   */
9b1fc55a drivers/net/bcm63xx_enet.c                   Maxime Bizon    2009-08-18  1137  static void bcm_enet_disable_mac(struct bcm_enet_priv *priv)

:::::: The code at line 1129 was first introduced by commit
:::::: 625eb8667d6fcb22e474502133986b2d2838917d net: ethernet: broadcom: bcm63xx: use phydev from struct net_device

:::::: TO: Philippe Reynes <tremyfr@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 11955 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161016/d9375f3f/attachment.gz>
