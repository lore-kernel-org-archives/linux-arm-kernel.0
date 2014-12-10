From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 10 Dec 2014 08:46:17 +0100
Subject: [PATCH 1/2] usb: chipidea: usbmisc: skip clocks on i.MX6
In-Reply-To: <1418141616-29671-1-git-send-email-p.zabel@pengutronix.de>
References: <1418141616-29671-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20141210074617.GG13486@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Philipp,

On Tue, Dec 09, 2014 at 05:13:35PM +0100, Philipp Zabel wrote:
> +	/* on i.MX6Q, the USBMISC register space is clocked by the IPG clock */
> +	if (data->ops != &imx6q_usbmisc_ops) {
> +		data->clk = devm_clk_get(&pdev->dev, NULL);
I wonder if it was better/simpler to handle devm_clk_get returning
-ENOENT and assume this means there is no need for a clock in this case.

(I think devm_clk_get prints an error message in this case. That's ugly
when the error is handled just fine.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
