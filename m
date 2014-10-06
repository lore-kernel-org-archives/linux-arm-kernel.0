From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 06 Oct 2014 16:37:44 +0400
Subject: [PATCH 2/4] [media] exynos4-is: Remove optional dependency on
 PLAT_S5P
In-Reply-To: <1412586485.4054.40.camel@x220>
References: <1412586485.4054.40.camel@x220>
Message-ID: <54328D18.2000606@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10/6/2014 1:08 PM, Paul Bolle wrote:

> Commit d78c16ccde96 ("ARM: SAMSUNG: Remove remaining legacy code")
> removed the Kconfig symbol PLAT_S5P. Remove an optional dependency on
> that symbol from this Kconfig file too.

> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
>   drivers/media/platform/exynos4-is/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/media/platform/exynos4-is/Kconfig b/drivers/media/platform/exynos4-is/Kconfig
> index 77c951237744..775c3278d0eb 100644
> --- a/drivers/media/platform/exynos4-is/Kconfig
> +++ b/drivers/media/platform/exynos4-is/Kconfig
> @@ -2,7 +2,7 @@
>   config VIDEO_SAMSUNG_EXYNOS4_IS
>   	bool "Samsung S5P/EXYNOS4 SoC series Camera Subsystem driver"
>   	depends on VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API
> -	depends on (PLAT_S5P || ARCH_EXYNOS || COMPILE_TEST)
> +	depends on (ARCH_EXYNOS || COMPILE_TEST)

    Perhaps it's time to drop the useless parens?

WBR, Sergei
