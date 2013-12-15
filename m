From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 16 Dec 2013 04:59:17 +0900
Subject: [PATCH] ARM: s3c64xx: Do not select both CPU_V6 and CPU_V6K at
 the same time
In-Reply-To: <1386965752-15954-1-git-send-email-tomasz.figa@gmail.com>
References: <1386965752-15954-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <52AE0A15.5040503@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/13 05:15, Tomasz Figa wrote:
> To use V6K extensions, these symbols must not be selected at the same
> time, so this patch keeps only CPU_V6K selected for S3C64XX.
>
> Signed-off-by: Tomasz Figa<tomasz.figa@gmail.com>
> ---
>   arch/arm/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index b64a8ef..4df191b 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -731,7 +731,6 @@ config ARCH_S3C64XX
>   	select CLKDEV_LOOKUP
>   	select CLKSRC_SAMSUNG_PWM
>   	select COMMON_CLK
> -	select CPU_V6
>   	select CPU_V6K
>   	select GENERIC_CLOCKEVENTS
>   	select GPIO_SAMSUNG

Squashed with previous patch for CPU_V6K.

Thanks,
Kukjin
