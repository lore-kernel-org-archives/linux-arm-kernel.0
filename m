From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 5 Jan 2010 13:12:43 +0100
Subject: [PATCH 2/3] mx31ads: Allow enable/disable of switchable supplies
In-Reply-To: <1262629491-18942-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1262629491-18942-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1262629491-18942-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20100105121243.GG6923@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2010 at 06:24:50PM +0000, Mark Brown wrote:
> They will be automatically powered off at startup so users will
> need to enable them for use.

Ok, scheduled for -next. Or do you wish to have this earlier?

Sascha

> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-mx3/mx31ads.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/mx31ads.c b/arch/arm/mach-mx3/mx31ads.c
> index cda570b..718fbe6 100644
> --- a/arch/arm/mach-mx3/mx31ads.c
> +++ b/arch/arm/mach-mx3/mx31ads.c
> @@ -302,6 +302,7 @@ static struct regulator_init_data ldo1_data = {
>  		.min_uV = 2800000,
>  		.max_uV = 2800000,
>  		.valid_modes_mask = REGULATOR_MODE_NORMAL,
> +		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
>  		.apply_uV = 1,
>  	},
>  };
> @@ -318,6 +319,7 @@ static struct regulator_init_data ldo2_data = {
>  		.min_uV = 3300000,
>  		.max_uV = 3300000,
>  		.valid_modes_mask = REGULATOR_MODE_NORMAL,
> +		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
>  		.apply_uV = 1,
>  	},
>  	.num_consumer_supplies = ARRAY_SIZE(ldo2_consumers),
> -- 
> 1.6.5.7
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
