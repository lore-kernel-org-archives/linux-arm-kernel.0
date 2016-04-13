From: lkp@intel.com (kbuild test robot)
Date: Wed, 13 Apr 2016 14:07:46 +0800
Subject: [PATCH v5 2/2] dmaengine: Add Xilinx zynqmp dma engine driver
 support
In-Reply-To: <1460524609-8722-2-git-send-email-appanad@xilinx.com>
Message-ID: <201604131449.w6WNkVob%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kedareswara,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.6-rc3 next-20160412]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Kedareswara-rao-Appana/Documentation-DT-dma-Add-Xilinx-zynqmp-dma-device-tree-binding-documentation/20160413-132011
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: i386-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/dma/xilinx/zynqmp_dma.c: In function 'zynqmp_dma_reset':
>> drivers/dma/xilinx/zynqmp_dma.c:753:30: error: 'dchan' undeclared (first use in this function)
     zynqmp_dma_free_descriptors(dchan);
                                 ^
   drivers/dma/xilinx/zynqmp_dma.c:753:30: note: each undeclared identifier is reported only once for each function it appears in

vim +/dchan +753 drivers/dma/xilinx/zynqmp_dma.c

   747	static void zynqmp_dma_reset(struct zynqmp_dma_chan *chan)
   748	{
   749		writel(ZYNQMP_DMA_IDS_DEFAULT_MASK, chan->regs + ZYNQMP_DMA_IDS);
   750	
   751		zynqmp_dma_complete_descriptor(chan);
   752		zynqmp_dma_chan_desc_cleanup(chan);
 > 753		zynqmp_dma_free_descriptors(dchan);
   754		zynqmp_dma_init(chan);
   755	}
   756	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 54421 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160413/1223fc7e/attachment-0001.obj>
