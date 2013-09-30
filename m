From: kgene@kernel.org (Kukjin Kim)
Date: Mon, 30 Sep 2013 16:22:51 +0900
Subject: [PATCH 1/5] ARM: Kconfig: Move if ARCH_S3C64XX statement to
 mach-s3c64xx/Kconfig
In-Reply-To: <1380392497-27406-1-git-send-email-tomasz.figa@gmail.com>
References: <1380392497-27406-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <069301cebdad$df658f90$9e30aeb0$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> All other platforms have this condition checked inside their own Kconfig
> files, so for consistency this patch makes it this way for mach-s3c64xx
> as well.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  arch/arm/Kconfig              | 2 --
>  arch/arm/mach-s3c64xx/Kconfig | 4 ++++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index b766dad..dc51f8a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -995,9 +995,7 @@ source "arch/arm/mach-sti/Kconfig"
> 
>  source "arch/arm/mach-s3c24xx/Kconfig"
> 
> -if ARCH_S3C64XX
>  source "arch/arm/mach-s3c64xx/Kconfig"
> -endif
> 
>  source "arch/arm/mach-s5p64x0/Kconfig"
> 
> diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
> index bd14e3a..0e23910 100644
> --- a/arch/arm/mach-s3c64xx/Kconfig
> +++ b/arch/arm/mach-s3c64xx/Kconfig
> @@ -3,6 +3,8 @@
>  #
>  # Licensed under GPLv2
> 
> +if ARCH_S3C64XX
> +
>  # temporary until we can eliminate all drivers using it.
>  config PLAT_S3C64XX
>  	bool
> @@ -322,3 +324,5 @@ config MACH_S3C64XX_DT
>  	  board.
>  	  Note: This is under development and not all peripherals can be
>  	  supported with this machine file.
> +
> +endif
> --
> 1.8.3.2

Looks good to me, applied 1 to 5 patches into cleanup.

Thanks,
Kukjin
