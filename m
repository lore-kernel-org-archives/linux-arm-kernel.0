From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 14 Apr 2012 15:53:31 +0200
Subject: [PATCH 3/3] ARM: imx6q: switch to use pinctrl driver
In-Reply-To: <1334333915-1174-3-git-send-email-b29396@freescale.com>
References: <1334333915-1174-1-git-send-email-b29396@freescale.com>
 <1334333915-1174-3-git-send-email-b29396@freescale.com>
Message-ID: <20120414135331.GB3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 14, 2012 at 12:18:35AM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> ---
> This patch is used for test the new pinctrl driver.

Then please test it with i.MX35, i.MX5...

>  
> +	imx_data->p = pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(imx_data->p)) {
> +		err = PTR_ERR(imx_data->p);
> +		goto pin_err;
> +	}
> +

... which will fail here.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
