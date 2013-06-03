From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Jun 2013 10:54:36 +0800
Subject: [RFC v2 1/5] SPI: imx: Convert to devm_* API
In-Reply-To: <1370168531-22718-1-git-send-email-shc_work@mail.ru>
References: <1370168531-22718-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130603025434.GG13970@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 02, 2013 at 02:22:07PM +0400, Alexander Shiyan wrote:
> @@ -869,56 +858,34 @@ static int spi_imx_probe(struct platform_device *pdev)
>  
>  	master->dev.of_node = pdev->dev.of_node;
>  	ret = spi_bitbang_start(&spi_imx->bitbang);
> -	if (ret) {
> -		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
> -		goto out_clk_put;
> -	}
> +	if (!ret)
> +		return 0;
>  
> -	dev_info(&pdev->dev, "probed\n");
> +	dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
>  
> -	return ret;
> -
> -out_clk_put:
>  	clk_disable_unprepare(spi_imx->clk_per);
>  	clk_disable_unprepare(spi_imx->clk_ipg);

It seems that my comment on v1 is confusing.  I meant the above code
change is completely a diff stat churn to me.

Shawn
