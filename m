From: lkp@intel.com (kbuild test robot)
Date: Mon, 9 Jan 2017 23:11:10 +0800
Subject: [PATCH v2 2/4] dmaengine: Forward slave device pointer to
 of_xlate callback
In-Reply-To: <1483970598-6191-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201701092339.Or2Yo06w%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

[auto build test ERROR on next-20170106]
[also build test ERROR on v4.10-rc3]
[cannot apply to linus/master linux/master xlnx/master v4.9-rc8 v4.9-rc7 v4.9-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Marek-Szyprowski/dmaengine-pl330-remove-pdata-based-initialization/20170109-224452
config: i386-randconfig-x001-201702 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/dma/dw/platform.c: In function 'dw_dma_of_xlate':
>> drivers/dma/dw/platform.c:35:22: error: 'slave' redeclared as different kind of symbol
     struct dw_dma_slave slave = {
                         ^~~~~
   drivers/dma/dw/platform.c:32:47: note: previous definition of 'slave' was here
             struct of_dma *ofdma, struct device *slave)
                                                  ^~~~~

vim +/slave +35 drivers/dma/dw/platform.c

a104a45ba7 Andy Shevchenko  2015-03-09  29  #define DRV_NAME	"dw_dmac"
a104a45ba7 Andy Shevchenko  2015-03-09  30  
9cade1a46c Andy Shevchenko  2013-06-05  31  static struct dma_chan *dw_dma_of_xlate(struct of_phandle_args *dma_spec,
7b7c0c79d7 Marek Szyprowski 2017-01-09  32  				     struct of_dma *ofdma, struct device *slave)
9cade1a46c Andy Shevchenko  2013-06-05  33  {
9cade1a46c Andy Shevchenko  2013-06-05  34  	struct dw_dma *dw = ofdma->of_dma_data;
4d130de20c Andy Shevchenko  2014-08-19 @35  	struct dw_dma_slave slave = {
4d130de20c Andy Shevchenko  2014-08-19  36  		.dma_dev = dw->dma.dev,
9cade1a46c Andy Shevchenko  2013-06-05  37  	};
9cade1a46c Andy Shevchenko  2013-06-05  38  	dma_cap_mask_t cap;

:::::: The code at line 35 was first introduced by commit
:::::: 4d130de20c3f39fc1a1aecd3969b50d49ff2e358 dmaengine: dw: introduce generic filter function

:::::: TO: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
:::::: CC: Vinod Koul <vinod.koul@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28695 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170109/ddcca592/attachment-0001.gz>
