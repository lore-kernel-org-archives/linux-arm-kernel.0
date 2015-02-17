From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 17 Feb 2015 20:14:38 +0100
Subject: [PATCH v5 1/6] mfd: fsl imx25 Touchscreen ADC driver
In-Reply-To: <1422108103-15052-2-git-send-email-mpa@pengutronix.de>
References: <1422108103-15052-1-git-send-email-mpa@pengutronix.de>
 <1422108103-15052-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20150217191438.GF19388@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Markus,

On Sat, Jan 24, 2015 at 03:01:38PM +0100, Markus Pargmann wrote:
> +config MFD_MX25_TSADC
> +	tristate "Freescale i.MX25 integrated Touchscreen and ADC unit"
> +	select REGMAP_MMIO
> +	depends on SOC_IMX25
Can you make that:

	depends on SOC_IMX25 || COMPILE_TEST

?

> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
Which version of the GPL is your code licensed under?

> +static int mx25_tsadc_setup_irq(struct platform_device *pdev,
> +				struct mx25_tsadc *tsadc)
> [...]
> +	irq_set_chained_handler(irq, mx25_tsadc_irq_handler);
> +	irq_set_handler_data(irq, tsadc);
Do you need to reverse the order of these two calls to prevent the
handler being called while handler_data is still unset?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
