From: lkp@intel.com (kbuild test robot)
Date: Wed, 13 Sep 2017 12:06:21 +0800
Subject: [PATCH 1/1] clk: bulk: add of_clk_bulk_get()
In-Reply-To: <1505115413-25483-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <201709131101.wAXlpdBK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.13 next-20170912]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dong-Aisheng/clk-bulk-add-of_clk_bulk_get/20170913-075645
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: powerpc-defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   In file included from include/linux/cpufreq.h:14:0,
                    from arch/powerpc/oprofile/op_model_cell.c:17:
   include/linux/clk.h: In function 'of_clk_bulk_get':
>> include/linux/clk.h:692:9: error: return makes integer from pointer without a cast [-Werror=int-conversion]
     return ERR_PTR(-ENOENT);
            ^~~~~~~~~~~~~~~~
   At top level:
>> include/linux/clk.h:689:12: error: 'of_clk_bulk_get' defined but not used [-Werror=unused-function]
    static int of_clk_bulk_get(struct device_node *np, int num_clks,
               ^~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +692 include/linux/clk.h

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
 > 692		return ERR_PTR(-ENOENT);
   693	}
   694	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23686 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170913/087319d3/attachment-0001.gz>
