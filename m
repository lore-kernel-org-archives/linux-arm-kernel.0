From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 9 Jul 2013 09:05:41 +0200
Subject: [PATCH] of: match the compatible in the order set by the dts file
In-Reply-To: <1373013818-11365-1-git-send-email-b32955@freescale.com>
References: <1373013818-11365-1-git-send-email-b32955@freescale.com>
Message-ID: <20130709070541.GQ516@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 04:43:38PM +0800, Huang Shijie wrote:
> If we set the uart compatible in the dts file like this:
>    ------------------------------------------------------
>     compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
>    ------------------------------------------------------
> 
> and we set the uart compatible in the uart driver like this:
>    ------------------------------------------------------
> 	{ .compatible = "fsl,imx1-uart", ... },
> 	{ .compatible = "fsl,imx21-uart", ... },
> 	{ .compatible = "fsl,imx6q-uart", ... },
> 	{ /* sentinel */ }
>    ------------------------------------------------------
> 
> the current code will match the "fsl,imx21-uart" in the end.
> 
> Of course, this is not what we want. We want it to match the "fsl,imx6q-uart".
> 
> This patch rewrites the match code, and make it to check the compatible
> in the order set by the DTS file.

Why don't you set the matching order in the driver the way you want it
to be, i.e.:

	{ .compatible = "fsl,imx6q-uart", ... },
	{ .compatible = "fsl,imx21-uart", ... },
	{ .compatible = "fsl,imx1-uart", ... },

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
