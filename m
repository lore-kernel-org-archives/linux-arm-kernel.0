From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 May 2014 12:38:10 -0700
Subject: [GIT PULL 2nd 1/2] Samsung cleanup for 3.16
In-Reply-To: <032f01cf788a$4bfebf40$e3fc3dc0$@samsung.com>
References: <032f01cf788a$4bfebf40$e3fc3dc0$@samsung.com>
Message-ID: <20140529193810.GD18481@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 11:29:19AM +0900, Kukjin Kim wrote:
> Hi Arnd, Olof, Kevin
> 
> Here is 2nd Samsung updates for 3.16 and including cleanup and 2nd dt
> updates.
> 
> When pulling cleanup, merge conflict will be happened like following.
> 
> diff --cc arch/arm/mach-exynos/firmware.c
> index 4135edb,f6cb510..0000000
> --- a/arch/arm/mach-exynos/firmware.c
> +++ b/arch/arm/mach-exynos/firmware.c
> @@@ -18,8 -18,6 +18,11 @@@
> 
>   #include <mach/map.h>
> 
> ++<<<<<<< HEAD
>  +#include <plat/cpu.h>
>  +
> ++=======
> ++>>>>>>> v3.16-next/cleanup-samsung
>   #include "common.h"
>   #include "smc.h"
> 
> And its resolution is 'removing inclusion of <plat/cpu.h>', sorry about
> that.
> 
> Note that now exynos cpuidle, soc and multiplatform is waiting for cpufreq
> related ack...
> One more, I re-tagged "samsung-cleanup" and "exynos-cpuidle", so please
> ignore previous tags if you fetched samsung tree.
> 
> If any problems, please kindly let me know.
> 
> Thanks,
> Kukjin
> 
> 
> The following changes since commit b5783dcaed065ae6622a9795a19a4eda748b64f8:
> 
>   Merge branch 'v3.16-next/clk-s3c24xx-3' into v3.16-next/cleanup-samsung
> (2014-05-26 04:04:47 +0900)
> 
> are available in the git repository at:
> 
> 
>   http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-cleanup
> 
> for you to fetch changes up to be1f7c8d7e2bc8b8c76846aa6f276e8d2ef8975a:
> 
>   cpufreq: exynos: Fix the compile error (2014-05-26 04:05:01 +0900)
> 
> ----------------------------------------------------------------
> Samsung cleanup for v3.16
> 
> - use a common macro v7_exit_coherency_flush macro instead of local function
> - cleanup mach-exynos/Makefile and remove inclusion plat/cpu.h in
> mach-exynos
> - migrate exynos macros from plat-samsung to mach-exynos
> - cleanup s3c24xx debug macro/earlyprintk to remove arch dependency
> - fixed compilation error for cpufreq due to moving header in this branch
>   : use of_machine_is_compatible() instead of soc_is_exynos...()
> 
> Note that based on tags/samsung-clk and tags/samsung-fixes.

Merged. Thanks.

-Olof
