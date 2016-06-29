From: lkp@intel.com (kbuild test robot)
Date: Thu, 30 Jun 2016 00:42:21 +0800
Subject: [PATCH V2 4/8] clk: core: support clocks which requires parents
 enable (part 2)
In-Reply-To: <1467212351-16626-5-git-send-email-aisheng.dong@nxp.com>
Message-ID: <201606300015.zJJwBdRV%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.7-rc5 next-20160629]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dong-Aisheng/clk-core-support-clocks-which-requires-parents-enable/20160629-231445
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: x86_64-randconfig-i0-201626 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   include/linux/export.h:94:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:101:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^~~~~~~~~~~~~~~
   drivers/clk/clk.c:1957:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(clk_get_phase);
    ^~~~~~~~~~~~~~~~~
   include/linux/export.h:62:36: note: previous declaration of '__ksymtab_clk_get_phase' was here
     extern const struct kernel_symbol __ksymtab_##sym; \
                                       ^
   include/linux/export.h:94:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:101:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^~~~~~~~~~~~~~~
   drivers/clk/clk.c:1957:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(clk_get_phase);
    ^~~~~~~~~~~~~~~~~
   drivers/clk/clk.c:1983:19: error: non-static declaration of 'clk_is_match' follows static declaration
    EXPORT_SYMBOL_GPL(clk_is_match);
                      ^
   include/linux/export.h:57:21: note: in definition of macro '___EXPORT_SYMBOL'
     extern typeof(sym) sym;     \
                        ^~~
   drivers/clk/clk.c:1983:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(clk_is_match);
    ^~~~~~~~~~~~~~~~~
   drivers/clk/clk.c:1970:6: note: previous definition of 'clk_is_match' was here
    bool clk_is_match(const struct clk *p, const struct clk *q)
         ^~~~~~~~~~~~
   In file included from include/linux/linkage.h:6:0,
                    from include/linux/kernel.h:6,
                    from include/linux/clk.h:16,
                    from drivers/clk/clk.c:12:
   include/linux/export.h:63:25: warning: '__used__' attribute ignored [-Wattributes]
     __visible const struct kernel_symbol __ksymtab_##sym \
                            ^
   include/linux/export.h:94:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:101:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^~~~~~~~~~~~~~~
   drivers/clk/clk.c:1983:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(clk_is_match);
    ^~~~~~~~~~~~~~~~~
   include/linux/export.h:63:39: error: section attribute cannot be specified for local variables
     __visible const struct kernel_symbol __ksymtab_##sym \
                                          ^
   include/linux/export.h:94:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:101:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^~~~~~~~~~~~~~~
   drivers/clk/clk.c:1983:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(clk_is_match);
    ^~~~~~~~~~~~~~~~~
   include/linux/export.h:63:25: warning: 'externally_visible' attribute have effect only on public objects [-Wattributes]
     __visible const struct kernel_symbol __ksymtab_##sym \
                            ^
   include/linux/export.h:94:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:101:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^~~~~~~~~~~~~~~
   drivers/clk/clk.c:1983:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(clk_is_match);
    ^~~~~~~~~~~~~~~~~
   include/linux/export.h:63:39: error: declaration of '__ksymtab_clk_is_match' with no linkage follows extern declaration
     __visible const struct kernel_symbol __ksymtab_##sym \
                                          ^
   include/linux/export.h:94:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:101:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^~~~~~~~~~~~~~~
   drivers/clk/clk.c:1983:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(clk_is_match);
    ^~~~~~~~~~~~~~~~~
   include/linux/export.h:62:36: note: previous declaration of '__ksymtab_clk_is_match' was here
     extern const struct kernel_symbol __ksymtab_##sym; \
                                       ^
   include/linux/export.h:94:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:101:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^~~~~~~~~~~~~~~
   drivers/clk/clk.c:1983:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(clk_is_match);
    ^~~~~~~~~~~~~~~~~
   In file included from include/linux/fs.h:6:0,
                    from include/linux/debugfs.h:18,
                    from drivers/clk/clk.c:1988:
>> include/linux/kdev_t.h:23:20: error: invalid storage class for function 'old_valid_dev'
    static inline bool old_valid_dev(dev_t dev)
                       ^~~~~~~~~~~~~
>> include/linux/kdev_t.h:28:19: error: invalid storage class for function 'old_encode_dev'
    static inline u16 old_encode_dev(dev_t dev)
                      ^~~~~~~~~~~~~~
