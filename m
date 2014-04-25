From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 25 Apr 2014 17:26:58 -0400
Subject: [PATCH] ARM: mvebu: Select HAVE_ARM_TWD only if SMP is enabled
In-Reply-To: <1398339276-5754-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1398339276-5754-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140425212658.GD28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 08:34:36AM -0300, Ezequiel Garcia wrote:
> HAVE_ARM_TWD depends on SMP, so we should only select it if
> SMP is enabled, as the others platforms do.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I just tried to apply this against mvebu/fixes.  It failed.  What did
you base this against?

Can you resubmit based against mvebu/fixes so I can queue it up for
v3.15-rcX ?

thx,

Jason.

> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 7bb92b1..8c9fd60 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -41,7 +41,7 @@ config MACH_ARMADA_375
>  	select ARMADA_375_CLK
>  	select CPU_V7
>  	select HAVE_ARM_SCU
> -	select HAVE_ARM_TWD
> +	select HAVE_ARM_TWD if SMP
>  	select HAVE_SMP
>  	select MACH_MVEBU_V7
>  	select PINCTRL_ARMADA_375
> @@ -57,7 +57,7 @@ config MACH_ARMADA_38X
>  	select ARMADA_38X_CLK
>  	select CPU_V7
>  	select HAVE_ARM_SCU
> -	select HAVE_ARM_TWD
> +	select HAVE_ARM_TWD if SMP
>  	select HAVE_SMP
>  	select MACH_MVEBU_V7
>  	select PINCTRL_ARMADA_38X
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
