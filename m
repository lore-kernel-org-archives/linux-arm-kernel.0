From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 30 Nov 2010 19:22:48 +0100
Subject: [PATCH] ARM: mx5: fix keypad clock
In-Reply-To: <1291137573-8855-1-git-send-email-fabio.estevam@freescale.com>
References: <1291137573-8855-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20101130182248.GU20449@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Nov 30, 2010 at 03:19:33PM -0200, Fabio Estevam wrote:
> This fixes the following error during keypad driver probe:
> 
> imx-keypad imx-keypad: failed to get keypad clock
> imx-keypad: probe of imx-keypad failed with error -2
> 
> Register keypad clock the same way as other imx platforms.
> 
> Tested keypad succesfully on a MX51_3DS board.
s/succesfully/successfully/

> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-mx5/clock-mx51-mx53.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
> index 344ee8e..86fa0f4 100644
> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> @@ -1091,7 +1091,7 @@ static struct clk_lookup mx51_lookups[] = {
>  	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", ahb_clk)
>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usboh3_clk)
>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
> -	_REGISTER_CLOCK("imx-keypad.0", NULL, kpp_clk)
> +	_REGISTER_CLOCK(NULL, "kpp", kpp_clk)
IMHO this is a step backwards.  Better fix the driver to use the right
clock.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
