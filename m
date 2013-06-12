From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 12 Jun 2013 15:25:32 +0100
Subject: [PATCH] ARM: arch_timer: add missing include for of_* functions
In-Reply-To: <1370969344-25764-1-git-send-email-jonathan.austin@arm.com>
References: <1370969344-25764-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <20130612142532.GA27414@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 05:49:04PM +0100, Jonathan Austin wrote:
> The arch timer code uses a bunch of of_* functions that are defined in
> linux/of.h. Currently this header is not included but with CONFIG_OF defined
> the functions are available anyway.
> 
> This was discovered because in the case that CONFIG_OF=n and ARM_ARCH_TIMER is
> selected, the kernel no longer builds due to the lack of this header.
> This patch fixes that (though without another patch
> - https://patchwork.kernel.org/patch/2242291/ - the build still fails due to
> a missing stub for of_find_matching_node())
> 
> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>

Makes sense to me.

Acked-by: Mark Rutland <mark.rutland@arm.com>

> ---
> 
> It seems to me that, no matter what your opinion on whether CONFIG_OF=n with
> CONFIG_ARM_ARCH_TIMER=y makes sense, we should fix this particular missing
> include.
> 
> Jonny
> 
>  drivers/clocksource/arm_arch_timer.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index d7ad425..c716ffa 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -15,6 +15,7 @@
>  #include <linux/cpu.h>
>  #include <linux/clockchips.h>
>  #include <linux/interrupt.h>
> +#include <linux/of.h>
>  #include <linux/of_irq.h>
>  #include <linux/io.h>
>  
> -- 
> 1.7.9.5
> 
