From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 08 Feb 2013 14:47:50 -0800
Subject: [PATCH] ARM: S3C24XX: let S3C2412_PM select S3C2412_PM_SLEEP
In-Reply-To: <201302052251.17152.heiko@sntech.de>
References: <201302052251.17152.heiko@sntech.de>
Message-ID: <1a5f01ce064e$53fc1c10$fbf45430$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> The code to enter sleep is used by both the s3c2412 and s3c2416 and
> was thus factored out into an extra config option.
> 
> But it seems it was forgotten to add the appropriate select to the
> s3c2412 pm option, resulting in breakage when only compiling s3c2412
> support.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/mach-s3c24xx/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-
> s3c24xx/Kconfig
> index 5e17e1d..ac61bb7 100644
> --- a/arch/arm/mach-s3c24xx/Kconfig
> +++ b/arch/arm/mach-s3c24xx/Kconfig
> @@ -301,6 +301,7 @@ config S3C2412_DMA
> 
>  config S3C2412_PM
>  	bool
> +	select S3C2412_PM_SLEEP
>  	help
>  	  Internal config node to apply S3C2412 power management
> 
> --
> 1.7.10.4

Looks good to me, applied.

Thanks

- Kukjin
