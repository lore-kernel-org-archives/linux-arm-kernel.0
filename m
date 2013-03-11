From: robherring2@gmail.com (Rob Herring)
Date: Sun, 10 Mar 2013 20:26:59 -0500
Subject: [PATCH] ARM:kernel: beautify code, using 'static const' instead
 of 'const static'
In-Reply-To: <513BE8FA.6080304@asianux.com>
References: <513BE8FA.6080304@asianux.com>
Message-ID: <513D32E3.1080101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2013 07:59 PM, Chen Gang wrote:
> 
>   better using 'static const' instead of 'const static'
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm/kernel/smp_twd.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index 3f25650..ef3e499 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -362,7 +362,7 @@ int __init twd_local_timer_register(struct twd_local_timer *tlt)
>  }
>  
>  #ifdef CONFIG_OF
> -const static struct of_device_id twd_of_match[] __initconst = {
> +static const struct of_device_id twd_of_match[] __initconst = {

This will go away with conversion to use CLKSRC_OF.

Rob

>  	{ .compatible = "arm,cortex-a9-twd-timer",	},
>  	{ .compatible = "arm,cortex-a5-twd-timer",	},
>  	{ .compatible = "arm,arm11mp-twd-timer",	},
> 
