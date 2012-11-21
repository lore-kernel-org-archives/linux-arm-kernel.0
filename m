From: mturquette@ti.com (Mike Turquette)
Date: Wed, 21 Nov 2012 13:49:37 -0800
Subject: [PATCH 394/493] clk: remove use of __devexit
In-Reply-To: <1353349642-3677-394-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-394-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121121214937.21126.57991@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Bill Pemberton (2012-11-19 10:25:43)
> CONFIG_HOTPLUG is going away as an option so __devexit is no
> longer needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Mike Turquette <mturquette@ti.com> 
> Cc: linux-arm-kernel at lists.infradead.org 
> Cc: patches at opensource.wolfsonmicro.com 

Acked-by: Mike Turquette <mturquette@linaro.org>

Regards,
Mike

> ---
>  drivers/clk/clk-max77686.c | 2 +-
>  drivers/clk/clk-twl6040.c  | 2 +-
>  drivers/clk/clk-wm831x.c   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
> index fe449c2..d098f72 100644
> --- a/drivers/clk/clk-max77686.c
> +++ b/drivers/clk/clk-max77686.c
> @@ -199,7 +199,7 @@ out:
>         return ret;
>  }
>  
> -static int __devexit max77686_clk_remove(struct platform_device *pdev)
> +static int max77686_clk_remove(struct platform_device *pdev)
>  {
>         struct max77686_clk **max77686_clks = platform_get_drvdata(pdev);
>         int i;
> diff --git a/drivers/clk/clk-twl6040.c b/drivers/clk/clk-twl6040.c
> index 93dd975..42bbbb1 100644
> --- a/drivers/clk/clk-twl6040.c
> +++ b/drivers/clk/clk-twl6040.c
> @@ -100,7 +100,7 @@ static int twl6040_clk_probe(struct platform_device *pdev)
>         return 0;
>  }
>  
> -static int __devexit twl6040_clk_remove(struct platform_device *pdev)
> +static int twl6040_clk_remove(struct platform_device *pdev)
>  {
>         struct twl6040_clk *clkdata = dev_get_drvdata(&pdev->dev);
>  
> diff --git a/drivers/clk/clk-wm831x.c b/drivers/clk/clk-wm831x.c
> index f31a642..16ed068 100644
> --- a/drivers/clk/clk-wm831x.c
> +++ b/drivers/clk/clk-wm831x.c
> @@ -389,7 +389,7 @@ static int wm831x_clk_probe(struct platform_device *pdev)
>         return 0;
>  }
>  
> -static int __devexit wm831x_clk_remove(struct platform_device *pdev)
> +static int wm831x_clk_remove(struct platform_device *pdev)
>  {
>         return 0;
>  }
> -- 
> 1.8.0
