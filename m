From: lkp@intel.com (kbuild test robot)
Date: Sun, 24 Sep 2017 10:06:43 +0800
Subject: [PATCH V3 1/1] clk: bulk: add of_clk_bulk_get()
In-Reply-To: <1505893753-16143-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <201709240941.1xKB0Rqm%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.14-rc1 next-20170922]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dong-Aisheng/clk-bulk-add-of_clk_bulk_get/20170921-203645
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: sh-apsh4a3a_defconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All errors (new ones prefixed by >>):

   In file included from arch/sh/kernel/setup.c:28:0:
>> include/linux/clk.h:689:12: error: 'of_clk_bulk_get' defined but not used [-Werror=unused-function]
    static int of_clk_bulk_get(struct device_node *np, int num_clks,
               ^~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +/of_clk_bulk_get +689 include/linux/clk.h

   681	
   682	#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
   683	int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
   684					 struct clk_bulk_data *clks);
   685	struct clk *of_clk_get(struct device_node *np, int index);
   686	struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
   687	struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
   688	#else
 > 689	static int of_clk_bulk_get(struct device_node *np, int num_clks,
   690				   struct clk_bulk_data *clks)
   691	{
   692		return -ENOENT;
   693	}
   694	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 11750 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170924/ff3fa8bb/attachment.gz>
