From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 20 Oct 2016 07:55:35 +0800
Subject: [arm:clearfog 10/32] drivers/net/ethernet/marvell/mvneta.c:2605:21:
 warning: unused variable 'ndev'
Message-ID: <201610200717.wBMPVYbF%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git clearfog
head:   6c46cbe69a0e915b481458bef1e1e0ab16a7ac0e
commit: e7c1c68827d53e418cad15f86042b5661819152f [10/32] net: mvneta: convert to phylink
config: arm-allyesconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout e7c1c68827d53e418cad15f86042b5661819152f
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/marvell/mvneta.c: In function 'mvneta_poll':
>> drivers/net/ethernet/marvell/mvneta.c:2605:21: warning: unused variable 'ndev' [-Wunused-variable]
     struct net_device *ndev = pp->dev;
                        ^~~~
   drivers/net/ethernet/marvell/mvneta.c: In function 'mvneta_start_dev':
   drivers/net/ethernet/marvell/mvneta.c:2917:21: warning: unused variable 'ndev' [-Wunused-variable]
     struct net_device *ndev = pp->dev;
                        ^~~~
   drivers/net/ethernet/marvell/mvneta.c: In function 'mvneta_stop_dev':
   drivers/net/ethernet/marvell/mvneta.c:2947:21: warning: unused variable 'ndev' [-Wunused-variable]
     struct net_device *ndev = pp->dev;
                        ^~~~
   drivers/net/ethernet/marvell/mvneta.c: At top level:
   drivers/net/ethernet/marvell/mvneta.c:3311:17: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .mac_link_up = mvneta_mac_link_up,
                    ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/mvneta.c:3311:17: note: (near initialization for 'mvneta_phylink_ops.mac_link_up')
   drivers/net/ethernet/marvell/mvneta.c: In function 'mvneta_mdio_remove':
   drivers/net/ethernet/marvell/mvneta.c:3325:21: warning: unused variable 'ndev' [-Wunused-variable]
     struct net_device *ndev = pp->dev;
                        ^~~~
   cc1: some warnings being treated as errors

vim +/ndev +2605 drivers/net/ethernet/marvell/mvneta.c

e7c1c688 Russell King     2015-09-16  2589  	phylink_mac_change(pp->phylink, !!(gmac_stat & MVNETA_GMAC_LINK_UP));
898b2970 Stas Sergeev     2015-04-01  2590  }
898b2970 Stas Sergeev     2015-04-01  2591  
c5aff182 Thomas Petazzoni 2012-08-17  2592  /* NAPI handler
c5aff182 Thomas Petazzoni 2012-08-17  2593   * Bits 0 - 7 of the causeRxTx register indicate that are transmitted
c5aff182 Thomas Petazzoni 2012-08-17  2594   * packets on the corresponding TXQ (Bit 0 is for TX queue 1).
c5aff182 Thomas Petazzoni 2012-08-17  2595   * Bits 8 -15 of the cause Rx Tx register indicate that are received
c5aff182 Thomas Petazzoni 2012-08-17  2596   * packets on the corresponding RXQ (Bit 8 is for RX queue 0).
c5aff182 Thomas Petazzoni 2012-08-17  2597   * Each CPU has its own causeRxTx register
c5aff182 Thomas Petazzoni 2012-08-17  2598   */
c5aff182 Thomas Petazzoni 2012-08-17  2599  static int mvneta_poll(struct napi_struct *napi, int budget)
c5aff182 Thomas Petazzoni 2012-08-17  2600  {
c5aff182 Thomas Petazzoni 2012-08-17  2601  	int rx_done = 0;
c5aff182 Thomas Petazzoni 2012-08-17  2602  	u32 cause_rx_tx;
2dcf75e2 Gregory CLEMENT  2015-12-09  2603  	int rx_queue;
c5aff182 Thomas Petazzoni 2012-08-17  2604  	struct mvneta_port *pp = netdev_priv(napi->dev);
c6c022e3 Philippe Reynes  2016-07-30 @2605  	struct net_device *ndev = pp->dev;
12bb03b4 Maxime Ripard    2015-09-25  2606  	struct mvneta_pcpu_port *port = this_cpu_ptr(pp->ports);
c5aff182 Thomas Petazzoni 2012-08-17  2607  
c5aff182 Thomas Petazzoni 2012-08-17  2608  	if (!netif_running(pp->dev)) {
12bb03b4 Maxime Ripard    2015-09-25  2609  		napi_complete(&port->napi);
c5aff182 Thomas Petazzoni 2012-08-17  2610  		return rx_done;
c5aff182 Thomas Petazzoni 2012-08-17  2611  	}
c5aff182 Thomas Petazzoni 2012-08-17  2612  
c5aff182 Thomas Petazzoni 2012-08-17  2613  	/* Read cause register */

:::::: The code at line 2605 was first introduced by commit
:::::: c6c022e3602a8165ead71d60ac7ac22e07c81d37 net: ethernet: marvell: mvneta: use phydev from struct net_device

:::::: TO: Philippe Reynes <tremyfr@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 58866 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161020/71ffe868/attachment-0001.gz>
