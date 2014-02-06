From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Thu, 06 Feb 2014 21:29:58 +0530
Subject: [PATCH 2/2] ARM64: powernv: remove redundant cpuidle_idle_call()
In-Reply-To: <1391696188-14540-2-git-send-email-nicolas.pitre@linaro.org>
References: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
 <1391696188-14540-2-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <52F3B17E.4040209@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

powernv in the subject of the patch?

Regards
Preeti U Murthy
On 02/06/2014 07:46 PM, Nicolas Pitre wrote:
> The core idle loop now takes care of it.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm64/kernel/process.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 1c0a9be2ff..9cce0098f4 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -33,7 +33,6 @@
>  #include <linux/kallsyms.h>
>  #include <linux/init.h>
>  #include <linux/cpu.h>
> -#include <linux/cpuidle.h>
>  #include <linux/elfcore.h>
>  #include <linux/pm.h>
>  #include <linux/tick.h>
> @@ -94,10 +93,8 @@ void arch_cpu_idle(void)
>  	 * This should do all the clock switching and wait for interrupt
>  	 * tricks
>  	 */
> -	if (cpuidle_idle_call()) {
> -		cpu_do_idle();
> -		local_irq_enable();
> -	}
> +	cpu_do_idle();
> +	local_irq_enable();
>  }
> 
>  #ifdef CONFIG_HOTPLUG_CPU
> 
