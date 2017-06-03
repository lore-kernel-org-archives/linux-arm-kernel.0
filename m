From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 4 Jun 2017 07:51:45 +0800
Subject: [clk:clk-next 3/7] drivers/clk/at91/clk-generated.c:273:20: error:
 invalid storage class for function 'of_sama5d2_clk_generated_setup'
Message-ID: <201706040742.DbZJp6sd%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
head:   ee177c5d6369f8e5d3e4793dce501cf4431313a1
commit: 8e56133e5c7b7a7a97f6a92d92f664d5ecd30745 [3/7] clk: at91: fix clk-generated parenting
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 8e56133e5c7b7a7a97f6a92d92f664d5ecd30745
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/clk/at91/clk-generated.c: In function 'at91_clk_register_generated':
>> drivers/clk/at91/clk-generated.c:273:20: error: invalid storage class for function 'of_sama5d2_clk_generated_setup'
    static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/at91/clk-generated.c:273:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
    ^~~~~~
   In file included from include/linux/clk-provider.h:15:0,
                    from drivers/clk/at91/clk-generated.c:14:
>> include/linux/of.h:1132:16: error: initializer element is not constant
           .data = (fn == (fn_type)NULL) ? fn : fn  }
                   ^
   include/linux/of.h:1146:3: note: in expansion of macro '_OF_DECLARE'
      _OF_DECLARE(table, name, compat, fn, of_init_fn_1)
      ^~~~~~~~~~~
   include/linux/clk-provider.h:781:42: note: in expansion of macro 'OF_DECLARE_1'
    #define CLK_OF_DECLARE(name, compat, fn) OF_DECLARE_1(clk, name, compat, fn)
                                             ^~~~~~~~~~~~
   drivers/clk/at91/clk-generated.c:321:1: note: in expansion of macro 'CLK_OF_DECLARE'
    CLK_OF_DECLARE(of_sama5d2_clk_generated_setup, "atmel,sama5d2-clk-generated",
    ^~~~~~~~~~~~~~
   include/linux/of.h:1132:16: note: (near initialization for '__of_table_of_sama5d2_clk_generated_setup.data')
           .data = (fn == (fn_type)NULL) ? fn : fn  }
                   ^
   include/linux/of.h:1146:3: note: in expansion of macro '_OF_DECLARE'
      _OF_DECLARE(table, name, compat, fn, of_init_fn_1)
      ^~~~~~~~~~~
   include/linux/clk-provider.h:781:42: note: in expansion of macro 'OF_DECLARE_1'
    #define CLK_OF_DECLARE(name, compat, fn) OF_DECLARE_1(clk, name, compat, fn)
                                             ^~~~~~~~~~~~
   drivers/clk/at91/clk-generated.c:321:1: note: in expansion of macro 'CLK_OF_DECLARE'
    CLK_OF_DECLARE(of_sama5d2_clk_generated_setup, "atmel,sama5d2-clk-generated",
    ^~~~~~~~~~~~~~
>> include/linux/of.h:1129:22: error: expected declaration or statement at end of input
     static const struct of_device_id __of_table_##name  \
                         ^
   include/linux/of.h:1146:3: note: in expansion of macro '_OF_DECLARE'
      _OF_DECLARE(table, name, compat, fn, of_init_fn_1)
      ^~~~~~~~~~~
   include/linux/clk-provider.h:781:42: note: in expansion of macro 'OF_DECLARE_1'
    #define CLK_OF_DECLARE(name, compat, fn) OF_DECLARE_1(clk, name, compat, fn)
                                             ^~~~~~~~~~~~
   drivers/clk/at91/clk-generated.c:321:1: note: in expansion of macro 'CLK_OF_DECLARE'
    CLK_OF_DECLARE(of_sama5d2_clk_generated_setup, "atmel,sama5d2-clk-generated",
    ^~~~~~~~~~~~~~
--
   drivers/clk//at91/clk-generated.c: In function 'at91_clk_register_generated':
   drivers/clk//at91/clk-generated.c:273:20: error: invalid storage class for function 'of_sama5d2_clk_generated_setup'
    static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk//at91/clk-generated.c:273:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
    ^~~~~~
   In file included from include/linux/clk-provider.h:15:0,
                    from drivers/clk//at91/clk-generated.c:14:
>> include/linux/of.h:1132:16: error: initializer element is not constant
           .data = (fn == (fn_type)NULL) ? fn : fn  }
                   ^
   include/linux/of.h:1146:3: note: in expansion of macro '_OF_DECLARE'
      _OF_DECLARE(table, name, compat, fn, of_init_fn_1)
      ^~~~~~~~~~~
   include/linux/clk-provider.h:781:42: note: in expansion of macro 'OF_DECLARE_1'
    #define CLK_OF_DECLARE(name, compat, fn) OF_DECLARE_1(clk, name, compat, fn)
                                             ^~~~~~~~~~~~
   drivers/clk//at91/clk-generated.c:321:1: note: in expansion of macro 'CLK_OF_DECLARE'
    CLK_OF_DECLARE(of_sama5d2_clk_generated_setup, "atmel,sama5d2-clk-generated",
    ^~~~~~~~~~~~~~
   include/linux/of.h:1132:16: note: (near initialization for '__of_table_of_sama5d2_clk_generated_setup.data')
           .data = (fn == (fn_type)NULL) ? fn : fn  }
                   ^
   include/linux/of.h:1146:3: note: in expansion of macro '_OF_DECLARE'
      _OF_DECLARE(table, name, compat, fn, of_init_fn_1)
      ^~~~~~~~~~~
   include/linux/clk-provider.h:781:42: note: in expansion of macro 'OF_DECLARE_1'
    #define CLK_OF_DECLARE(name, compat, fn) OF_DECLARE_1(clk, name, compat, fn)
                                             ^~~~~~~~~~~~
   drivers/clk//at91/clk-generated.c:321:1: note: in expansion of macro 'CLK_OF_DECLARE'
    CLK_OF_DECLARE(of_sama5d2_clk_generated_setup, "atmel,sama5d2-clk-generated",
    ^~~~~~~~~~~~~~
>> include/linux/of.h:1129:22: error: expected declaration or statement at end of input
     static const struct of_device_id __of_table_##name  \
                         ^
   include/linux/of.h:1146:3: note: in expansion of macro '_OF_DECLARE'
      _OF_DECLARE(table, name, compat, fn, of_init_fn_1)
      ^~~~~~~~~~~
   include/linux/clk-provider.h:781:42: note: in expansion of macro 'OF_DECLARE_1'
    #define CLK_OF_DECLARE(name, compat, fn) OF_DECLARE_1(clk, name, compat, fn)
                                             ^~~~~~~~~~~~
   drivers/clk//at91/clk-generated.c:321:1: note: in expansion of macro 'CLK_OF_DECLARE'
    CLK_OF_DECLARE(of_sama5d2_clk_generated_setup, "atmel,sama5d2-clk-generated",
    ^~~~~~~~~~~~~~

vim +/of_sama5d2_clk_generated_setup +273 drivers/clk/at91/clk-generated.c

df70aeef Nicolas Ferre 2015-07-31  267  		kfree(gck);
f5644f10 Stephen Boyd  2016-06-01  268  		hw = ERR_PTR(ret);
df70aeef Nicolas Ferre 2015-07-31  269  
f5644f10 Stephen Boyd  2016-06-01  270  	return hw;
df70aeef Nicolas Ferre 2015-07-31  271  }
df70aeef Nicolas Ferre 2015-07-31  272  
14755549 Ben Dooks     2016-06-07 @273  static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
df70aeef Nicolas Ferre 2015-07-31  274  {
df70aeef Nicolas Ferre 2015-07-31  275  	int num;
df70aeef Nicolas Ferre 2015-07-31  276  	u32 id;

:::::: The code at line 273 was first introduced by commit
:::::: 14755549c7db6e26d04b208047f44538aa325802 clk: at91: make of_sama5d2_clk_generated_setup() static

:::::: TO: Ben Dooks <ben.dooks@codethink.co.uk>
:::::: CC: Stephen Boyd <sboyd@codeaurora.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 41294 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170604/91fdad5a/attachment-0001.gz>
