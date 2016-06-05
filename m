From: stefan@agner.ch (Stefan Agner)
Date: Sat, 04 Jun 2016 19:52:38 -0700
Subject: [PATCH 5/5] mfd: rn5t618: register restart handler
In-Reply-To: <201606050940.RZVDWPsV%fengguang.wu@intel.com>
References: <201606050940.RZVDWPsV%fengguang.wu@intel.com>
Message-ID: <7f3c252eb0cb1713a71f8a6b5f52aa93@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-06-04 18:24, kbuild test robot wrote:
> Hi,
> 
> [auto build test ERROR on ljones-mfd/for-mfd-next]
> [also build test ERROR on v4.7-rc1 next-20160603]
> [if your patch is applied to the wrong git tree, please drop us a note
> to help improve the system]
> 
> url:   
> https://github.com/0day-ci/linux/commits/Stefan-Agner/regulator-add-Ricoh-RN5T567-PMIC-support/20160605-082219
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/mfd/rn5t618.c:24:29: fatal error: asm/system_misc.h: No such file or directory
>     #include <asm/system_misc.h>
>                                 ^
>    compilation terminated.
> 
> vim +24 drivers/mfd/rn5t618.c
> 
>     18	#include <linux/mfd/rn5t618.h>
>     19	#include <linux/module.h>
>     20	#include <linux/of_device.h>
>     21	#include <linux/reboot.h>
>     22	#include <linux/regmap.h>
>     23
>   > 24	#include <asm/system_misc.h>

Hm, that is an artifact of the older kernel version for which I wrote
the kernel first where this was required. Will remove this in v2.

--
Stefan

>     25
>     26	static const struct mfd_cell rn5t618_cells[] = {
>     27		{ .name = "rn5t618-regulator" },
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
