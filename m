From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 23 Sep 2013 12:13:03 -0300
Subject: [PATCH 1/9] Staging/iio/adc/touchscreen/MXS: add proper clock
 handling
In-Reply-To: <1379946998-23041-2-git-send-email-jbe@pengutronix.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
 <1379946998-23041-2-git-send-email-jbe@pengutronix.de>
Message-ID: <52405A7F.1050801@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2013 11:36 AM, Juergen Beisert wrote:

> +	lradc->clk = devm_clk_get(&pdev->dev, NULL);
> +	clk_prepare_enable(lradc->clk);

clk_prepare_enable() may fail, so better check its return value.
