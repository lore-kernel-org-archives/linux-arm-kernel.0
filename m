From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 22 Mar 2012 07:39:06 -0700
Subject: [PATCH][RESEND] ARM: SAMSUNG: make SAMSUNG_PM_DEBUG select
 DEBUG_LL
In-Reply-To: <201203202120.45806.heiko@sntech.de>
References: <201203202120.45806.heiko@sntech.de>
Message-ID: <4F6B398A.8040703@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/12 13:20, Heiko St?bner wrote:
> From: Maurus Cuelenaere<mcuelenaere@gmail.com>
>
> When selecting SAMSUNG_PM_DEBUG, it complains about a missing printascii()
> function if you do not select DEBUG_LL, so make the former select the latter.
>
> Signed-off-by: Maurus Cuelenaere<mcuelenaere@gmail.com>
> Acked-by: Heiko Stuebner<heiko@sntech.de>
> ---
> This was originally sent in september 2010, but seems to have been forgotten.
> As this problem has bitten me today, here it is again.
>
Yeah, missed. Looks good to me and will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

>   arch/arm/plat-samsung/Kconfig |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index 6a2abe6..ec84c1a 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -302,6 +302,7 @@ comment "Power management"
>   config SAMSUNG_PM_DEBUG
>   	bool "S3C2410 PM Suspend debug"
>   	depends on PM
> +	select DEBUG_LL
>   	help
>   	  Say Y here if you want verbose debugging from the PM Suspend and
>   	  Resume code. See<file:Documentation/arm/Samsung-S3C24XX/Suspend.txt>
