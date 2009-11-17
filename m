From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 17 Nov 2009 14:49:44 +0100
Subject: [PATCH 16/25] imx: generalize nand device registration
In-Reply-To: <1258403708-10287-16-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1258403708-10287-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-16-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20091117134944.GB3147@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> +int __init imx_add_mxc_nand(resource_size_t base, int irq,
> +		const struct mxc_nand_platform_data *pdata)
> +{
> +	static int id = 0;
While looking at Russell's suggestion to use __initdata for pdata I
noticed that id lives in .bss.  So I fixed that, too, by making the
above line:

	static int id __initdata = 0;

(Actually better would be:

	static int id __initbss;

but this doesn't exist.)

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
