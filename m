From: lkp@intel.com (kbuild test robot)
Date: Thu, 30 Jun 2016 00:47:41 +0800
Subject: [PATCH V2 4/8] clk: core: support clocks which requires parents
 enable (part 2)
In-Reply-To: <1467212351-16626-5-git-send-email-aisheng.dong@nxp.com>
Message-ID: <201606300022.63yB6Rfx%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on clk/clk-next]
[also build test WARNING on v4.7-rc5 next-20160629]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dong-Aisheng/clk-core-support-clocks-which-requires-parents-enable/20160629-231445
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: x86_64-randconfig-s4-06300001 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/clk/clk.c: In function '__clk_set_parent_after':
   drivers/clk/clk.c:1234:12: error: invalid storage class for function '__clk_set_parent'
    static int __clk_set_parent(struct clk_core *core, struct clk_core *parent,
               ^~~~~~~~~~~~~~~~
   drivers/clk/clk.c:1234:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static int __clk_set_parent(struct clk_core *core, struct clk_core *parent,
    ^~~~~~
   drivers/clk/clk.c:1279:12: error: invalid storage class for function '__clk_speculate_rates'
    static int __clk_speculate_rates(struct clk_core *core,
               ^~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk.c:1310:13: error: invalid storage class for function 'clk_calc_subtree'
    static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
                ^~~~~~~~~~~~~~~~
   drivers/clk/clk.c:1333:25: error: invalid storage class for function 'clk_calc_new_rates'
    static struct clk_core *clk_calc_new_rates(struct clk_core *core,
                            ^~~~~~~~~~~~~~~~~~
   drivers/clk/clk.c:1431:25: error: invalid storage class for function 'clk_propagate_rate_change'
    static struct clk_core *clk_propagate_rate_change(struct clk_core *core,
                            ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk.c:1469:13: error: invalid storage class for function 'clk_change_rate'
    static void clk_change_rate(struct clk_core *core)
                ^~~~~~~~~~~~~~~
   In file included from include/linux/err.h:4:0,
                    from include/linux/clk.h:15,
                    from drivers/clk/clk.c:12:
   drivers/clk/clk.c: In function 'clk_change_rate':
   drivers/clk/clk.c:1517:20: error: 'CLK_OPS_PARENT_ON' undeclared (first use in this function)
     if (core->flags & CLK_OPS_PARENT_ON)
                       ^
   include/linux/compiler.h:151:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers/clk/clk.c:1517:2: note: in expansion of macro 'if'
     if (core->flags & CLK_OPS_PARENT_ON)
     ^~
   drivers/clk/clk.c:1517:20: note: each undeclared identifier is reported only once for each function it appears in
     if (core->flags & CLK_OPS_PARENT_ON)
                       ^
   include/linux/compiler.h:151:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers/clk/clk.c:1517:2: note: in expansion of macro 'if'
     if (core->flags & CLK_OPS_PARENT_ON)
     ^~
   drivers/clk/clk.c: In function '__clk_set_parent_after':
   drivers/clk/clk.c:1561:12: error: invalid storage class for function 'clk_core_set_rate_nolock'
    static int clk_core_set_rate_nolock(struct clk_core *core,
               ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk.c:1646:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    int clk_set_rate_range(struct clk *clk, unsigned long min, unsigned long max)
    ^~~
   drivers/clk/clk.c:1681:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    int clk_set_min_rate(struct clk *clk, unsigned long rate)
    ^~~
   drivers/clk/clk.c:1697:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    int clk_set_max_rate(struct clk *clk, unsigned long rate)
    ^~~
   drivers/clk/clk.c:1712:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    struct clk *clk_get_parent(struct clk *clk)
    ^~~~~~
   drivers/clk/clk.c:1728:25: error: invalid storage class for function '__clk_init_parent'
    static struct clk_core *__clk_init_parent(struct clk_core *core)
                            ^~~~~~~~~~~~~~~~~
   drivers/clk/clk.c:1728:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static struct clk_core *__clk_init_parent(struct clk_core *core)
    ^~~~~~
   drivers/clk/clk.c:1738:13: error: invalid storage class for function 'clk_core_reparent'
    static void clk_core_reparent(struct clk_core *core,
                ^~~~~~~~~~~~~~~~~
   drivers/clk/clk.c:1788:12: error: invalid storage class for function 'clk_core_set_parent'
    static int clk_core_set_parent(struct clk_core *core, struct clk_core *parent)
               ^~~~~~~~~~~~~~~~~~~
   drivers/clk/clk.c:1788:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static int clk_core_set_parent(struct clk_core *core, struct clk_core *parent)
    ^~~~~~
   drivers/clk/clk.c:1897:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    int clk_set_phase(struct clk *clk, int degrees)
    ^~~
   drivers/clk/clk.c:1932:12: error: invalid storage class for function 'clk_core_get_phase'
    static int clk_core_get_phase(struct clk_core *core)
               ^~~~~~~~~~~~~~~~~~
   drivers/clk/clk.c:1932:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static int clk_core_get_phase(struct clk_core *core)
    ^~~~~~
   drivers/clk/clk.c:1970:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    bool clk_is_match(const struct clk *p, const struct clk *q)
    ^~~~
   In file included from drivers/clk/clk.c:1988:0:
>> include/linux/debugfs.h:24:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    struct device;
    ^~~~~~
   drivers/clk/clk.c:2006:13: error: invalid storage class for function 'clk_summary_show_one'
    static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
                ^~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk.c:2019:13: error: invalid storage class for function 'clk_summary_show_subtree'
    static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
                ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk.c:2033:12: error: invalid storage class for function 'clk_summary_show'
    static int clk_summary_show(struct seq_file *s, void *data)
               ^~~~~~~~~~~~~~~~
   drivers/clk/clk.c:2053:12: error: invalid storage class for function 'clk_summary_open'
    static int clk_summary_open(struct inode *inode, struct file *file)
               ^~~~~~~~~~~~~~~~
   drivers/clk/clk.c:2058:21: error: variable 'clk_summary_fops' has initializer but incomplete type
    static const struct file_operations clk_summary_fops = {
                        ^~~~~~~~~~~~~~~
   drivers/clk/clk.c:2059:2: error: unknown field 'open' specified in initializer
     .open  = clk_summary_open,
     ^
   drivers/clk/clk.c:2059:11: warning: excess elements in struct initializer
     .open  = clk_summary_open,
              ^~~~~~~~~~~~~~~~
   drivers/clk/clk.c:2059:11: note: (near initialization for 'clk_summary_fops')
   drivers/clk/clk.c:2060:2: error: unknown field 'read' specified in initializer
     .read  = seq_read,
     ^
   drivers/clk/clk.c:2060:11: warning: excess elements in struct initializer
     .read  = seq_read,
              ^~~~~~~~
   drivers/clk/clk.c:2060:11: note: (near initialization for 'clk_summary_fops')
   drivers/clk/clk.c:2061:2: error: unknown field 'llseek' specified in initializer
     .llseek  = seq_lseek,
     ^
   drivers/clk/clk.c:2061:13: warning: excess elements in struct initializer
     .llseek  = seq_lseek,
                ^~~~~~~~~
   drivers/clk/clk.c:2061:13: note: (near initialization for 'clk_summary_fops')
   drivers/clk/clk.c:2062:2: error: unknown field 'release' specified in initializer
     .release = single_release,
     ^
   drivers/clk/clk.c:2062:13: warning: excess elements in struct initializer
     .release = single_release,
                ^~~~~~~~~~~~~~
   drivers/clk/clk.c:2062:13: note: (near initialization for 'clk_summary_fops')
   drivers/clk/clk.c:2058:37: error: storage size of 'clk_summary_fops' isn't known
    static const struct file_operations clk_summary_fops = {
                                        ^~~~~~~~~~~~~~~~
   drivers/clk/clk.c:2065:13: error: invalid storage class for function 'clk_dump_one'
    static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
                ^~~~~~~~~~~~
   drivers/clk/clk.c:2079:13: error: invalid storage class for function 'clk_dump_subtree'
    static void clk_dump_subtree(struct seq_file *s, struct clk_core *c, int level)
                ^~~~~~~~~~~~~~~~
   drivers/clk/clk.c:2096:12: error: invalid storage class for function 'clk_dump'
    static int clk_dump(struct seq_file *s, void *data)
               ^~~~~~~~
   drivers/clk/clk.c:2122:12: error: invalid storage class for function 'clk_dump_open'
    static int clk_dump_open(struct inode *inode, struct file *file)
               ^~~~~~~~~~~~~
   drivers/clk/clk.c:2127:21: error: variable 'clk_dump_fops' has initializer but incomplete type
    static const struct file_operations clk_dump_fops = {
                        ^~~~~~~~~~~~~~~
   drivers/clk/clk.c:2128:2: error: unknown field 'open' specified in initializer
     .open  = clk_dump_open,
     ^
   drivers/clk/clk.c:2128:11: warning: excess elements in struct initializer
     .open  = clk_dump_open,
              ^~~~~~~~~~~~~
   drivers/clk/clk.c:2128:11: note: (near initialization for 'clk_dump_fops')
   drivers/clk/clk.c:2129:2: error: unknown field 'read' specified in initializer
     .read  = seq_read,
     ^
   drivers/clk/clk.c:2129:11: warning: excess elements in struct initializer
     .read  = seq_read,
              ^~~~~~~~
   drivers/clk/clk.c:2129:11: note: (near initialization for 'clk_dump_fops')
   drivers/clk/clk.c:2130:2: error: unknown field 'llseek' specified in initializer
     .llseek  = seq_lseek,
     ^
   drivers/clk/clk.c:2130:13: warning: excess elements in struct initializer
     .llseek  = seq_lseek,
                ^~~~~~~~~
   drivers/clk/clk.c:2130:13: note: (near initialization for 'clk_dump_fops')
   drivers/clk/clk.c:2131:2: error: unknown field 'release' specified in initializer
     .release = single_release,
     ^
   drivers/clk/clk.c:2131:13: warning: excess elements in struct initializer
     .release = single_release,
                ^~~~~~~~~~~~~~
   drivers/clk/clk.c:2131:13: note: (near initialization for 'clk_dump_fops')
   drivers/clk/clk.c:2127:37: error: storage size of 'clk_dump_fops' isn't known
    static const struct file_operations clk_dump_fops = {
                                        ^~~~~~~~~~~~~
   drivers/clk/clk.c:2134:12: error: invalid storage class for function 'clk_debug_create_one'
    static int clk_debug_create_one(struct clk_core *core, struct dentry *pdentry)
               ^~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk.c:2209:12: error: invalid storage class for function 'clk_debug_register'
    static int clk_debug_register(struct clk_core *core)
               ^~~~~~~~~~~~~~~~~~

vim +/if +1517 drivers/clk/clk.c

  1501	
  1502			if (core->ops->set_rate_and_parent) {
  1503				skip_set_rate = true;
  1504				core->ops->set_rate_and_parent(core->hw, core->new_rate,
  1505						best_parent_rate,
  1506						core->new_parent_index);
  1507			} else if (core->ops->set_parent) {
  1508				core->ops->set_parent(core->hw, core->new_parent_index);
  1509			}
  1510	
  1511			trace_clk_set_parent_complete(core, core->new_parent);
  1512			__clk_set_parent_after(core, core->new_parent, old_parent);
  1513		}
  1514	
  1515		trace_clk_set_rate(core, core->new_rate);
  1516	
> 1517		if (core->flags & CLK_OPS_PARENT_ON)
  1518			clk_core_prepare_enable(parent);
  1519	
  1520		if (!skip_set_rate && core->ops->set_rate)
  1521			core->ops->set_rate(core->hw, core->new_rate, best_parent_rate);
  1522	
  1523		trace_clk_set_rate_complete(core, core->new_rate);
  1524	
  1525		core->rate = clk_recalc(core, best_parent_rate);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 23216 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160630/2f0052fa/attachment-0001.obj>
