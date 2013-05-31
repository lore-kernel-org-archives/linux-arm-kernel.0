From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 30 May 2013 18:20:14 -0700
Subject: [PATCH] clk: use platform_{get,set}_drvdata()
In-Reply-To: <000401ce581b$a9224600$fb66d200$@samsung.com>
References: <000401ce581b$a9224600$fb66d200$@samsung.com>
Message-ID: <20130531012014.21525.39312@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jingoo Han (2013-05-23 18:11:46)
> Use the wrapper functions for getting and setting the driver data using
> platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
> so we can directly pass a struct platform_device.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Taken into clk-next.

Thanks for the patch,
Mike

> ---
>  drivers/clk/clk-twl6040.c |    4 ++--
>  drivers/clk/clk-wm831x.c  |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk-twl6040.c b/drivers/clk/clk-twl6040.c
> index 3af729b..1ada79a 100644
> --- a/drivers/clk/clk-twl6040.c
> +++ b/drivers/clk/clk-twl6040.c
> @@ -95,14 +95,14 @@ static int twl6040_clk_probe(struct platform_device *pdev)
>         if (IS_ERR(clkdata->clk))
>                 return PTR_ERR(clkdata->clk);
>  
> -       dev_set_drvdata(&pdev->dev, clkdata);
> +       platform_set_drvdata(pdev, clkdata);
>  
>         return 0;
>  }
>  
>  static int twl6040_clk_remove(struct platform_device *pdev)
>  {
> -       struct twl6040_clk *clkdata = dev_get_drvdata(&pdev->dev);
> +       struct twl6040_clk *clkdata = platform_get_drvdata(pdev);
>  
>         clk_unregister(clkdata->clk);
>  
> diff --git a/drivers/clk/clk-wm831x.c b/drivers/clk/clk-wm831x.c
> index 16ed068..0d3c04e 100644
> --- a/drivers/clk/clk-wm831x.c
> +++ b/drivers/clk/clk-wm831x.c
> @@ -384,7 +384,7 @@ static int wm831x_clk_probe(struct platform_device *pdev)
>         if (IS_ERR(clkdata->clkout))
>                 return PTR_ERR(clkdata->clkout);
>  
> -       dev_set_drvdata(&pdev->dev, clkdata);
> +       platform_set_drvdata(pdev, clkdata);
>  
>         return 0;
>  }
> -- 
> 1.7.10.4
