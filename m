From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 3 Nov 2010 20:42:20 +0100
Subject: [PATCH] mx51_3ds: Add esdhc support
In-Reply-To: <264491.32251.qm@web51003.mail.re2.yahoo.com>
References: <264491.32251.qm@web51003.mail.re2.yahoo.com>
Message-ID: <20101103194220.GD11176@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 03, 2010 at 11:33:42AM -0700, Fabio Estevam wrote:
> Add support for esdhc on mx51_3ds board.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> ---
>  arch/arm/mach-mx5/board-mx51_3ds.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
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
You have to assert that IMX_HAVE_PLATFORM_ESDHC is selected by
MACH_MX51_3DS when adding a call to imx51_add_esdhc.  Otherwise a build
that only contains mx51_3ds but no other machine fails to build.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
