From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 9 Dec 2009 10:12:44 +0100
Subject: [PATCH] Driver for the watchdog timer on all Freescale IMX
	processors.
In-Reply-To: <1260286752-8796-1-git-send-email-w.sang@pengutronix.de>
References: <1260286752-8796-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20091209091244.GA15126@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2009 at 04:39:12PM +0100, Wolfram Sang wrote:
> Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> ---
> 
> Changes since the last version from Darius:
> 
> * removed all #ifdef CONFIG_ARCH_* and handle the differences at runtime
> * simplified house-keeping of the timeout value and fixed the conversion
>   into the corresponding register value
> * removed a superfluous static platform-device
> * removed debug output and comments with (IMHO) little information
> * cleaned up #includes
> * fixed some typos & removed unnecessary tabs & added kernel coding style
> * probably something else...
> 
>  drivers/watchdog/Kconfig   |   12 ++
>  drivers/watchdog/Makefile  |    1 +
>  drivers/watchdog/imx_wdt.c |  342 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 355 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/watchdog/imx_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig

[snip]

> +
> +	base = ioremap(res->start, res_size);
> +	if (!base) {
> +		dev_err(&pdev->dev, "ioremap failed\n");
> +		ret = -EIO;
> +		goto fail0;
> +	}
> +
> +	imx_wdt.clk = clk_get(&pdev->dev, "wdog_clk");
                                          ^^^^^^^^^^

should be NULL.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
