From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 13 Dec 2009 21:01:42 +0100
Subject: [PATCH 3/4] regulator: add voltage selection capability to
	mc13783 regulators.
In-Reply-To: <1260636976.2054.36.camel@climbing-alby>
References: <1260635829.2054.16.camel@climbing-alby>
	<1260636523.2054.28.camel@climbing-alby>
	<1260636819.2054.33.camel@climbing-alby>
	<1260636976.2054.36.camel@climbing-alby>
Message-ID: <20091213200142.GC14024@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 12, 2009 at 05:56:16PM +0100, Alberto Panizzo wrote:
> This patch, complete the mc13783 regulator subsystem driver with 
> voltage selecting capability.
> Main Switches (SW1AB, SW2AB) are not supported yet.
> 
> Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
> ---
>  drivers/regulator/mc13783-regulator.c |  375 ++++++++++++++++++++++++++++++---
>  1 files changed, 348 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/regulator/mc13783-regulator.c b/drivers/regulator/mc13783-regulator.c
> index 9f99862..ed78137 100644
> --- a/drivers/regulator/mc13783-regulator.c
> +++ b/drivers/regulator/mc13783-regulator.c
> @@ -2,6 +2,7 @@
>   * Regulator Driver for Freescale MC13783 PMIC
>   *
>   * Copyright (C) 2008 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
> + * Copyright 2009 Alberto Panizzo <maramaopercheseimorto@gmail.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -18,9 +19,47 @@
>  
>  #define MC13783_REG_SWITCHERS4			28
>  #define MC13783_REG_SWITCHERS4_PLLEN			(1 << 18)
> +#define MC13783_REG_SWITCHERS4_PLLVSEL			(1 << 19)
> +#define MC13783_REG_SWITCHERS4_PLLVSEL_M		(7 << 19)
>  
>  #define MC13783_REG_SWITCHERS5			29
>  #define MC13783_REG_SWITCHERS5_SW3EN			(1 << 20)
> +#define MC13783_REG_SWITCHERS5_SW3VSEL			18
This looks inconsitent:
	MC13783_REG_SWITCHERS4_PLLVSEL	(1 << 19)
	MC13783_REG_SWITCHERS5_SW3VSEL	18

I didn't check the rest of the patch though it would be great if you
wouldn't need all those arrays as they occupy much memory.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
