From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 1 Jul 2017 20:12:54 +0800
Subject: [xlnx:master 585/710]
 drivers/net/ethernet/xilinx/xilinx_axienet.h:675:9: error: implicit
 declaration of function 'in_be32'
Message-ID: <201707012047.r8SlIyQ4%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   ae4bbf82f4b9fdfc85b3fd112696e8bbefff07f2
commit: 87223be758604b2eee18af6546cb695a2a846723 [585/710] drivers: net: ethernet: TSN: Kconfig and Makefile
config: mips-allyesconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 87223be758604b2eee18af6546cb695a2a846723
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/xilinx/xilinx_tsn_switch.h:21:0,
                    from drivers/net/ethernet/xilinx/xilinx_tsn_qci.c:18:
   drivers/net/ethernet/xilinx/xilinx_axienet.h: In function 'axienet_ior':
>> drivers/net/ethernet/xilinx/xilinx_axienet.h:675:9: error: implicit declaration of function 'in_be32' [-Werror=implicit-function-declaration]
     return in_be32(lp->regs + offset);
            ^~~~~~~
   drivers/net/ethernet/xilinx/xilinx_axienet.h: In function 'axienet_iow':
>> drivers/net/ethernet/xilinx/xilinx_axienet.h:690:2: error: implicit declaration of function 'out_be32' [-Werror=implicit-function-declaration]
     out_be32((lp->regs + offset), value);
     ^~~~~~~~
   cc1: some warnings being treated as errors

vim +/in_be32 +675 drivers/net/ethernet/xilinx/xilinx_axienet.h

f03af9e4 Michal Simek              2015-05-07  669   * Return: The contents of the Axi Ethernet register
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  670   *
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  671   * This function returns the contents of the corresponding register.
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  672   */
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  673  static inline u32 axienet_ior(struct axienet_local *lp, off_t offset)
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  674  {
8a3b7a25 danborkmann at iogearbox.net 2012-01-19 @675  	return in_be32(lp->regs + offset);
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  676  }
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  677  
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  678  /**
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  679   * axienet_iow - Memory mapped Axi Ethernet register write
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  680   * @lp:         Pointer to axienet local structure
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  681   * @offset:     Address offset from the base address of Axi Ethernet core
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  682   * @value:      Value to be written into the Axi Ethernet register
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  683   *
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  684   * This function writes the desired value into the corresponding Axi Ethernet
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  685   * register.
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  686   */
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  687  static inline void axienet_iow(struct axienet_local *lp, off_t offset,
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  688  			       u32 value)
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  689  {
8a3b7a25 danborkmann at iogearbox.net 2012-01-19 @690  	out_be32((lp->regs + offset), value);
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  691  }
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  692  
c18bf66f Kedareswara rao Appana    2015-09-10  693  #ifdef CONFIG_XILINX_AXI_EMAC_HWTSTAMP

:::::: The code at line 675 was first introduced by commit
:::::: 8a3b7a252dca9fb28c23b5bf76c49180a2b60d3b drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver

:::::: TO: danborkmann at iogearbox.net <danborkmann@iogearbox.net>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 44219 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170701/9b065e7b/attachment-0001.gz>
