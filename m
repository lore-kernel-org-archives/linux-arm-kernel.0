From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 6 Dec 2013 08:12:56 +0100
Subject: [PATCHv13][ 1/4] video: imxfb: Introduce regulator support.
In-Reply-To: <1386258219-26437-1-git-send-email-denis@eukrea.com>
References: <1386258219-26437-1-git-send-email-denis@eukrea.com>
Message-ID: <20131206071256.GX24559@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 04:43:36PM +0100, Denis Carikli wrote:
> This commit is based on the following commit by Fabio Estevam:
> @@ -1020,6 +1045,12 @@ static int imxfb_probe(struct platform_device *pdev)
>  		goto failed_register;
>  	}
>  
> +	fbi->reg_lcd = devm_regulator_get(&pdev->dev, "lcd");
> +	if (IS_ERR(fbi->reg_lcd)) {
> +		dev_info(&pdev->dev, "No lcd regulator used.\n");

Please remove this log spam or at least reduce it to dev_dbg. That's the
typical message to which our customers keep asking us whether that's
something they have to care about.

Also, you should check for -EPROBE_DEFER here and return it in this
case.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
