From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 27 Jan 2014 09:43:12 +0100
Subject: [PATCH 8/9] X86: remove redundant cpuidle_idle_call()
In-Reply-To: <1390802904-28399-9-git-send-email-nicolas.pitre@linaro.org>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-9-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <52E61C20.50804@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2014 07:08 AM, Nicolas Pitre wrote:
> The core idle loop now takes care of it.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/x86/kernel/process.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 3fb8d95ab8..4505e2a950 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -298,10 +298,7 @@ void arch_cpu_idle_dead(void)
>    */
>   void arch_cpu_idle(void)
>   {
> -	if (cpuidle_idle_call())
> -		x86_idle();
> -	else
> -		local_irq_enable();

For the record, it was pointless to enable the local irq here because it 
is handled by the cpuidle framework when exiting the idle state.

> +	x86_idle();
>   }
>
>   /*
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
