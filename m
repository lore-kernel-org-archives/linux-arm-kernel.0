From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 14 Feb 2013 12:18:16 +0000
Subject: [PATCH] arm: arch_timer: include linux/errno.h to declare ENXIO
In-Reply-To: <1360778746-27809-1-git-send-email-swarren@wwwdotorg.org>
References: <1360778746-27809-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130214121816.GA25537@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 06:05:46PM +0000, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This fixes:
> arch/arm/kernel/arch_timer.c: In function ?arch_timer_sched_clock_init?:
> arch/arm/kernel/arch_timer.c:55:11: error: ?ENXIO? undeclared (first use in this function)
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> tegra_defconfig builds OK, but with my local change to convert Tegra to
> multi-platform, I need this fix to compile. This issue is new sometime
> after next-20130211.
> 
>  arch/arm/kernel/arch_timer.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
> index 36ebcf4..8fba00f 100644
> --- a/arch/arm/kernel/arch_timer.c
> +++ b/arch/arm/kernel/arch_timer.c
> @@ -8,6 +8,7 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> +#include <linux/errno.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
>  
> -- 
> 1.7.10.4
> 

We should probably also add this to include/clocksource/arm_arch_timer.h and
drivers/clocksource/arm_arch_timer.c, as they both use errno values (though
currently these get included indirectly via a different path).

Thanks,
Mark.
