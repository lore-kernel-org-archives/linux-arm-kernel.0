From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 05 Sep 2016 09:49:19 +0900
Subject: [PATCH 4/5] PM / devfreq: rockchip: add devfreq driver for rk3399
 dmc
In-Reply-To: <201609020953.NltUDqVg%fengguang.wu@intel.com>
References: <CGME20160902012350epcas1p2045d076c7645d3880e95633d66aba0ae@epcas1p2.samsung.com>
 <201609020953.NltUDqVg%fengguang.wu@intel.com>
Message-ID: <57CCC10F.30704@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

This patch rely on both rockchip.git and devfreq.git.
Already, Rockchip SoC Maintainer (Heiko Stuebner) created
the immutable branch[1]. When applying these patches
on devfreq.git with pulling the immutable branch[1],
It looks like that should not be a problem.

[1] http://www.spinics.net/lists/arm-kernel/msg528298.html

Best Regards,
Chanwoo Choi

On 2016? 09? 02? 10:23, kbuild test robot wrote:
> Hi Lin,
> 
> [auto build test ERROR on next-20160825]
> [also build test ERROR on v4.8-rc4]
> [cannot apply to rockchip/for-next devfreq/for-rafael linus/master v4.8-rc4 v4.8-rc3 v4.8-rc2]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> [Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
> [Check https://git-scm.com/docs/git-format-patch for more information]
> 
> url:    https://github.com/0day-ci/linux/commits/Lin-Huang/rk3399-support-ddr-frequency-scaling/20160902-063701
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/devfreq/rk3399_dmc.c:29:39: fatal error: soc/rockchip/rockchip_sip.h: No such file or directory
>    compilation terminated.
> 
> vim +29 drivers/devfreq/rk3399_dmc.c
> 
>     23	#include <linux/platform_device.h>
>     24	#include <linux/pm_opp.h>
>     25	#include <linux/regulator/consumer.h>
>     26	#include <linux/rwsem.h>
>     27	#include <linux/suspend.h>
>     28	
>   > 29	#include <soc/rockchip/rockchip_sip.h>
>     30	
>     31	struct dram_timing {
>     32		unsigned int ddr3_speed_bin;
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
