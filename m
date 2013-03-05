From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 05 Mar 2013 19:34:06 +0100
Subject: [PATCH] ARM: dove: Fix typo "COMMON_CLK_DOVE"
In-Reply-To: <1362476098.16460.65.camel@x61.thuisdomein>
References: <1362476098.16460.65.camel@x61.thuisdomein>
Message-ID: <51363A9E.6090507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/2013 10:34 AM, Paul Bolle wrote:
> Commit 5b03df9ace680d7cdd34a69dfd85ca5f74159d18 ("ARM: dove: switch to
> DT clock providers") added "select COMMON_CLK_DOVE" to Marvell Dove's
> Kconfig entry. But there's no Kconfig symbol COMMON_CLK_DOVE, which
> makes this select statement a nop. Since the Marvell Dove code includes
> <linux/clk-provider.h>  we can assume that this entry needs to select
> COMMON_CLK instead.
>
> Signed-off-by: Paul Bolle<pebolle@tiscali.nl>
> ---
> Untested.
>
>   arch/arm/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5b71469..31acce7 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -556,7 +556,7 @@ config ARCH_IXP4XX
>   config ARCH_DOVE
>   	bool "Marvell Dove"
>   	select ARCH_REQUIRE_GPIOLIB
> -	select COMMON_CLK_DOVE
> +	select COMMON_CLK
>   	select CPU_V7
>   	select GENERIC_CLOCKEVENTS
>   	select MIGHT_HAVE_PCI

Paul,

thanks for the patch but I guess COMMON_CLK_DOVE is a left-over
from early DT experiments with Dove. It should just be removed
from arm/Kconfig.

Thanks for pointing it out, and it would be great to update
your patch accordingly.

Sebastian
