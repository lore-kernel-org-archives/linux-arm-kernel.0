From: lkp@intel.com (kbuild test robot)
Date: Mon, 28 Nov 2016 18:16:04 +0800
Subject: [PATCH v3] clkdev: add devm_of_clk_get()
In-Reply-To: <87vav89chw.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <201611281832.klmeAity%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kuninori,

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.9-rc7 next-20161128]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Kuninori-Morimoto/clkdev-add-devm_of_clk_get/20161128-173723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: i386-randconfig-x004-201648 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> drivers/clk/clk-devres.c:57:13: error: redefinition of 'devm_of_clk_get'
    struct clk *devm_of_clk_get(struct device *dev,
                ^~~~~~~~~~~~~~~
   In file included from drivers/clk/clk-devres.c:7:0:
   include/linux/clk.h:518:27: note: previous definition of 'devm_of_clk_get' was here
    static inline struct clk *devm_of_clk_get(struct device *dev,
                              ^~~~~~~~~~~~~~~

vim +/devm_of_clk_get +57 drivers/clk/clk-devres.c

    51		ret = devres_release(dev, devm_clk_release, devm_clk_match, clk);
    52	
    53		WARN_ON(ret);
    54	}
    55	EXPORT_SYMBOL(devm_clk_put);
    56	
  > 57	struct clk *devm_of_clk_get(struct device *dev,
    58				    struct device_node *np, int index)
    59	{
    60		struct clk **ptr, *clk;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26142 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161128/a56b37e6/attachment-0001.gz>
