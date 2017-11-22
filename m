From: rdunlap@infradead.org (Randy Dunlap)
Date: Tue, 21 Nov 2017 23:51:57 -0800
Subject: [PATCH] media: mtk-vcodec: add missing MODULE_LICENSE/DESCRIPTION
In-Reply-To: <201711221521.lmq1l8ci%fengguang.wu@intel.com>
References: <20171120062607.124734-1-jc@linux.com>
 <201711221521.lmq1l8ci%fengguang.wu@intel.com>
Message-ID: <835d88de-989e-03c7-e647-819f8f200f1b@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/17 23:41, kbuild test robot wrote:
> Hi Jesse,
> 
> Thank you for the patch! Yet something to improve:

missing
#include <linux/module.h>

Jesse, did you build all of these driver changes?


> [auto build test ERROR on linuxtv-media/master]
> [also build test ERROR on v4.14 next-20171121]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Jesse-Chan/media-mtk-vcodec-add-missing-MODULE_LICENSE-DESCRIPTION/20171122-124620
> base:   git://linuxtv.org/media_tree.git master
> config: xtensa-allmodconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 4.9.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=xtensa 
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c:55:16: error: expected declaration specifiers or '...' before string constant
>     MODULE_LICENSE("GPL v2");
>                    ^
>    drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c:56:20: error: expected declaration specifiers or '...' before string constant
>     MODULE_DESCRIPTION("Mediatek video codec driver");
>                        ^
> 
> vim +55 drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c
> 
>     54	
>   > 55	MODULE_LICENSE("GPL v2");
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 


-- 
~Randy
