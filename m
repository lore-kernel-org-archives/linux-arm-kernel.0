From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Jun 2015 08:40:08 +0100
Subject: [PATCH] ARM: STi: Remove platform call to trace_hardirqs_off()
In-Reply-To: <1433886427-29295-1-git-send-email-peter.griffin@linaro.org>
References: <1433886427-29295-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <20150610074008.GZ2982@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 09 Jun 2015, Peter Griffin wrote:

> Calling trace_hardirqs_off() from the platform specific
> secondary startup code as not been necessary since Dec 2010
> when Russell King consolidated the call into the common SMP
> code.
> 
> 2c0136d ARM: SMP: consolidate trace_hardirqs_off() into common SMP code
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/mach-sti/platsmp.c | 2 --
>  1 file changed, 2 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
> index d4b624f..a39f812 100644
> --- a/arch/arm/mach-sti/platsmp.c
> +++ b/arch/arm/mach-sti/platsmp.c
> @@ -38,8 +38,6 @@ static DEFINE_SPINLOCK(boot_lock);
>  
>  static void sti_secondary_init(unsigned int cpu)
>  {
> -	trace_hardirqs_off();
> -
>  	/*
>  	 * let the primary processor know we're out of the
>  	 * pen, then head off into the C entry point

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