>> include/linux/kdev_t.h:33:21: error: invalid storage class for function 'old_decode_dev'
    static inline dev_t old_decode_dev(u16 val)
                        ^~~~~~~~~~~~~~
>> include/linux/kdev_t.h:38:19: error: invalid storage class for function 'new_encode_dev'
    static inline u32 new_encode_dev(dev_t dev)
                      ^~~~~~~~~~~~~~
>> include/linux/kdev_t.h:45:21: error: invalid storage class for function 'new_decode_dev'
    static inline dev_t new_decode_dev(u32 dev)
                        ^~~~~~~~~~~~~~
>> include/linux/kdev_t.h:52:19: error: invalid storage class for function 'huge_encode_dev'
    static inline u64 huge_encode_dev(dev_t dev)
                      ^~~~~~~~~~~~~~~
>> include/linux/kdev_t.h:57:21: error: invalid storage class for function 'huge_decode_dev'
    static inline dev_t huge_decode_dev(u64 dev)
                        ^~~~~~~~~~~~~~~
>> include/linux/kdev_t.h:62:19: error: invalid storage class for function 'sysv_valid_dev'
    static inline int sysv_valid_dev(dev_t dev)
                      ^~~~~~~~~~~~~~
>> include/linux/kdev_t.h:67:19: error: invalid storage class for function 'sysv_encode_dev'
    static inline u32 sysv_encode_dev(dev_t dev)
                      ^~~~~~~~~~~~~~~
>> include/linux/kdev_t.h:72:24: error: invalid storage class for function 'sysv_major'
    static inline unsigned sysv_major(u32 dev)
                           ^~~~~~~~~~
>> include/linux/kdev_t.h:77:24: error: invalid storage class for function 'sysv_minor'
    static inline unsigned sysv_minor(u32 dev)
                           ^~~~~~~~~~
   In file included from include/linux/list_bl.h:5:0,
                    from include/linux/rculist_bl.h:7,
                    from include/linux/dcache.h:7,
                    from include/linux/fs.h:7,
                    from include/linux/debugfs.h:18,
                    from drivers/clk/clk.c:1988:
>> include/linux/bit_spinlock.h:15:20: error: invalid storage class for function 'bit_spin_lock'
    static inline void bit_spin_lock(int bitnum, unsigned long *addr)
                       ^~~~~~~~~~~~~
>> include/linux/bit_spinlock.h:40:19: error: invalid storage class for function 'bit_spin_trylock'
    static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
                      ^~~~~~~~~~~~~~~~
>> include/linux/bit_spinlock.h:56:20: error: invalid storage class for function 'bit_spin_unlock'
    static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
                       ^~~~~~~~~~~~~~~
>> include/linux/bit_spinlock.h:73:20: error: invalid storage class for function '__bit_spin_unlock'
    static inline void __bit_spin_unlock(int bitnum, unsigned long *addr)
                       ^~~~~~~~~~~~~~~~~
>> include/linux/bit_spinlock.h:88:19: error: invalid storage class for function 'bit_spin_is_locked'
    static inline int bit_spin_is_locked(int bitnum, unsigned long *addr)
                      ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/rculist_bl.h:7:0,
                    from include/linux/dcache.h:7,
                    from include/linux/fs.h:7,
                    from include/linux/debugfs.h:18,
                    from drivers/clk/clk.c:1988:
>> include/linux/list_bl.h:43:20: error: invalid storage class for function 'INIT_HLIST_BL_NODE'
    static inline void INIT_HLIST_BL_NODE(struct hlist_bl_node *h)
                       ^~~~~~~~~~~~~~~~~~
>> include/linux/list_bl.h:51:21: error: invalid storage class for function 'hlist_bl_unhashed'
    static inline bool  hlist_bl_unhashed(const struct hlist_bl_node *h)
                        ^~~~~~~~~~~~~~~~~
>> include/linux/list_bl.h:56:37: error: invalid storage class for function 'hlist_bl_first'
    static inline struct hlist_bl_node *hlist_bl_first(struct hlist_bl_head *h)
                                        ^~~~~~~~~~~~~~
