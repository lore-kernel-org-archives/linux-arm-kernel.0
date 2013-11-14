From: robherring2@gmail.com (Rob Herring)
Date: Wed, 13 Nov 2013 18:51:36 -0600
Subject: [PATCH 2/2] ARM: highbank: only select errata 764369 if SMP
In-Reply-To: <1384389974-6229-2-git-send-email-olof@lixom.net>
References: <1384389974-6229-1-git-send-email-olof@lixom.net>
 <1384389974-6229-2-git-send-email-olof@lixom.net>
Message-ID: <52841E98.2020807@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2013 06:46 PM, Olof Johansson wrote:
> 764369 depends on SMP, so don't select it on !SMP configs.

I think Russell has a fix for these in his tree.

Rob

> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Cc: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/mach-highbank/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
> index fe98df44579c..6e1d72326454 100644
> --- a/arch/arm/mach-highbank/Kconfig
> +++ b/arch/arm/mach-highbank/Kconfig
> @@ -6,7 +6,7 @@ config ARCH_HIGHBANK
>  	select ARCH_HAS_OPP
>  	select ARCH_WANT_OPTIONAL_GPIOLIB
>  	select ARM_AMBA
> -	select ARM_ERRATA_764369
> +	select ARM_ERRATA_764369 if SMP
>  	select ARM_ERRATA_775420
>  	select ARM_ERRATA_798181
>  	select ARM_GIC
> 
