From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Thu, 20 Jul 2017 13:47:27 +0000
Subject: [PATCH 7/7] staging: fsl-mc: allow the driver compile multi-arch
In-Reply-To: <201707200109.nheGR4xf%fengguang.wu@intel.com>
References: <201707200109.nheGR4xf%fengguang.wu@intel.com>
Message-ID: <5970B46F.2000807@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sparc seems to be broken in multiple places, including generic code.
Is this a known issue?
Is there something I could/should do?

---
Thanks & Best Regards, Laurentiu

On 07/19/2017 08:31 PM, kbuild test robot wrote:
> Hi Laurentiu,
>
> [auto build test ERROR on staging/staging-testing]
> [also build test ERROR on v4.13-rc1 next-20170718]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2F0day-ci%2Flinux%2Fcommits%2Flaurentiu-tudor-nxp-com%2Fstaging-fsl-mc-make-the-driver-compile-on-other-architectures%2F20170718-021715&data=01%7C01%7Claurentiu.tudor%40nxp.com%7C66f7c5619d664f88ce6108d4cecc14f5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0&sdata=HgKrckHRkhwe6PrGHc%2B1UfoT1rCyMw5C5%2B7wdEuvS5s%3D&reserved=0
> config: sparc-allyesconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>          wget https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fraw.githubusercontent.com%2F01org%2Flkp-tests%2Fmaster%2Fsbin%2Fmake.cross&data=01%7C01%7Claurentiu.tudor%40nxp.com%7C66f7c5619d664f88ce6108d4cecc14f5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0&sdata=kFjtWysm4LCK%2BnLcmpogI%2FHRRApSDRcl7QWofLo0%2FDY%3D&reserved=0 -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=sparc
>
> All error/warnings (new ones prefixed by >>):
>
>     In file included from kernel/irq/chip.c:14:0:
>>> include/linux/msi.h:225:10: error: unknown type name 'msi_alloc_info_t'
>               msi_alloc_info_t *arg);
>               ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:229:9: error: unknown type name 'msi_alloc_info_t'
>              msi_alloc_info_t *arg);
>              ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:238:12: error: unknown type name 'msi_alloc_info_t'
>                 msi_alloc_info_t *arg);
>                 ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:239:22: error: unknown type name 'msi_alloc_info_t'
>       void  (*msi_finish)(msi_alloc_info_t *arg, int retval);
>                           ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:240:20: error: unknown type name 'msi_alloc_info_t'
>       void  (*set_desc)(msi_alloc_info_t *arg,
>                         ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:308:18: error: unknown type name 'msi_alloc_info_t'
>             int nvec, msi_alloc_info_t *args);
>                       ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:310:29: error: unknown type name 'msi_alloc_info_t'
>              int virq, int nvec, msi_alloc_info_t *args);
>                                  ^~~~~~~~~~~~~~~~
> --
>     In file included from kernel/irq/msi.c:16:0:
>>> include/linux/msi.h:225:10: error: unknown type name 'msi_alloc_info_t'
>               msi_alloc_info_t *arg);
>               ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:229:9: error: unknown type name 'msi_alloc_info_t'
>              msi_alloc_info_t *arg);
>              ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:238:12: error: unknown type name 'msi_alloc_info_t'
>                 msi_alloc_info_t *arg);
>                 ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:239:22: error: unknown type name 'msi_alloc_info_t'
>       void  (*msi_finish)(msi_alloc_info_t *arg, int retval);
>                           ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:240:20: error: unknown type name 'msi_alloc_info_t'
>       void  (*set_desc)(msi_alloc_info_t *arg,
>                         ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:308:18: error: unknown type name 'msi_alloc_info_t'
>             int nvec, msi_alloc_info_t *args);
>                       ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:310:29: error: unknown type name 'msi_alloc_info_t'
>              int virq, int nvec, msi_alloc_info_t *args);
>                                  ^~~~~~~~~~~~~~~~
>     kernel/irq/msi.c: In function 'msi_domain_alloc':
>>> kernel/irq/msi.c:126:29: error: 'struct msi_domain_ops' has no member named 'get_hwirq'
>       irq_hw_number_t hwirq = ops->get_hwirq(info, arg);
>                                  ^~
>>> kernel/irq/msi.c:139:12: error: 'struct msi_domain_ops' has no member named 'msi_init'; did you mean 'msi_free'?
>        ret = ops->msi_init(domain, info, virq + i, hwirq + i, arg);
>                 ^~
>     kernel/irq/msi.c: At top level:
>>> kernel/irq/msi.c:201:11: error: unknown type name 'msi_alloc_info_t'
>                msi_alloc_info_t *arg)
>                ^~~~~~~~~~~~~~~~
>>> kernel/irq/msi.c:221:2: error: unknown field 'get_hwirq' specified in initializer
>       .get_hwirq = msi_domain_ops_get_hwirq,
>       ^
>>> kernel/irq/msi.c:222:2: error: unknown field 'msi_init' specified in initializer
>       .msi_init = msi_domain_ops_init,
>       ^
>>> kernel/irq/msi.c:222:14: error: 'msi_domain_ops_init' undeclared here (not in a function)
>       .msi_init = msi_domain_ops_init,
>                   ^~~~~~~~~~~~~~~~~~~
>>> kernel/irq/msi.c:224:2: error: unknown field 'msi_prepare' specified in initializer
>       .msi_prepare = msi_domain_ops_prepare,
>       ^
>>> kernel/irq/msi.c:225:2: error: unknown field 'set_desc' specified in initializer
>       .set_desc = msi_domain_ops_set_desc,
>       ^
>     In file included from include/uapi/linux/posix_types.h:4:0,
>                      from include/uapi/linux/types.h:13,
>                      from include/linux/types.h:5,
>                      from kernel/irq/msi.c:12:
>     include/linux/stddef.h:7:14: warning: excess elements in struct initializer
>      #define NULL ((void *)0)
>                   ^
>>> kernel/irq/msi.c:195:34: note: in expansion of macro 'NULL'
>      #define msi_domain_ops_set_desc  NULL
>                                       ^~~~
>>> kernel/irq/msi.c:225:14: note: in expansion of macro 'msi_domain_ops_set_desc'
>       .set_desc = msi_domain_ops_set_desc,
>                   ^~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/stddef.h:7:14: note: (near initialization for 'msi_domain_ops_default')
>      #define NULL ((void *)0)
>                   ^
>>> kernel/irq/msi.c:195:34: note: in expansion of macro 'NULL'
>      #define msi_domain_ops_set_desc  NULL
>                                       ^~~~
>>> kernel/irq/msi.c:225:14: note: in expansion of macro 'msi_domain_ops_set_desc'
>       .set_desc = msi_domain_ops_set_desc,
>                   ^~~~~~~~~~~~~~~~~~~~~~~
>     kernel/irq/msi.c: In function 'msi_domain_update_dom_ops':
>     kernel/irq/msi.c:237:9: error: 'struct msi_domain_ops' has no member named 'get_hwirq'
>       if (ops->get_hwirq == NULL)
>              ^~
>     kernel/irq/msi.c:238:6: error: 'struct msi_domain_ops' has no member named 'get_hwirq'
>        ops->get_hwirq = msi_domain_ops_default.get_hwirq;
>           ^~
>     kernel/irq/msi.c:238:42: error: 'struct msi_domain_ops' has no member named 'get_hwirq'
>        ops->get_hwirq = msi_domain_ops_default.get_hwirq;
>                                               ^
>     kernel/irq/msi.c:239:9: error: 'struct msi_domain_ops' has no member named 'msi_init'; did you mean 'msi_free'?
>       if (ops->msi_init == NULL)
>              ^~
>     kernel/irq/msi.c:240:6: error: 'struct msi_domain_ops' has no member named 'msi_init'; did you mean 'msi_free'?
>        ops->msi_init = msi_domain_ops_default.msi_init;
>           ^~
>     kernel/irq/msi.c:240:41: error: 'struct msi_domain_ops' has no member named 'msi_init'; did you mean 'msi_free'?
>        ops->msi_init = msi_domain_ops_default.msi_init;
>                                              ^
>>> kernel/irq/msi.c:243:9: error: 'struct msi_domain_ops' has no member named 'msi_prepare'; did you mean 'msi_free'?
>       if (ops->msi_prepare == NULL)
>              ^~
>     kernel/irq/msi.c:244:6: error: 'struct msi_domain_ops' has no member named 'msi_prepare'; did you mean 'msi_free'?
>        ops->msi_prepare = msi_domain_ops_default.msi_prepare;
>           ^~
>     kernel/irq/msi.c:244:44: error: 'struct msi_domain_ops' has no member named 'msi_prepare'; did you mean 'msi_free'?
>        ops->msi_prepare = msi_domain_ops_default.msi_prepare;
>                                                 ^
>>> kernel/irq/msi.c:245:9: error: 'struct msi_domain_ops' has no member named 'set_desc'
>       if (ops->set_desc == NULL)
>              ^~
>     kernel/irq/msi.c:246:6: error: 'struct msi_domain_ops' has no member named 'set_desc'
>        ops->set_desc = msi_domain_ops_default.set_desc;
>           ^~
>     kernel/irq/msi.c:246:41: error: 'struct msi_domain_ops' has no member named 'set_desc'
>        ops->set_desc = msi_domain_ops_default.set_desc;
>                                              ^
>     kernel/irq/msi.c: At top level:
>     kernel/irq/msi.c:285:18: error: unknown type name 'msi_alloc_info_t'
>             int nvec, msi_alloc_info_t *arg)
>                       ^~~~~~~~~~~~~~~~
>     kernel/irq/msi.c:299:29: error: unknown type name 'msi_alloc_info_t'
>              int virq, int nvec, msi_alloc_info_t *arg)
>                                  ^~~~~~~~~~~~~~~~
>     kernel/irq/msi.c: In function 'msi_domain_alloc_irqs':
>     kernel/irq/msi.c:352:2: error: unknown type name 'msi_alloc_info_t'
>       msi_alloc_info_t arg;
>       ^~~~~~~~~~~~~~~~
>>> kernel/irq/msi.c:356:8: error: implicit declaration of function 'msi_domain_prepare_irqs' [-Werror=implicit-function-declaration]
>       ret = msi_domain_prepare_irqs(domain, dev, nvec, &arg);
>             ^~~~~~~~~~~~~~~~~~~~~~~
>     kernel/irq/msi.c:361:6: error: 'struct msi_domain_ops' has no member named 'set_desc'
>        ops->set_desc(&arg, desc);
>           ^~
>>> kernel/irq/msi.c:370:11: error: 'struct msi_domain_ops' has no member named 'msi_finish'; did you mean 'msi_free'?
>         if (ops->msi_finish)
>                ^~
>     kernel/irq/msi.c:371:8: error: 'struct msi_domain_ops' has no member named 'msi_finish'; did you mean 'msi_free'?
>          ops->msi_finish(&arg, ret);
>             ^~
>     kernel/irq/msi.c:379:9: error: 'struct msi_domain_ops' has no member named 'msi_finish'; did you mean 'msi_free'?
>       if (ops->msi_finish)
>              ^~
>     kernel/irq/msi.c:380:6: error: 'struct msi_domain_ops' has no member named 'msi_finish'; did you mean 'msi_free'?
>        ops->msi_finish(&arg, 0);
>           ^~
>     cc1: some warnings being treated as errors
> --
>     In file included from drivers//staging/fsl-mc/bus/fsl-mc-msi.c:17:0:
>>> include/linux/msi.h:225:10: error: unknown type name 'msi_alloc_info_t'
>               msi_alloc_info_t *arg);
>               ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:229:9: error: unknown type name 'msi_alloc_info_t'
>              msi_alloc_info_t *arg);
>              ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:238:12: error: unknown type name 'msi_alloc_info_t'
>                 msi_alloc_info_t *arg);
>                 ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:239:22: error: unknown type name 'msi_alloc_info_t'
>       void  (*msi_finish)(msi_alloc_info_t *arg, int retval);
>                           ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:240:20: error: unknown type name 'msi_alloc_info_t'
>       void  (*set_desc)(msi_alloc_info_t *arg,
>                         ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:308:18: error: unknown type name 'msi_alloc_info_t'
>             int nvec, msi_alloc_info_t *args);
>                       ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:310:29: error: unknown type name 'msi_alloc_info_t'
>              int virq, int nvec, msi_alloc_info_t *args);
>                                  ^~~~~~~~~~~~~~~~
>     drivers//staging/fsl-mc/bus/fsl-mc-msi.c: In function 'fsl_mc_msi_update_dom_ops':
>>> drivers//staging/fsl-mc/bus/fsl-mc-msi.c:56:10: error: 'struct msi_domain_ops' has no member named 'set_desc'
>       if (!ops->set_desc)
>               ^~
>     drivers//staging/fsl-mc/bus/fsl-mc-msi.c:57:6: error: 'struct msi_domain_ops' has no member named 'set_desc'
>        ops->set_desc = fsl_mc_msi_set_desc;
>           ^~
> --
>     In file included from drivers//staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c:15:0:
>>> include/linux/msi.h:225:10: error: unknown type name 'msi_alloc_info_t'
>               msi_alloc_info_t *arg);
>               ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:229:9: error: unknown type name 'msi_alloc_info_t'
>              msi_alloc_info_t *arg);
>              ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:238:12: error: unknown type name 'msi_alloc_info_t'
>                 msi_alloc_info_t *arg);
>                 ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:239:22: error: unknown type name 'msi_alloc_info_t'
>       void  (*msi_finish)(msi_alloc_info_t *arg, int retval);
>                           ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:240:20: error: unknown type name 'msi_alloc_info_t'
>       void  (*set_desc)(msi_alloc_info_t *arg,
>                         ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:308:18: error: unknown type name 'msi_alloc_info_t'
>             int nvec, msi_alloc_info_t *args);
>                       ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:310:29: error: unknown type name 'msi_alloc_info_t'
>              int virq, int nvec, msi_alloc_info_t *args);
>                                  ^~~~~~~~~~~~~~~~
>>> drivers//staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c:30:17: error: unknown type name 'msi_alloc_info_t'
>            int nvec, msi_alloc_info_t *info)
>                      ^~~~~~~~~~~~~~~~
>>> drivers//staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c:56:2: error: unknown field 'msi_prepare' specified in initializer
>       .msi_prepare = its_fsl_mc_msi_prepare,
>       ^
>>> drivers//staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c:56:17: error: 'its_fsl_mc_msi_prepare' undeclared here (not in a function)
>       .msi_prepare = its_fsl_mc_msi_prepare,
>                      ^~~~~~~~~~~~~~~~~~~~~~
> --
>     In file included from drivers//base/platform-msi.c:24:0:
>>> include/linux/msi.h:225:10: error: unknown type name 'msi_alloc_info_t'
>               msi_alloc_info_t *arg);
>               ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:229:9: error: unknown type name 'msi_alloc_info_t'
>              msi_alloc_info_t *arg);
>              ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:238:12: error: unknown type name 'msi_alloc_info_t'
>                 msi_alloc_info_t *arg);
>                 ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:239:22: error: unknown type name 'msi_alloc_info_t'
>       void  (*msi_finish)(msi_alloc_info_t *arg, int retval);
>                           ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:240:20: error: unknown type name 'msi_alloc_info_t'
>       void  (*set_desc)(msi_alloc_info_t *arg,
>                         ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:308:18: error: unknown type name 'msi_alloc_info_t'
>             int nvec, msi_alloc_info_t *args);
>                       ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:310:29: error: unknown type name 'msi_alloc_info_t'
>              int virq, int nvec, msi_alloc_info_t *args);
>                                  ^~~~~~~~~~~~~~~~
>>> drivers//base/platform-msi.c:37:2: error: unknown type name 'msi_alloc_info_t'
>       msi_alloc_info_t arg;
>       ^~~~~~~~~~~~~~~~
>     drivers//base/platform-msi.c: In function 'platform_msi_update_dom_ops':
>>> drivers//base/platform-msi.c:84:9: error: 'struct msi_domain_ops' has no member named 'msi_init'; did you mean 'msi_free'?
>       if (ops->msi_init == NULL)
>              ^~
>     drivers//base/platform-msi.c:85:6: error: 'struct msi_domain_ops' has no member named 'msi_init'; did you mean 'msi_free'?
>        ops->msi_init = platform_msi_init;
>           ^~
>>> drivers//base/platform-msi.c:86:9: error: 'struct msi_domain_ops' has no member named 'set_desc'
>       if (ops->set_desc == NULL)
>              ^~
>     drivers//base/platform-msi.c:87:6: error: 'struct msi_domain_ops' has no member named 'set_desc'
>        ops->set_desc = platform_msi_set_desc;
>           ^~
>     drivers//base/platform-msi.c: In function 'platform_msi_create_device_domain':
>>> drivers//base/platform-msi.c:352:8: error: implicit declaration of function 'msi_domain_prepare_irqs' [-Werror=implicit-function-declaration]
>       err = msi_domain_prepare_irqs(domain->parent, dev, nvec, &data->arg);
>             ^~~~~~~~~~~~~~~~~~~~~~~
>     drivers//base/platform-msi.c: In function 'platform_msi_domain_alloc':
>>> drivers//base/platform-msi.c:410:8: error: implicit declaration of function 'msi_domain_populate_irqs' [-Werror=implicit-function-declaration]
>       err = msi_domain_populate_irqs(domain->parent, data->dev,
>             ^~~~~~~~~~~~~~~~~~~~~~~~
>     cc1: some warnings being treated as errors
> --
>     In file included from kernel//irq/msi.c:16:0:
>>> include/linux/msi.h:225:10: error: unknown type name 'msi_alloc_info_t'
>               msi_alloc_info_t *arg);
>               ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:229:9: error: unknown type name 'msi_alloc_info_t'
>              msi_alloc_info_t *arg);
>              ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:238:12: error: unknown type name 'msi_alloc_info_t'
>                 msi_alloc_info_t *arg);
>                 ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:239:22: error: unknown type name 'msi_alloc_info_t'
>       void  (*msi_finish)(msi_alloc_info_t *arg, int retval);
>                           ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:240:20: error: unknown type name 'msi_alloc_info_t'
>       void  (*set_desc)(msi_alloc_info_t *arg,
>                         ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:308:18: error: unknown type name 'msi_alloc_info_t'
>             int nvec, msi_alloc_info_t *args);
>                       ^~~~~~~~~~~~~~~~
>     include/linux/msi.h:310:29: error: unknown type name 'msi_alloc_info_t'
>              int virq, int nvec, msi_alloc_info_t *args);
>                                  ^~~~~~~~~~~~~~~~
>     kernel//irq/msi.c: In function 'msi_domain_alloc':
>     kernel//irq/msi.c:126:29: error: 'struct msi_domain_ops' has no member named 'get_hwirq'
>       irq_hw_number_t hwirq = ops->get_hwirq(info, arg);
>                                  ^~
>     kernel//irq/msi.c:139:12: error: 'struct msi_domain_ops' has no member named 'msi_init'; did you mean 'msi_free'?
>        ret = ops->msi_init(domain, info, virq + i, hwirq + i, arg);
>                 ^~
>     kernel//irq/msi.c: At top level:
>     kernel//irq/msi.c:201:11: error: unknown type name 'msi_alloc_info_t'
>                msi_alloc_info_t *arg)
>                ^~~~~~~~~~~~~~~~
>     kernel//irq/msi.c:221:2: error: unknown field 'get_hwirq' specified in initializer
>       .get_hwirq = msi_domain_ops_get_hwirq,
>       ^
>     kernel//irq/msi.c:222:2: error: unknown field 'msi_init' specified in initializer
>       .msi_init = msi_domain_ops_init,
>       ^
>     kernel//irq/msi.c:222:14: error: 'msi_domain_ops_init' undeclared here (not in a function)
>       .msi_init = msi_domain_ops_init,
>                   ^~~~~~~~~~~~~~~~~~~
>     kernel//irq/msi.c:224:2: error: unknown field 'msi_prepare' specified in initializer
>       .msi_prepare = msi_domain_ops_prepare,
>       ^
>     kernel//irq/msi.c:225:2: error: unknown field 'set_desc' specified in initializer
>       .set_desc = msi_domain_ops_set_desc,
>       ^
>     In file included from include/uapi/linux/posix_types.h:4:0,
>                      from include/uapi/linux/types.h:13,
>                      from include/linux/types.h:5,
>                      from kernel//irq/msi.c:12:
>     include/linux/stddef.h:7:14: warning: excess elements in struct initializer
>      #define NULL ((void *)0)
>                   ^
>     kernel//irq/msi.c:195:34: note: in expansion of macro 'NULL'
>      #define msi_domain_ops_set_desc  NULL
>                                       ^~~~
>     kernel//irq/msi.c:225:14: note: in expansion of macro 'msi_domain_ops_set_desc'
>       .set_desc = msi_domain_ops_set_desc,
>                   ^~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/stddef.h:7:14: note: (near initialization for 'msi_domain_ops_default')
>      #define NULL ((void *)0)
>                   ^
>     kernel//irq/msi.c:195:34: note: in expansion of macro 'NULL'
>      #define msi_domain_ops_set_desc  NULL
>                                       ^~~~
>     kernel//irq/msi.c:225:14: note: in expansion of macro 'msi_domain_ops_set_desc'
>       .set_desc = msi_domain_ops_set_desc,
>                   ^~~~~~~~~~~~~~~~~~~~~~~
>     kernel//irq/msi.c: In function 'msi_domain_update_dom_ops':
>     kernel//irq/msi.c:237:9: error: 'struct msi_domain_ops' has no member named 'get_hwirq'
>       if (ops->get_hwirq == NULL)
>              ^~
>     kernel//irq/msi.c:238:6: error: 'struct msi_domain_ops' has no member named 'get_hwirq'
>        ops->get_hwirq = msi_domain_ops_default.get_hwirq;
>           ^~
>     kernel//irq/msi.c:238:42: error: 'struct msi_domain_ops' has no member named 'get_hwirq'
>        ops->get_hwirq = msi_domain_ops_default.get_hwirq;
>                                               ^
>     kernel//irq/msi.c:239:9: error: 'struct msi_domain_ops' has no member named 'msi_init'; did you mean 'msi_free'?
>       if (ops->msi_init == NULL)
>              ^~
>     kernel//irq/msi.c:240:6: error: 'struct msi_domain_ops' has no member named 'msi_init'; did you mean 'msi_free'?
>        ops->msi_init = msi_domain_ops_default.msi_init;
>           ^~
>     kernel//irq/msi.c:240:41: error: 'struct msi_domain_ops' has no member named 'msi_init'; did you mean 'msi_free'?
>        ops->msi_init = msi_domain_ops_default.msi_init;
>                                              ^
>     kernel//irq/msi.c:243:9: error: 'struct msi_domain_ops' has no member named 'msi_prepare'; did you mean 'msi_free'?
>       if (ops->msi_prepare == NULL)
>              ^~
>     kernel//irq/msi.c:244:6: error: 'struct msi_domain_ops' has no member named 'msi_prepare'; did you mean 'msi_free'?
>        ops->msi_prepare = msi_domain_ops_default.msi_prepare;
>           ^~
>     kernel//irq/msi.c:244:44: error: 'struct msi_domain_ops' has no member named 'msi_prepare'; did you mean 'msi_free'?
>        ops->msi_prepare = msi_domain_ops_default.msi_prepare;
>                                                 ^
>     kernel//irq/msi.c:245:9: error: 'struct msi_domain_ops' has no member named 'set_desc'
>       if (ops->set_desc == NULL)
>              ^~
>     kernel//irq/msi.c:246:6: error: 'struct msi_domain_ops' has no member named 'set_desc'
> ..
>
> vim +/msi_alloc_info_t +225 include/linux/msi.h
>
> f3cf8bb0 Jiang Liu        2014-11-12  204
> f3cf8bb0 Jiang Liu        2014-11-12  205  /**
> f3cf8bb0 Jiang Liu        2014-11-12  206   * struct msi_domain_ops - MSI interrupt domain callbacks
> f3cf8bb0 Jiang Liu        2014-11-12  207   * @get_hwirq:		Retrieve the resulting hw irq number
> f3cf8bb0 Jiang Liu        2014-11-12  208   * @msi_init:		Domain specific init function for MSI interrupts
> f3cf8bb0 Jiang Liu        2014-11-12  209   * @msi_free:		Domain specific function to free a MSI interrupts
> d9109698 Jiang Liu        2014-11-15  210   * @msi_check:		Callback for verification of the domain/info/dev data
> d9109698 Jiang Liu        2014-11-15  211   * @msi_prepare:	Prepare the allocation of the interrupts in the domain
> 1d1e8cdc Thomas Petazzoni 2015-12-21  212   * @msi_finish:		Optional callback to finalize the allocation
> d9109698 Jiang Liu        2014-11-15  213   * @set_desc:		Set the msi descriptor for an interrupt
> d9109698 Jiang Liu        2014-11-15  214   * @handle_error:	Optional error handler if the allocation fails
> d9109698 Jiang Liu        2014-11-15  215   *
> d9109698 Jiang Liu        2014-11-15  216   * @get_hwirq, @msi_init and @msi_free are callbacks used by
> d9109698 Jiang Liu        2014-11-15  217   * msi_create_irq_domain() and related interfaces
> d9109698 Jiang Liu        2014-11-15  218   *
> d9109698 Jiang Liu        2014-11-15  219   * @msi_check, @msi_prepare, @msi_finish, @set_desc and @handle_error
> 1d1e8cdc Thomas Petazzoni 2015-12-21  220   * are callbacks used by msi_domain_alloc_irqs() and related
> d9109698 Jiang Liu        2014-11-15  221   * interfaces which are based on msi_desc.
> f3cf8bb0 Jiang Liu        2014-11-12  222   */
> f3cf8bb0 Jiang Liu        2014-11-12  223  struct msi_domain_ops {
> aeeb5965 Jiang Liu        2014-11-15  224  	irq_hw_number_t	(*get_hwirq)(struct msi_domain_info *info,
> aeeb5965 Jiang Liu        2014-11-15 @225  				     msi_alloc_info_t *arg);
> f3cf8bb0 Jiang Liu        2014-11-12  226  	int		(*msi_init)(struct irq_domain *domain,
> f3cf8bb0 Jiang Liu        2014-11-12  227  				    struct msi_domain_info *info,
> f3cf8bb0 Jiang Liu        2014-11-12  228  				    unsigned int virq, irq_hw_number_t hwirq,
> aeeb5965 Jiang Liu        2014-11-15  229  				    msi_alloc_info_t *arg);
> f3cf8bb0 Jiang Liu        2014-11-12  230  	void		(*msi_free)(struct irq_domain *domain,
> f3cf8bb0 Jiang Liu        2014-11-12  231  				    struct msi_domain_info *info,
> f3cf8bb0 Jiang Liu        2014-11-12  232  				    unsigned int virq);
> d9109698 Jiang Liu        2014-11-15  233  	int		(*msi_check)(struct irq_domain *domain,
> d9109698 Jiang Liu        2014-11-15  234  				     struct msi_domain_info *info,
> d9109698 Jiang Liu        2014-11-15  235  				     struct device *dev);
> d9109698 Jiang Liu        2014-11-15  236  	int		(*msi_prepare)(struct irq_domain *domain,
> d9109698 Jiang Liu        2014-11-15  237  				       struct device *dev, int nvec,
> d9109698 Jiang Liu        2014-11-15  238  				       msi_alloc_info_t *arg);
> d9109698 Jiang Liu        2014-11-15  239  	void		(*msi_finish)(msi_alloc_info_t *arg, int retval);
> d9109698 Jiang Liu        2014-11-15  240  	void		(*set_desc)(msi_alloc_info_t *arg,
> d9109698 Jiang Liu        2014-11-15  241  				    struct msi_desc *desc);
> d9109698 Jiang Liu        2014-11-15  242  	int		(*handle_error)(struct irq_domain *domain,
> d9109698 Jiang Liu        2014-11-15  243  					struct msi_desc *desc, int error);
> f3cf8bb0 Jiang Liu        2014-11-12  244  };
> f3cf8bb0 Jiang Liu        2014-11-12  245
>
> :::::: The code at line 225 was first introduced by commit
> :::::: aeeb59657c35da64068336c20068da237f41ab76 genirq: Provide default callbacks for msi_domain_ops
>
> :::::: TO: Jiang Liu <jiang.liu@linux.intel.com>
> :::::: CC: Thomas Gleixner <tglx@linutronix.de>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.01.org%2Fpipermail%2Fkbuild-all&data=01%7C01%7Claurentiu.tudor%40nxp.com%7C66f7c5619d664f88ce6108d4cecc14f5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0&sdata=hceaX47eTei7tR91loXYyGufa3dPQhBqyS7R212VcUw%3D&reserved=0                   Intel Corporation
>
