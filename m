From: lkp@intel.com (kbuild test robot)
Date: Thu, 30 Jun 2016 00:46:09 +0800
Subject: [PATCH V2 4/8] clk: core: support clocks which requires parents
 enable (part 2)
In-Reply-To: <1467212351-16626-5-git-send-email-aisheng.dong@nxp.com>
Message-ID: <201606300000.VNGxChoP%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.7-rc5 next-20160629]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dong-Aisheng/clk-core-support-clocks-which-requires-parents-enable/20160629-231445
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-viper_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   include/linux/export.h:63:39: error: declaration of '__ksymtab_clk_notifier_register' with no linkage follows extern declaration
     __visible const struct kernel_symbol __ksymtab_##sym \
                                          ^
   include/linux/export.h:94:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^
   include/linux/export.h:101:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^
   drivers/clk/clk.c:2958:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(clk_notifier_register);
    ^
   include/linux/export.h:62:36: note: previous declaration of '__ksymtab_clk_notifier_register' was here
     extern const struct kernel_symbol __ksymtab_##sym; \
                                       ^
   include/linux/export.h:94:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^
   include/linux/export.h:101:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^
   drivers/clk/clk.c:2958:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(clk_notifier_register);
    ^
   drivers/clk/clk.c:3005:19: error: non-static declaration of 'clk_notifier_unregister' follows static declaration
    EXPORT_SYMBOL_GPL(clk_notifier_unregister);
                      ^
   include/linux/export.h:57:21: note: in definition of macro '___EXPORT_SYMBOL'
     extern typeof(sym) sym;     \
                        ^
   drivers/clk/clk.c:3005:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(clk_notifier_unregister);
    ^
   drivers/clk/clk.c:2971:5: note: previous definition of 'clk_notifier_unregister' was here
    int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb)
        ^
   In file included from include/linux/linkage.h:6:0,
                    from include/linux/kernel.h:6,
                    from include/linux/clk.h:16,
                    from drivers/clk/clk.c:12:
   include/linux/export.h:63:25: warning: '__used__' attribute ignored [-Wattributes]
     __visible const struct kernel_symbol __ksymtab_##sym \
                            ^
   include/linux/export.h:94:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^
   include/linux/export.h:101:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^
   drivers/clk/clk.c:3005:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(clk_notifier_unregister);
    ^
   include/linux/export.h:63:39: error: section attribute cannot be specified for local variables
     __visible const struct kernel_symbol __ksymtab_##sym \
                                          ^
   include/linux/export.h:94:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^
   include/linux/export.h:101:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^
   drivers/clk/clk.c:3005:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(clk_notifier_unregister);
    ^
   include/linux/export.h:63:25: warning: 'externally_visible' attribute have effect only on public objects [-Wattributes]
     __visible const struct kernel_symbol __ksymtab_##sym \
                            ^
   include/linux/export.h:94:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^
   include/linux/export.h:101:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^
   drivers/clk/clk.c:3005:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(clk_notifier_unregister);
    ^
   include/linux/export.h:63:39: error: declaration of '__ksymtab_clk_notifier_unregister' with no linkage follows extern declaration
     __visible const struct kernel_symbol __ksymtab_##sym \
                                          ^
   include/linux/export.h:94:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^
   include/linux/export.h:101:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^
   drivers/clk/clk.c:3005:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(clk_notifier_unregister);
    ^
   include/linux/export.h:62:36: note: previous declaration of '__ksymtab_clk_notifier_unregister' was here
     extern const struct kernel_symbol __ksymtab_##sym; \
                                       ^
   include/linux/export.h:94:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^
   include/linux/export.h:101:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^
   drivers/clk/clk.c:3005:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(clk_notifier_unregister);
    ^
>> include/linux/export.h:63:25: error: expected declaration or statement at end of input
     __visible const struct kernel_symbol __ksymtab_##sym \
                            ^
   include/linux/export.h:94:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^
   include/linux/export.h:101:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^
   drivers/clk/clk.c:3005:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(clk_notifier_unregister);
    ^

vim +63 include/linux/export.h

