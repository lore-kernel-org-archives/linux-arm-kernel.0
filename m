From: lkp@intel.com (kbuild test robot)
Date: Thu, 11 Feb 2016 18:36:02 +0800
Subject: [PATCH] dmaengine: edma: Implement device_synchronize callback
In-Reply-To: <1455180872-2620-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <201602111850.mRht8PrT%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

[auto build test ERROR on slave-dma/next]
[also build test ERROR on v4.5-rc3 next-20160211]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Ujfalusi/dmaengine-edma-Implement-device_synchronize-callback/20160211-170011
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git next
config: arm-multi_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/dma/edma.c: In function 'edma_synchronize':
>> drivers/dma/edma.c:874:41: error: 'chan' undeclared (first use in this function)
     struct edma_chan *echan = to_edma_chan(chan);
                                            ^
   drivers/dma/edma.c:874:41: note: each undeclared identifier is reported only once for each function it appears in

vim +/chan +874 drivers/dma/edma.c

   868	
   869		return 0;
   870	}
   871	
   872	static void edma_synchronize(struct dma_chan *c)
   873	{
 > 874		struct edma_chan *echan = to_edma_chan(chan);
   875	
   876		vchan_synchronize(&echan->vchan);
   877	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 36561 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160211/f59a88ae/attachment-0001.obj>
