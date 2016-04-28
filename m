From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Apr 2016 13:24:25 +0100
Subject: [PATCH] arm64: Drop CONFIG_RTC_LIB dependency
In-Reply-To: <1461776128-7808-1-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1461776128-7808-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <20160428122424.GG24693@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 01:55:28PM -0300, Ezequiel Garcia wrote:
> The rtc-lib dependency is not required, and seems it was just
> copy-pasted from ARM's Kconfig. If platform requires rtc-lib,
> they should select it individually.

Are you sure this doesn't break any platforms that are relying on this
implicit select?

Will

> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
>  arch/arm64/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c8762f4613f0..b9d0a81d391c 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -99,7 +99,6 @@ config ARM64
>  	select PERF_USE_VMALLOC
>  	select POWER_RESET
>  	select POWER_SUPPLY
> -	select RTC_LIB
>  	select SPARSE_IRQ
>  	select SYSCTL_EXCEPTION_TRACE
>  	help
> -- 
> 2.7.0
> 
