From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 07 Mar 2013 09:02:33 +0900
Subject: [PATCH] ARM: S3C24XX: drop "select MACH_N35"
In-Reply-To: <1362609234.28137.2.camel@x61.thuisdomein>
References: <1362609234.28137.2.camel@x61.thuisdomein>
Message-ID: <013a01ce1ac7$11b287d0$35179770$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Bolle wrote:
> 
> The unused Kconfig symbol MACH_N35 was removed in commit
> 85fd6d63bf2927b9da7ab1b0d46723bfdb13808c ("ARM: S3C2410: move
> mach-s3c2410/* into mach-s3c24xx/"). But there is still one (pointless)
> select statement for that symbol. Drop it.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
>  arch/arm/mach-s3c24xx/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
> index 37f513d..7361b9d 100644
> --- a/arch/arm/mach-s3c24xx/Kconfig
> +++ b/arch/arm/mach-s3c24xx/Kconfig
> @@ -320,7 +320,6 @@ config PM_H1940
> 
>  config MACH_N30
>  	bool "Acer N30 family"
> -	select MACH_N35
>  	select S3C_DEV_NAND
>  	select S3C_DEV_USB_HOST
>  	help
> --
> 1.7.11.7

Yes, right. Applied, thanks.

BTW, so the machine type can be removed at arch/arm/tools/mach-types as well.

- Kukjin
