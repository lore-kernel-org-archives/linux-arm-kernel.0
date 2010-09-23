From: ben@simtec.co.uk (Ben Dooks)
Date: Fri, 24 Sep 2010 00:54:34 +0100
Subject: [PATCH] ARM: SAMSUNG: make SAMSUNG_PM_DEBUG select DEBUG_LL
In-Reply-To: <4c920aa8.d37b0e0a.4ee4.ffffc4bc@mx.google.com>
References: <4c920aa8.d37b0e0a.4ee4.ffffc4bc@mx.google.com>
Message-ID: <4C9BE8BA.7000804@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/09/10 13:16, Maurus Cuelenaere wrote:
> When selecting SAMSUNG_PM_DEBUG, it complains about a missing printascii()
> function if you do not select DEBUG_LL, so make the former select the latter.
> 
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> ---
>  arch/arm/plat-samsung/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index 7c0bde7..d5816e7 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -260,6 +260,7 @@ comment "Power management"
>  config SAMSUNG_PM_DEBUG
>  	bool "S3C2410 PM Suspend debug"
>  	depends on PM
> +	select DEBUG_LL
>  	help
>  	  Say Y here if you want verbose debugging from the PM Suspend and
>  	  Resume code. See <file:Documentation/arm/Samsung-S3C24XX/Suspend.txt>

Either this, or having SAMSUNG_PM_DEBUG depend on DEBUG_LL.. Personally
I think this is probably best, unless it's offensive to anyone else?

-- 
Ben