f5016932 Paul Gortmaker 2011-05-23  57  	extern typeof(sym) sym;					\
f5016932 Paul Gortmaker 2011-05-23  58  	__CRC_SYMBOL(sym, sec)					\
f5016932 Paul Gortmaker 2011-05-23  59  	static const char __kstrtab_##sym[]			\
f5016932 Paul Gortmaker 2011-05-23  60  	__attribute__((section("__ksymtab_strings"), aligned(1))) \
b92021b0 Rusty Russell  2013-03-15  61  	= VMLINUX_SYMBOL_STR(sym);				\
7b4ec8dd Johannes Berg  2014-01-16  62  	extern const struct kernel_symbol __ksymtab_##sym;	\
e0f244c6 Andi Kleen     2013-10-23 @63  	__visible const struct kernel_symbol __ksymtab_##sym	\
f5016932 Paul Gortmaker 2011-05-23  64  	__used							\
f5016932 Paul Gortmaker 2011-05-23  65  	__attribute__((section("___ksymtab" sec "+" #sym), unused))	\
f5016932 Paul Gortmaker 2011-05-23  66  	= { (unsigned long)&sym, __kstrtab_##sym }
f5016932 Paul Gortmaker 2011-05-23  67  
c1a95fda Nicolas Pitre  2016-01-22  68  #if defined(__KSYM_DEPS__)
c1a95fda Nicolas Pitre  2016-01-22  69  
c1a95fda Nicolas Pitre  2016-01-22  70  /*
c1a95fda Nicolas Pitre  2016-01-22  71   * For fine grained build dependencies, we want to tell the build system
c1a95fda Nicolas Pitre  2016-01-22  72   * about each possible exported symbol even if they're not actually exported.
c1a95fda Nicolas Pitre  2016-01-22  73   * We use a string pattern that is unlikely to be valid code that the build
c1a95fda Nicolas Pitre  2016-01-22  74   * system filters out from the preprocessor output (see ksym_dep_filter
c1a95fda Nicolas Pitre  2016-01-22  75   * in scripts/Kbuild.include).
c1a95fda Nicolas Pitre  2016-01-22  76   */
c1a95fda Nicolas Pitre  2016-01-22  77  #define __EXPORT_SYMBOL(sym, sec)	=== __KSYM_##sym ===
c1a95fda Nicolas Pitre  2016-01-22  78  
c1a95fda Nicolas Pitre  2016-01-22  79  #elif defined(CONFIG_TRIM_UNUSED_KSYMS)
f2355416 Nicolas Pitre  2016-01-22  80  
f2355416 Nicolas Pitre  2016-01-22  81  #include <linux/kconfig.h>
f2355416 Nicolas Pitre  2016-01-22  82  #include <generated/autoksyms.h>
f2355416 Nicolas Pitre  2016-01-22  83  
f2355416 Nicolas Pitre  2016-01-22  84  #define __EXPORT_SYMBOL(sym, sec)				\
f2355416 Nicolas Pitre  2016-01-22  85  	__cond_export_sym(sym, sec, config_enabled(__KSYM_##sym))
f2355416 Nicolas Pitre  2016-01-22  86  #define __cond_export_sym(sym, sec, conf)			\
f2355416 Nicolas Pitre  2016-01-22  87  	___cond_export_sym(sym, sec, conf)
f2355416 Nicolas Pitre  2016-01-22  88  #define ___cond_export_sym(sym, sec, enabled)			\
f2355416 Nicolas Pitre  2016-01-22  89  	__cond_export_sym_##enabled(sym, sec)
f2355416 Nicolas Pitre  2016-01-22  90  #define __cond_export_sym_1(sym, sec) ___EXPORT_SYMBOL(sym, sec)
f2355416 Nicolas Pitre  2016-01-22  91  #define __cond_export_sym_0(sym, sec) /* nothing */
f2355416 Nicolas Pitre  2016-01-22  92  
f2355416 Nicolas Pitre  2016-01-22  93  #else
f2355416 Nicolas Pitre  2016-01-22 @94  #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
f2355416 Nicolas Pitre  2016-01-22  95  #endif
f2355416 Nicolas Pitre  2016-01-22  96  
f5016932 Paul Gortmaker 2011-05-23  97  #define EXPORT_SYMBOL(sym)					\

:::::: The code at line 63 was first introduced by commit
:::::: e0f244c63fc9d192dfd399cc2677bbdca61994b1 asmlinkage, module: Make ksymtab and kcrctab symbols and __this_module __visible

:::::: TO: Andi Kleen <ak@linux.intel.com>
:::::: CC: Rusty Russell <rusty@rustcorp.com.au>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 18460 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160630/e8d0c526/attachment-0001.obj>
