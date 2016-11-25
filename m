From: lkp@intel.com (kbuild test robot)
Date: Sat, 26 Nov 2016 07:04:08 +0800
Subject: [PATCH net-next 1/5] net: mvneta: Use cacheable memory to store
 the rx buffer virtual address
In-Reply-To: <7e6004f918d3fcde9ae71e7893d26b19086236a3.1480087510.git-series.gregory.clement@free-electrons.com>
Message-ID: <201611260742.netuJd5W%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

[auto build test ERROR on ]

url:    https://github.com/0day-ci/linux/commits/Gregory-CLEMENT/Support-Armada-37xx-SoC-ARMv8-64-bits-in-mvneta-driver/20161126-050621
base:    
config: parisc-allmodconfig (attached as .config)
compiler: hppa-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=parisc 

Note: the linux-review/Gregory-CLEMENT/Support-Armada-37xx-SoC-ARMv8-64-bits-in-mvneta-driver/20161126-050621 HEAD 5f44108a5c983ae4477f811485fdc4ee12294e72 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):


vim +2745 drivers/net/ethernet/marvell/mvneta.c

  2739					   DMA_FROM_DEVICE);
  2740		if (unlikely(dma_mapping_error(pp->dev->dev.parent, phys_addr))) {
  2741			mvneta_frag_free(pp->frag_size, data);
  2742			return -ENOMEM;
  2743		}
  2744	
> 2745		phys_addr += pp->rx_offset_correction;
  2746		rx_desc->buf_phys_addr = phys_addr;
  2747		rx_desc->buf_cookie = (uintptr_t)data;
  2748	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 47218 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161126/8b9e6423/attachment-0001.gz>
