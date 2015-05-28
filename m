From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 28 May 2015 12:55:58 -0700
Subject: [PATCH] ARM: footbridge: enable dc21285 mtd map in defconfig
In-Reply-To: <1432842380-4187-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20150528192238.GQ27753@ld-irv-0074>
 <1432842380-4187-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20150528195558.GR27753@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 09:46:20PM +0200, Uwe Kleine-K?nig wrote:
> This driver fails to build since release 3.2. Improve compile coverage
> by enabling this driver in the footbridge defconfig

Actually, it did build, but it just had alarming warnings. I don't think
those warnings actually affected anything at runtime, except for lock
debugging (if enabled).

But anyway, the change looks good, and I'm doing this in my local build
tests now, so:

> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Brian Norris <computersforpeace@gmail.com>

> ---
>  arch/arm/configs/footbridge_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/footbridge_defconfig
> index 87e020f303ab..9aebf4b910ca 100644
> --- a/arch/arm/configs/footbridge_defconfig
> +++ b/arch/arm/configs/footbridge_defconfig
> @@ -37,6 +37,10 @@ CONFIG_IRDA_CACHE_LAST_LSAP=y
>  CONFIG_IRDA_FAST_RR=y
>  CONFIG_IRDA_DEBUG=y
>  CONFIG_WINBOND_FIR=m
> +CONFIG_MTD=m
> +CONFIG_MTD_CFI=m
> +CONFIG_MTD_COMPLEX_MAPPINGS=y
> +CONFIG_MTD_DC21285=m
>  CONFIG_PARPORT=y
>  CONFIG_PARPORT_PC=y
>  CONFIG_PARPORT_PC_FIFO=y
