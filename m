From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 3 Jun 2010 09:46:03 +0100
Subject: [PATCH] i2c: Enable i2c-s3c2410 for S5P cpus
In-Reply-To: <1275544623-5425-1-git-send-email-jy0922.shim@samsung.com>
References: <1275544623-5425-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <20100603084603.GB4720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 03, 2010 at 02:57:03PM +0900, Joonyoung Shim wrote:
> This i2c controller driver can be used on the S5P series processors too,
> so enable the driver in Konfig for those platforms.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/i2c/busses/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 87ab056..4765d62 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -503,7 +503,7 @@ config I2C_PXA_SLAVE
>  
>  config I2C_S3C2410
>  	tristate "S3C2410 I2C Driver"
> -	depends on ARCH_S3C2410 || ARCH_S3C64XX
> +	depends on ARCH_S3C2410 || ARCH_S3C64XX || PLAT_S5P

It may be worth changing this to PLAT_S3C24XX || ARCH_S3C64XX || PLAT_S5P
or maybe we should just enable it if PLAT_SAMSUNG

It would be good to get an policy sorted out on these core drivers which
exists across many parts of S3C/S5P supported systems.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
