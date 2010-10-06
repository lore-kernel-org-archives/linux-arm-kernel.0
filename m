From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 6 Oct 2010 15:05:28 +0200
Subject: [PATCH for 2.6.36 1/2] cpuimx27: fix compile when ULPI is selected
In-Reply-To: <1286355230-15530-1-git-send-email-eric@eukrea.com>
References: <1286355230-15530-1-git-send-email-eric@eukrea.com>
Message-ID: <20101006130528.GI29673@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 06, 2010 at 10:53:49AM +0200, Eric B?nard wrote:
> without this patch we get :
> arch/arm/mach-imx/built-in.o: In function `eukrea_cpuimx27_init':
> eukrea_mbimx27-baseboard.c:(.init.text+0x44c): undefined reference to `mxc_ulpi_access_ops'
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
>  arch/arm/mach-imx/Kconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index c5c0369..6348017 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -122,6 +122,8 @@ config MACH_CPUIMX27
>  	select IMX_HAVE_PLATFORM_IMX_I2C
>  	select IMX_HAVE_PLATFORM_IMX_UART
>  	select IMX_HAVE_PLATFORM_MXC_NAND
> +	select IMX_HAVE_PLATFORM_SPI_IMX
> +	select MXC_ULPI if USB_ULPI
the spi part is not related to the commit log?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