>> include/linux/list_bl.h:62:20: error: invalid storage class for function 'hlist_bl_set_first'
    static inline void hlist_bl_set_first(struct hlist_bl_head *h,
                       ^~~~~~~~~~~~~~~~~~

vim +2148 drivers/clk/clk.c

4dff95dc9 Stephen Boyd   2015-04-30  2122  static int clk_dump_open(struct inode *inode, struct file *file)
b33d212f4 Ulf Hansson    2013-04-02  2123  {
4dff95dc9 Stephen Boyd   2015-04-30  2124  	return single_open(file, clk_dump, inode->i_private);
b2476490e Mike Turquette 2012-03-15  2125  }
b2476490e Mike Turquette 2012-03-15  2126  
4dff95dc9 Stephen Boyd   2015-04-30  2127  static const struct file_operations clk_dump_fops = {
4dff95dc9 Stephen Boyd   2015-04-30 @2128  	.open		= clk_dump_open,
4dff95dc9 Stephen Boyd   2015-04-30  2129  	.read		= seq_read,
4dff95dc9 Stephen Boyd   2015-04-30  2130  	.llseek		= seq_lseek,
4dff95dc9 Stephen Boyd   2015-04-30  2131  	.release	= single_release,
4dff95dc9 Stephen Boyd   2015-04-30  2132  };
4dff95dc9 Stephen Boyd   2015-04-30  2133  
4dff95dc9 Stephen Boyd   2015-04-30  2134  static int clk_debug_create_one(struct clk_core *core, struct dentry *pdentry)
4e88f3de8 Thierry Reding 2015-01-21  2135  {
4dff95dc9 Stephen Boyd   2015-04-30  2136  	struct dentry *d;
4dff95dc9 Stephen Boyd   2015-04-30  2137  	int ret = -ENOMEM;
4e88f3de8 Thierry Reding 2015-01-21  2138  
4dff95dc9 Stephen Boyd   2015-04-30  2139  	if (!core || !pdentry) {
4dff95dc9 Stephen Boyd   2015-04-30  2140  		ret = -EINVAL;
4dff95dc9 Stephen Boyd   2015-04-30  2141  		goto out;
4dff95dc9 Stephen Boyd   2015-04-30  2142  	}
4e88f3de8 Thierry Reding 2015-01-21  2143  
4dff95dc9 Stephen Boyd   2015-04-30  2144  	d = debugfs_create_dir(core->name, pdentry);
4dff95dc9 Stephen Boyd   2015-04-30  2145  	if (!d)
4dff95dc9 Stephen Boyd   2015-04-30  2146  		goto out;
035a61c31 Tomeu Vizoso   2015-01-23  2147  
4dff95dc9 Stephen Boyd   2015-04-30 @2148  	core->dentry = d;
4e88f3de8 Thierry Reding 2015-01-21  2149  
4dff95dc9 Stephen Boyd   2015-04-30 @2150  	d = debugfs_create_u32("clk_rate", S_IRUGO, core->dentry,
4dff95dc9 Stephen Boyd   2015-04-30  2151  			(u32 *)&core->rate);
4dff95dc9 Stephen Boyd   2015-04-30  2152  	if (!d)
4dff95dc9 Stephen Boyd   2015-04-30  2153  		goto err_out;
4e88f3de8 Thierry Reding 2015-01-21  2154  
4dff95dc9 Stephen Boyd   2015-04-30  2155  	d = debugfs_create_u32("clk_accuracy", S_IRUGO, core->dentry,
4dff95dc9 Stephen Boyd   2015-04-30  2156  			(u32 *)&core->accuracy);
4dff95dc9 Stephen Boyd   2015-04-30  2157  	if (!d)
4dff95dc9 Stephen Boyd   2015-04-30  2158  		goto err_out;
4e88f3de8 Thierry Reding 2015-01-21  2159  
4dff95dc9 Stephen Boyd   2015-04-30 @2160  	d = debugfs_create_u32("clk_phase", S_IRUGO, core->dentry,
4dff95dc9 Stephen Boyd   2015-04-30  2161  			(u32 *)&core->phase);
4dff95dc9 Stephen Boyd   2015-04-30  2162  	if (!d)
4dff95dc9 Stephen Boyd   2015-04-30  2163  		goto err_out;
b2476490e Mike Turquette 2012-03-15  2164  
4dff95dc9 Stephen Boyd   2015-04-30 @2165  	d = debugfs_create_x32("clk_flags", S_IRUGO, core->dentry,
4dff95dc9 Stephen Boyd   2015-04-30  2166  			(u32 *)&core->flags);
4dff95dc9 Stephen Boyd   2015-04-30  2167  	if (!d)
4dff95dc9 Stephen Boyd   2015-04-30  2168  		goto err_out;
89ac8d7ae Mike Turquette 2013-08-21  2169  
4dff95dc9 Stephen Boyd   2015-04-30  2170  	d = debugfs_create_u32("clk_prepare_count", S_IRUGO, core->dentry,
4dff95dc9 Stephen Boyd   2015-04-30  2171  			(u32 *)&core->prepare_count);
4dff95dc9 Stephen Boyd   2015-04-30  2172  	if (!d)
4dff95dc9 Stephen Boyd   2015-04-30  2173  		goto err_out;
b2476490e Mike Turquette 2012-03-15  2174  
4dff95dc9 Stephen Boyd   2015-04-30  2175  	d = debugfs_create_u32("clk_enable_count", S_IRUGO, core->dentry,
4dff95dc9 Stephen Boyd   2015-04-30  2176  			(u32 *)&core->enable_count);
4dff95dc9 Stephen Boyd   2015-04-30  2177  	if (!d)
4dff95dc9 Stephen Boyd   2015-04-30  2178  		goto err_out;
b2476490e Mike Turquette 2012-03-15  2179  
4dff95dc9 Stephen Boyd   2015-04-30 @2180  	d = debugfs_create_u32("clk_notifier_count", S_IRUGO, core->dentry,
4dff95dc9 Stephen Boyd   2015-04-30  2181  			(u32 *)&core->notifier_count);
4dff95dc9 Stephen Boyd   2015-04-30  2182  	if (!d)
4dff95dc9 Stephen Boyd   2015-04-30  2183  		goto err_out;
b61c43c09 Stephen Boyd   2015-02-02  2184  
4dff95dc9 Stephen Boyd   2015-04-30  2185  	if (core->ops->debug_init) {
4dff95dc9 Stephen Boyd   2015-04-30  2186  		ret = core->ops->debug_init(core->hw, core->dentry);
4dff95dc9 Stephen Boyd   2015-04-30  2187  		if (ret)
4dff95dc9 Stephen Boyd   2015-04-30  2188  			goto err_out;
031dcc9bd Ulf Hansson    2013-04-02  2189  	}
031dcc9bd Ulf Hansson    2013-04-02  2190  
4dff95dc9 Stephen Boyd   2015-04-30  2191  	ret = 0;
031dcc9bd Ulf Hansson    2013-04-02  2192  	goto out;
031dcc9bd Ulf Hansson    2013-04-02  2193  
4dff95dc9 Stephen Boyd   2015-04-30  2194  err_out:
4dff95dc9 Stephen Boyd   2015-04-30 @2195  	debugfs_remove_recursive(core->dentry);
4dff95dc9 Stephen Boyd   2015-04-30  2196  	core->dentry = NULL;
4dff95dc9 Stephen Boyd   2015-04-30  2197  out:
4dff95dc9 Stephen Boyd   2015-04-30  2198  	return ret;
4dff95dc9 Stephen Boyd   2015-04-30  2199  }
b2476490e Mike Turquette 2012-03-15  2200  
4dff95dc9 Stephen Boyd   2015-04-30  2201  /**
6e5ab41b1 Stephen Boyd   2015-04-30  2202   * clk_debug_register - add a clk node to the debugfs clk directory
6e5ab41b1 Stephen Boyd   2015-04-30  2203   * @core: the clk being added to the debugfs clk directory
4dff95dc9 Stephen Boyd   2015-04-30  2204   *
6e5ab41b1 Stephen Boyd   2015-04-30  2205   * Dynamically adds a clk to the debugfs clk directory if debugfs has been
6e5ab41b1 Stephen Boyd   2015-04-30  2206   * initialized.  Otherwise it bails out early since the debugfs clk directory
4dff95dc9 Stephen Boyd   2015-04-30  2207   * will be created lazily by clk_debug_init as part of a late_initcall.
4dff95dc9 Stephen Boyd   2015-04-30  2208   */
4dff95dc9 Stephen Boyd   2015-04-30  2209  static int clk_debug_register(struct clk_core *core)
4dff95dc9 Stephen Boyd   2015-04-30  2210  {
4dff95dc9 Stephen Boyd   2015-04-30  2211  	int ret = 0;
b2476490e Mike Turquette 2012-03-15  2212  
4dff95dc9 Stephen Boyd   2015-04-30  2213  	mutex_lock(&clk_debug_lock);
4dff95dc9 Stephen Boyd   2015-04-30  2214  	hlist_add_head(&core->debug_node, &clk_debug_list);
b2476490e Mike Turquette 2012-03-15  2215  
4dff95dc9 Stephen Boyd   2015-04-30  2216  	if (!inited)
4dff95dc9 Stephen Boyd   2015-04-30  2217  		goto unlock;
b2476490e Mike Turquette 2012-03-15  2218  
4dff95dc9 Stephen Boyd   2015-04-30  2219  	ret = clk_debug_create_one(core, rootdir);
4dff95dc9 Stephen Boyd   2015-04-30  2220  unlock:
4dff95dc9 Stephen Boyd   2015-04-30  2221  	mutex_unlock(&clk_debug_lock);
b2476490e Mike Turquette 2012-03-15  2222  
b2476490e Mike Turquette 2012-03-15  2223  	return ret;
b2476490e Mike Turquette 2012-03-15  2224  }
035a61c31 Tomeu Vizoso   2015-01-23  2225  
035a61c31 Tomeu Vizoso   2015-01-23  2226   /**
6e5ab41b1 Stephen Boyd   2015-04-30  2227   * clk_debug_unregister - remove a clk node from the debugfs clk directory
6e5ab41b1 Stephen Boyd   2015-04-30  2228   * @core: the clk being removed from the debugfs clk directory
035a61c31 Tomeu Vizoso   2015-01-23  2229   *
6e5ab41b1 Stephen Boyd   2015-04-30  2230   * Dynamically removes a clk and all its child nodes from the
6e5ab41b1 Stephen Boyd   2015-04-30  2231   * debugfs clk directory if clk->dentry points to debugfs created by
706d5c73e Stephen Boyd   2016-02-22  2232   * clk_debug_register in __clk_core_init.
035a61c31 Tomeu Vizoso   2015-01-23  2233   */
4dff95dc9 Stephen Boyd   2015-04-30  2234  static void clk_debug_unregister(struct clk_core *core)
035a61c31 Tomeu Vizoso   2015-01-23  2235  {
4dff95dc9 Stephen Boyd   2015-04-30  2236  	mutex_lock(&clk_debug_lock);
4dff95dc9 Stephen Boyd   2015-04-30  2237  	hlist_del_init(&core->debug_node);
4dff95dc9 Stephen Boyd   2015-04-30 @2238  	debugfs_remove_recursive(core->dentry);
4dff95dc9 Stephen Boyd   2015-04-30  2239  	core->dentry = NULL;
4dff95dc9 Stephen Boyd   2015-04-30  2240  	mutex_unlock(&clk_debug_lock);
4dff95dc9 Stephen Boyd   2015-04-30  2241  }
035a61c31 Tomeu Vizoso   2015-01-23  2242  
4dff95dc9 Stephen Boyd   2015-04-30  2243  struct dentry *clk_debugfs_add_file(struct clk_hw *hw, char *name, umode_t mode,
4dff95dc9 Stephen Boyd   2015-04-30  2244  				void *data, const struct file_operations *fops)
4dff95dc9 Stephen Boyd   2015-04-30  2245  {
4dff95dc9 Stephen Boyd   2015-04-30  2246  	struct dentry *d = NULL;
4dff95dc9 Stephen Boyd   2015-04-30  2247  
4dff95dc9 Stephen Boyd   2015-04-30  2248  	if (hw->core->dentry)
4dff95dc9 Stephen Boyd   2015-04-30 @2249  		d = debugfs_create_file(name, mode, hw->core->dentry, data,
4dff95dc9 Stephen Boyd   2015-04-30  2250  					fops);
4dff95dc9 Stephen Boyd   2015-04-30  2251  
4dff95dc9 Stephen Boyd   2015-04-30  2252  	return d;

:::::: The code at line 2148 was first introduced by commit
:::::: 4dff95dc9477a34de77d24c59dcf1dc593687fcf clk: Remove forward declared function prototypes

:::::: TO: Stephen Boyd <sboyd@codeaurora.org>
:::::: CC: Stephen Boyd <sboyd@codeaurora.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 29650 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160630/5aad5557/attachment-0001.obj>
