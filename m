From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Mar 2014 12:55:28 +0900
Subject: [PATCH 47/62] ARM: s3c64xx: MACH_SMDK6400 needs HSMMC1
In-Reply-To: <1395257399-359545-48-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-48-git-send-email-arnd@arndb.de>
Message-ID: <01ee01cf43f0$3b436bc0$b1ca4340$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> This board uses both MMC controllers, so we need to enable
> the Kconfig option to define the platform data.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> ---
>  arch/arm/mach-s3c64xx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
> index 64f04e6..92885d7 100644
> --- a/arch/arm/mach-s3c64xx/Kconfig
> +++ b/arch/arm/mach-s3c64xx/Kconfig
> @@ -87,6 +87,7 @@ config MACH_SMDK6400
>  	select CPU_S3C6400
>  	select S3C64XX_SETUP_SDHCI
>  	select S3C_DEV_HSMMC
> +	select S3C_DEV_HSMMC1
>  	select S3C_DEV_NAND

Well, only HSMMC ch1 is used on smdk6400 and S3C_DEV_NAND is not needed.

So should be following:

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 64f04e6..3136d86 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -86,8 +86,7 @@ config MACH_SMDK6400
        bool "SMDK6400"
 	select CPU_S3C6400
 	select S3C64XX_SETUP_SDHCI
-	select S3C_DEV_HSMMC
-	select S3C_DEV_NAND
+	select S3C_DEV_HSMMC1
 	help
 	  Machine support for the Samsung SMDK6400

Thanks,
Kukjin

>  	help
>  	  Machine support for the Samsung SMDK6400
> --
> 1.8.3.2
