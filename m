From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 17 Jul 2013 14:25:38 +0100
Subject: [PATCH] arm: choose debug/uncompress.h include when uncompress
 debug is disabled
In-Reply-To: <1373897706-15331-1-git-send-email-julien.grall@linaro.org>
References: <1373897706-15331-1-git-send-email-julien.grall@linaro.org>
Message-ID: <alpine.DEB.2.02.1307171420350.8258@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Jul 2013, Julien Grall wrote:
> Even if uncompress debug is disabled, some board will continue to print
> information during uncompress step.

Are you talking about DEBUG_UNCOMPRESS?
Should I read the sentence as "even if DEBUG_UNCOMPRESS is not selected,
some board will continue to print information during the uncompress step"?

Isn't this a bug in the platform specific code that should be fixed anyway?


> By using debug/uncompress.h include, all debug output will be disabled.

I am not sure if this is the right solution to the problem.
I think it might be better to add the appropriate ifdefs into the
platform specific code.

Arnd, what do you think?


> This is usefull in Xen environment for DOM0 because the UART is stolen by
> Xen.
> 
> Signed-off-by: Julien Grall <julien.grall@linaro.org>
>
>  arch/arm/Kconfig.debug |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 21cc8a7..86c023d 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -679,7 +679,7 @@ config DEBUG_UNCOMPRESS
>  
>  config UNCOMPRESS_INCLUDE
>  	string
> -	default "debug/uncompress.h" if ARCH_MULTIPLATFORM
> +	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || !DEBUG_UNCOMPRESS
>  	default "mach/uncompress.h"
>  
>  config EARLY_PRINTK
> -- 
> 1.7.10.4
> 
