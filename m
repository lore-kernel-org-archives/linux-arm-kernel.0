From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 14 Feb 2011 11:26:46 +0100
Subject: [PATCH v2 7/7] ARM: mxs/mx28evk: add mmc device
In-Reply-To: <1297650746-12841-8-git-send-email-shawn.guo@freescale.com>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
	<1297650746-12841-8-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110214102646.GB30100@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

> +/* mmc */
> +static void __init mx28evk_mmc_slot_poweron(int gpio)
> +{
> +	int ret;
> +
> +	ret = gpio_request(gpio, "mmc-slot-power");
> +	if (ret) {
> +		pr_err("Failed to request gpio mmc-slot-power: %d\n", ret);
> +		return;
> +	}
> +
> +	ret = gpio_direction_output(gpio, 0);
> +	if (ret) {
> +		pr_err("Failed to drive gpio mmc-slot-power: %d\n", ret);
> +		return;
> +	}
> +}

Minor nit: You could use gpio_request_one(), and doing so maybe even get rid of
this function and simply do it the init-function. The advantage would be, that
you can name the two GPIOs independently.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
