From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Dec 2013 14:59:17 +0800
Subject: [PATCH 2/3] thermal: imx: add necessary clk operation
In-Reply-To: <1387477045-19037-2-git-send-email-b20788@freescale.com>
References: <1387477045-19037-1-git-send-email-b20788@freescale.com>
 <1387477045-19037-2-git-send-email-b20788@freescale.com>
Message-ID: <20131219065915.GB6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 01:17:24PM -0500, Anson Huang wrote:
> @@ -427,6 +429,13 @@ static int imx_thermal_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(data->thermal_clk)) {
> +		ret = IS_ERR(data->thermal_clk);
> +		dev_err(&pdev->dev, "failed to get thermal clk!\n");
> +		return ret;
> +	}
> +

So when the new kernel runs on a board with an old DTB installed,
thermal driver will be broken.

Shawn
