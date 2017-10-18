From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 18 Oct 2017 17:11:57 +0100
Subject: [arm-platforms:irq/irqchip-4.15 7/19]
 drivers/irqchip/irq-gic-v3.c:577:4: note: in expansion of macro 'pr_crit'
In-Reply-To: <201710181942.2M01lPyt%fengguang.wu@intel.com> (kbuild test
 robot's message of "Wed, 18 Oct 2017 19:25:45 +0800")
References: <201710181942.2M01lPyt%fengguang.wu@intel.com>
Message-ID: <87wp3sigfm.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18 2017 at  7:25:45 pm BST, kbuild test robot <fengguang.wu@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/irqchip-4.15
> head:   0beae24927562ef40a444409d2a9a0d162a18ae7
> commit: 0de6aeba71c72a84dfc47568fc68ec187ac4537c [7/19] irqchip/gicv3: Add support for Range Selector (RS) feature
> config: arm-multi_v7_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 0de6aeba71c72a84dfc47568fc68ec187ac4537c
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/printk.h:6:0,
>                     from include/linux/kernel.h:13,
>                     from include/linux/list.h:8,
>                     from include/linux/resource_ext.h:17,
>                     from include/linux/acpi.h:26,
>                     from drivers/irqchip/irq-gic-v3.c:20:
>    drivers/irqchip/irq-gic-v3.c: In function 'gic_cpu_sys_reg_init':
>>> include/linux/kern_levels.h:4:18: warning: format '%llx' expects
>>> argument of type 'long long unsigned int', but argument 5 has type
>>> 'u32 {aka unsigned int}' [-Wformat=]
>     #define KERN_SOH "\001"  /* ASCII Start Of Header */
>                      ^
>    include/linux/kern_levels.h:9:19: note: in expansion of macro 'KERN_SOH'
>     #define KERN_CRIT KERN_SOH "2" /* critical conditions */
>                       ^~~~~~~~
>>> include/linux/printk.h:299:9: note: in expansion of macro 'KERN_CRIT'
>      printk(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
>             ^~~~~~~~~
>>> drivers/irqchip/irq-gic-v3.c:577:4: note: in expansion of macro 'pr_crit'
>        pr_crit("CPU%d (%llx) can't SGI CPU%d (%llx), no RSS\n",
>        ^~~~~~~
> --
>    In file included from include/linux/printk.h:6:0,
>                     from include/linux/kernel.h:13,
>                     from include/linux/list.h:8,
>                     from include/linux/resource_ext.h:17,
>                     from include/linux/acpi.h:26,
>                     from drivers//irqchip/irq-gic-v3.c:20:
>    drivers//irqchip/irq-gic-v3.c: In function 'gic_cpu_sys_reg_init':
>>> include/linux/kern_levels.h:4:18: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'u32 {aka unsigned int}' [-Wformat=]
>     #define KERN_SOH "\001"  /* ASCII Start Of Header */
>                      ^
>    include/linux/kern_levels.h:9:19: note: in expansion of macro 'KERN_SOH'
>     #define KERN_CRIT KERN_SOH "2" /* critical conditions */
>                       ^~~~~~~~
>>> include/linux/printk.h:299:9: note: in expansion of macro 'KERN_CRIT'
>      printk(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
>             ^~~~~~~~~
>    drivers//irqchip/irq-gic-v3.c:577:4: note: in expansion of macro 'pr_crit'
>        pr_crit("CPU%d (%llx) can't SGI CPU%d (%llx), no RSS\n",
>        ^~~~~~~

[...]

Fixes for all 3 issues pushed out as fixups. I'll squash them before
sending out the pull request.

Thanks for the heads up!

	M.
-- 
Jazz is not dead, it just smell funny.
