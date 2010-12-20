From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 20 Dec 2010 10:48:01 +0100
Subject: [PATCH v7 13/15] ARM: mxs: Add initial mx23evk support
In-Reply-To: <1292679575-2635-9-git-send-email-shawn.guo@freescale.com>
References: <1292679575-2635-1-git-send-email-shawn.guo@freescale.com>
	<1292679575-2635-9-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101220094801.GU1940@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Sat, Dec 18, 2010 at 09:39:34PM +0800, Shawn Guo wrote:
> Add initial mx23evk support with duart.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Changes for v7:
>  - Define mx23evk pads using naked pad "OR" mA/vol/pull configurations
> 
> Changes for v3:
>  - Remove inclusion of hardware.h
>  - Add __initconst for mx23evk_pads[]
> 
> Changes for v2:
>  - Remove boot_params
> 
>  arch/arm/mach-mxs/mach-mx23evk.c |   59 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 59 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/mach-mx23evk.c
> 
> diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
> new file mode 100644
> index 0000000..2aa77cc
> --- /dev/null
> +++ b/arch/arm/mach-mxs/mach-mx23evk.c
> @@ -0,0 +1,59 @@
> [...]
> +static const iomux_cfg_t mx23evk_pads[] __initconst = {
> +	/* duart */
> +	MX23_PAD_PWM0__DUART_RX |
> +		MXS_PAD_4MA,
> +	MX23_PAD_PWM1__DUART_TX |
> +		MXS_PAD_4MA,
> +};
I would keep these on a single line.  YMMV, so for me no need for a v8.

I will test this series later on hardware, and if no show stoppers
appear I'd say this is ready to be merged.  The (maybe) remaining issues
can then be resolved in follow up patches.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
