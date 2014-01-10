From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 10 Jan 2014 10:56:16 +0000
Subject: LSK merge linux-stable review
In-Reply-To: <52CF61CC.40305@linaro.org>
References: <20140110013011.GA6447@alex-shi>
 <52CF61CC.40305@linaro.org>
Message-ID: <20140110105615.GD925@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 02:58:20AM +0000, Alex Shi wrote:
> commit 450cdfa9c5713551ab1438ab210679868b52a994
> Merge: bf78886 8b4ed85
> Author: Alex Shi <alex.shi@linaro.org>
> Date:   Fri Jan 10 10:50:57 2014 +0800
> 
>     Merge remote-tracking branch 'stable/linux-3.10.y' into linux-linaro-lsk
>     
>     Conflicts:
>         arch/arm64/kernel/smp.c
>     
>     Signed-off-by: Alex Shi <alex.shi@linaro.org>
> 
> diff --cc arch/arm64/kernel/smp.c
> index 5e9d274,9c93e12..87340fd
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@@ -150,17 -187,17 +150,10 @@@ asmlinkage void __cpuinit secondary_sta
>         preempt_disable();
>         trace_hardirqs_off();
>   
>  -      /*
>  -       * Let the primary processor know we're out of the
>  -       * pen, then head off into the C entry point
>  -       */
>  -      write_pen_release(INVALID_HWID);
>  +      if (cpu_ops[cpu]->cpu_postboot)
>  +              cpu_ops[cpu]->cpu_postboot();
>   
> --      /*
> -        * Enable local interrupts.
> -        */
> -       notify_cpu_starting(cpu);

This kind of diff always confuses me but notify_cpu_starting() should be
present in the resulting file. Is it further down?

-- 
Catalin
