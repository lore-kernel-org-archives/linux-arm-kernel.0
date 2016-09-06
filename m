From: lkp@intel.com (kbuild test robot)
Date: Tue, 6 Sep 2016 11:40:18 +0800
Subject: [PATCH v10 5/5] drm/rockchip: Add dmc notifier in vop driver
In-Reply-To: <1473051971-5500-6-git-send-email-hl@rock-chips.com>
Message-ID: <201609061108.69VosfD1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lin,

[auto build test ERROR on next-20160825]
[cannot apply to rockchip/for-next devfreq/for-rafael linus/master v4.8-rc5 v4.8-rc4 v4.8-rc3 v4.8-rc5]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Lin-Huang/rk3399-support-ddr-frequency-scaling/20160905-131110
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1124:16: note: (near initialization for 'vop_crtc_helper_funcs.mode_fixup')
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1125:18: error: initializer element is not constant
     .atomic_flush = vop_crtc_atomic_flush,
                     ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1125:18: note: (near initialization for 'vop_crtc_helper_funcs.atomic_flush')
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1126:18: error: initializer element is not constant
     .atomic_begin = vop_crtc_atomic_begin,
                     ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1126:18: note: (near initialization for 'vop_crtc_helper_funcs.atomic_begin')
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1129:13: error: invalid storage class for function 'vop_crtc_destroy'
    static void vop_crtc_destroy(struct drm_crtc *crtc)
                ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1134:13: error: invalid storage class for function 'vop_crtc_reset'
    static void vop_crtc_reset(struct drm_crtc *crtc)
                ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1145:31: error: invalid storage class for function 'vop_crtc_duplicate_state'
    static struct drm_crtc_state *vop_crtc_duplicate_state(struct drm_crtc *crtc)
                                  ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1157:13: error: invalid storage class for function 'vop_crtc_destroy_state'
    static void vop_crtc_destroy_state(struct drm_crtc *crtc,
                ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1169:13: error: initializer element is not constant
     .destroy = vop_crtc_destroy,
                ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1169:13: note: (near initialization for 'vop_crtc_funcs.destroy')
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1170:11: error: initializer element is not constant
     .reset = vop_crtc_reset,
              ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1170:11: note: (near initialization for 'vop_crtc_funcs.reset')
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1171:28: error: initializer element is not constant
     .atomic_duplicate_state = vop_crtc_duplicate_state,
                               ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1171:28: note: (near initialization for 'vop_crtc_funcs.atomic_duplicate_state')
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1172:26: error: initializer element is not constant
     .atomic_destroy_state = vop_crtc_destroy_state,
                             ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1172:26: note: (near initialization for 'vop_crtc_funcs.atomic_destroy_state')
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1175:13: error: invalid storage class for function 'vop_win_pending_is_complete'
    static bool vop_win_pending_is_complete(struct vop_win *vop_win)
                ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1187:13: error: invalid storage class for function 'vop_handle_vblank'
    static void vop_handle_vblank(struct vop *vop)
                ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1213:20: error: invalid storage class for function 'vop_isr'
    static irqreturn_t vop_isr(int irq, void *data)
                       ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1259:12: error: invalid storage class for function 'vop_create_crtc'
    static int vop_create_crtc(struct vop *vop)
               ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1359:13: error: invalid storage class for function 'vop_destroy_crtc'
    static void vop_destroy_crtc(struct vop *vop)
                ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1387:12: error: invalid storage class for function 'vop_initial'
    static int vop_initial(struct vop *vop)
               ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1487:13: error: invalid storage class for function 'vop_win_init'
    static void vop_win_init(struct vop *vop)
                ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1501:12: error: invalid storage class for function 'vop_bind'
    static int vop_bind(struct device *dev, struct device *master, void *data)
               ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1596:13: error: invalid storage class for function 'vop_unbind'
    static void vop_unbind(struct device *dev, struct device *master, void *data)
                ^
   In file included from include/linux/linkage.h:6:0,
                    from include/linux/kernel.h:6,
                    from include/linux/list.h:8,
                    from include/linux/agp_backend.h:33,
                    from include/drm/drmP.h:35,
                    from drivers/gpu/drm/rockchip/rockchip_drm_vop.c:16:
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1608:19: error: extern declaration of 'vop_component_ops' follows declaration with no linkage
    EXPORT_SYMBOL_GPL(vop_component_ops);
                      ^
   include/linux/export.h:57:21: note: in definition of macro '___EXPORT_SYMBOL'
     extern typeof(sym) sym;     \
                        ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1608:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(vop_component_ops);
    ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1604:28: note: previous definition of 'vop_component_ops' was here
    const struct component_ops vop_component_ops = {
                               ^
   In file included from include/linux/linkage.h:6:0,
                    from include/linux/kernel.h:6,
                    from include/linux/list.h:8,
                    from include/linux/agp_backend.h:33,
                    from include/drm/drmP.h:35,
                    from drivers/gpu/drm/rockchip/rockchip_drm_vop.c:16:
   include/linux/export.h:63:25: warning: '__used__' attribute ignored [-Wattributes]
     __visible const struct kernel_symbol __ksymtab_##sym \
                            ^
   include/linux/export.h:94:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^
   include/linux/export.h:101:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1608:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(vop_component_ops);
    ^
>> include/linux/export.h:63:39: error: section attribute cannot be specified for local variables
     __visible const struct kernel_symbol __ksymtab_##sym \
                                          ^
   include/linux/export.h:94:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^
   include/linux/export.h:101:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1608:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(vop_component_ops);
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
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1608:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(vop_component_ops);
    ^
   include/linux/export.h:63:39: error: declaration of '__ksymtab_vop_component_ops' with no linkage follows extern declaration
     __visible const struct kernel_symbol __ksymtab_##sym \
                                          ^
   include/linux/export.h:94:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^
   include/linux/export.h:101:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1608:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(vop_component_ops);
    ^
   include/linux/export.h:62:36: note: previous declaration of '__ksymtab_vop_component_ops' was here
     extern const struct kernel_symbol __ksymtab_##sym; \
                                       ^
   include/linux/export.h:94:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^
   include/linux/export.h:101:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1608:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(vop_component_ops);
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
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1608:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(vop_component_ops);
    ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c: At top level:
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:557:13: warning: 'vop_crtc_disable' defined but not used [-Wunused-function]
    static void vop_crtc_disable(struct drm_crtc *crtc)
                ^

vim +63 include/linux/export.h

f5016932 Paul Gortmaker  2011-05-23  57  	extern typeof(sym) sym;					\
f5016932 Paul Gortmaker  2011-05-23  58  	__CRC_SYMBOL(sym, sec)					\
f5016932 Paul Gortmaker  2011-05-23  59  	static const char __kstrtab_##sym[]			\
f5016932 Paul Gortmaker  2011-05-23  60  	__attribute__((section("__ksymtab_strings"), aligned(1))) \
b92021b0 Rusty Russell   2013-03-15  61  	= VMLINUX_SYMBOL_STR(sym);				\
7b4ec8dd Johannes Berg   2014-01-16  62  	extern const struct kernel_symbol __ksymtab_##sym;	\
e0f244c6 Andi Kleen      2013-10-23 @63  	__visible const struct kernel_symbol __ksymtab_##sym	\
f5016932 Paul Gortmaker  2011-05-23  64  	__used							\
f5016932 Paul Gortmaker  2011-05-23  65  	__attribute__((section("___ksymtab" sec "+" #sym), unused))	\
f5016932 Paul Gortmaker  2011-05-23  66  	= { (unsigned long)&sym, __kstrtab_##sym }
f5016932 Paul Gortmaker  2011-05-23  67  
c1a95fda Nicolas Pitre   2016-01-22  68  #if defined(__KSYM_DEPS__)
c1a95fda Nicolas Pitre   2016-01-22  69  
c1a95fda Nicolas Pitre   2016-01-22  70  /*
c1a95fda Nicolas Pitre   2016-01-22  71   * For fine grained build dependencies, we want to tell the build system
c1a95fda Nicolas Pitre   2016-01-22  72   * about each possible exported symbol even if they're not actually exported.
c1a95fda Nicolas Pitre   2016-01-22  73   * We use a string pattern that is unlikely to be valid code that the build
c1a95fda Nicolas Pitre   2016-01-22  74   * system filters out from the preprocessor output (see ksym_dep_filter
c1a95fda Nicolas Pitre   2016-01-22  75   * in scripts/Kbuild.include).
c1a95fda Nicolas Pitre   2016-01-22  76   */
c1a95fda Nicolas Pitre   2016-01-22  77  #define __EXPORT_SYMBOL(sym, sec)	=== __KSYM_##sym ===
c1a95fda Nicolas Pitre   2016-01-22  78  
c1a95fda Nicolas Pitre   2016-01-22  79  #elif defined(CONFIG_TRIM_UNUSED_KSYMS)
f2355416 Nicolas Pitre   2016-01-22  80  
f2355416 Nicolas Pitre   2016-01-22  81  #include <linux/kconfig.h>
f2355416 Nicolas Pitre   2016-01-22  82  #include <generated/autoksyms.h>
f2355416 Nicolas Pitre   2016-01-22  83  
f2355416 Nicolas Pitre   2016-01-22  84  #define __EXPORT_SYMBOL(sym, sec)				\
6023d236 Masahiro Yamada 2016-06-14  85  	__cond_export_sym(sym, sec, __is_defined(__KSYM_##sym))
f2355416 Nicolas Pitre   2016-01-22  86  #define __cond_export_sym(sym, sec, conf)			\
f2355416 Nicolas Pitre   2016-01-22  87  	___cond_export_sym(sym, sec, conf)
f2355416 Nicolas Pitre   2016-01-22  88  #define ___cond_export_sym(sym, sec, enabled)			\
f2355416 Nicolas Pitre   2016-01-22  89  	__cond_export_sym_##enabled(sym, sec)
f2355416 Nicolas Pitre   2016-01-22  90  #define __cond_export_sym_1(sym, sec) ___EXPORT_SYMBOL(sym, sec)
f2355416 Nicolas Pitre   2016-01-22  91  #define __cond_export_sym_0(sym, sec) /* nothing */
f2355416 Nicolas Pitre   2016-01-22  92  
f2355416 Nicolas Pitre   2016-01-22  93  #else
f2355416 Nicolas Pitre   2016-01-22 @94  #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
f2355416 Nicolas Pitre   2016-01-22  95  #endif
f2355416 Nicolas Pitre   2016-01-22  96  
f5016932 Paul Gortmaker  2011-05-23  97  #define EXPORT_SYMBOL(sym)					\

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
Size: 38827 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160906/a4c3cb58/attachment-0001.obj>
