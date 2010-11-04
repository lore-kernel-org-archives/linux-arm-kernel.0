From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 4 Nov 2010 08:25:54 +0100
Subject: [PATCH v3] mx51_3ds: Add esdhc support
In-Reply-To: <579640.14227.qm@web51004.mail.re2.yahoo.com>
References: <579640.14227.qm@web51004.mail.re2.yahoo.com>
Message-ID: <20101104072554.GA16938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 03, 2010 at 02:39:13PM -0700, Fabio Estevam wrote:
> Add support for esdhc on mx51_3ds board.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-mx5/Kconfig          |    1 +
>  arch/arm/mach-mx5/board-mx51_3ds.c |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index b03d68e..7bff99a 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -22,6 +22,7 @@ config MACH_MX51_BABBAGE
>  
>  config MACH_MX51_3DS
>  	bool "Support MX51PDK (3DS)"
> +	select IMX_HAVE_PLATFORM_ESDHC
>  	select IMX_HAVE_PLATFORM_IMX_UART
>  	select IMX_HAVE_PLATFORM_SPI_IMX
>  	select MXC_DEBUG_BOARD
> diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
> index ba5805f..d731104 100644
> --- a/arch/arm/mach-mx5/board-mx51_3ds.c
> +++ b/arch/arm/mach-mx5/board-mx51_3ds.c
> @@ -172,6 +172,7 @@ static void __init mxc_board_init(void)
>  		printk(KERN_WARNING "Init of the debugboard failed, all "
>  				    "devices on the board are unusable.\n");
>  
> +	imx51_add_esdhc(0, NULL);
>  	mxc_init_keypad();
>  }
>  
> -- 
> 1.6.0.4
> 
> 
> 
>       
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
