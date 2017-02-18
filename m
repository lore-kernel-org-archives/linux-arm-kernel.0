From: lkp@intel.com (kbuild test robot)
Date: Sat, 18 Feb 2017 18:41:28 +0800
Subject: [PATCH] soc: ti: knav_dma: Fix some error handling
In-Reply-To: <20170218080614.1828-1-christophe.jaillet@wanadoo.fr>
Message-ID: <201702181831.4ZhQbJQ0%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christophe,

[auto build test ERROR on v4.9-rc8]
[also build test ERROR on next-20170217]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Christophe-JAILLET/soc-ti-knav_dma-Fix-some-error-handling/20170218-164533
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/soc/ti/knav_dma.c: In function 'dma_init':
>> drivers/soc/ti/knav_dma.c:675:13: error: 'ma' undeclared (first use in this function)
     if (IS_ERR(ma->reg_rx_flow))
                ^~
   drivers/soc/ti/knav_dma.c:675:13: note: each undeclared identifier is reported only once for each function it appears in

vim +/ma +675 drivers/soc/ti/knav_dma.c

   669		dma->reg_tx_sched = pktdma_get_regs(dma, node, 3, &size);
   670		if (IS_ERR(dma->reg_tx_sched))
   671			return -ENODEV;
   672	
   673		max_tx_sched = size / sizeof(struct reg_tx_sched);
   674		dma->reg_rx_flow = pktdma_get_regs(dma, node, 4, &size);
 > 675		if (IS_ERR(ma->reg_rx_flow))
   676			return -ENODEV;
   677	
   678		max_rx_flow = size / sizeof(struct reg_rx_flow);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59436 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170218/bf40cc3c/attachment-0001.gz>
