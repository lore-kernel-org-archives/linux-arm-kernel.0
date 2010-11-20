From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 20 Nov 2010 22:44:12 +0100
Subject: [PATCH 4/6] at91/picotux200: fix warning:
	'picotux200_mmc_data' defined but not used
In-Reply-To: <1290247733-17834-4-git-send-email-plagnioj@jcrosoft.com>
References: <20101120095906.GD4216@game.jcrosoft.org>
	<1290247733-17834-4-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20101120214412.GF8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 20, 2010 at 11:08:51AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  arch/arm/mach-at91/board-picotux200.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
> index ac1a3b5..7259e7b 100644
> --- a/arch/arm/mach-at91/board-picotux200.c
> +++ b/arch/arm/mach-at91/board-picotux200.c
> @@ -79,12 +79,14 @@ static struct at91_usbh_data __initdata picotux200_usbh_data = {
>  // 	.pullup_pin	= AT91_PIN_PD5,
>  // };
>  
> +#ifndef CONFIG_MTD_AT91_DATAFLASH_CARD
>  static struct at91_mmc_data __initdata picotux200_mmc_data = {
>  	.det_pin	= AT91_PIN_PB27,
>  	.slot_b		= 0,
>  	.wire4		= 1,
>  	.wp_pin		= AT91_PIN_PA17,
>  };
> +#endif
I'd prefer __maybe_unused.  Then introducing bugs is catched more easily
because the code is always compiled.

>  
>  // static struct spi_board_info picotux200_spi_devices[] = {
>  // 	{	/* DataFlash chip */
And it seems this file could get some care by removing c99-style
comments ...

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
