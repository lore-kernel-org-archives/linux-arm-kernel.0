From: lkp@intel.com (kbuild test robot)
Date: Wed, 13 Sep 2017 08:34:24 +0800
Subject: [PATCH 1/1] clk: bulk: add of_clk_bulk_get()
In-Reply-To: <1505115413-25483-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <201709130826.AnbwLF3k%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

[auto build test WARNING on clk/clk-next]
[also build test WARNING on v4.13 next-20170912]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dong-Aisheng/clk-bulk-add-of_clk_bulk_get/20170913-075645
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: x86_64-randconfig-x001-201737 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/dma/dw.h:15:0,
                    from drivers//tty/serial/8250/8250_lpss.c:18:
   include/linux/clk.h: In function 'of_clk_bulk_get':
>> include/linux/clk.h:692:9: warning: return makes integer from pointer without a cast [-Wint-conversion]
     return ERR_PTR(-ENOENT);
            ^~~~~~~~~~~~~~~~
   At top level:
   include/linux/clk.h:689:12: warning: 'of_clk_bulk_get' defined but not used [-Wunused-function]
    static int of_clk_bulk_get(struct device_node *np, int num_clks,
               ^~~~~~~~~~~~~~~

vim +692 include/linux/clk.h

   681	
   682	#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
   683	int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
   684					 struct clk_bulk_data *clks);
   685	struct clk *of_clk_get(struct device_node *np, int index);
   686	struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
   687	struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
   688	#else
   689	static int of_clk_bulk_get(struct device_node *np, int num_clks,
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
Size: 25166 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170913/13567e64/attachment-0001.gz>
