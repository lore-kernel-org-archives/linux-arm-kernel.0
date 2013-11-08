From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 8 Nov 2013 17:39:38 +0200
Subject: [PATCH v5 1/7] gpio: davinci: remove unnecessary printk
In-Reply-To: <1383905510-31760-2-git-send-email-prabhakar.csengg@gmail.com>
References: <1383905510-31760-1-git-send-email-prabhakar.csengg@gmail.com>
 <1383905510-31760-2-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <527D05BA.3000008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2013 12:11 PM, Prabhakar Lad wrote:
> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>
> the devm_*() helper prints error messages in case of
> errors no need to do the same in the driver.

Pls, drop it - devm_clk_get() doesn't always print error messages
>
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> ---
>   drivers/gpio/gpio-davinci.c |    6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> index 84be701..7230c43 100644
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -389,11 +389,9 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
>   	}
>
>   	clk = devm_clk_get(dev, "gpio");
> -	if (IS_ERR(clk)) {
> -		printk(KERN_ERR "Error %ld getting gpio clock?\n",
> -		       PTR_ERR(clk));
> +	if (IS_ERR(clk))
>   		return PTR_ERR(clk);
> -	}
> +
>   	clk_prepare_enable(clk);
>
>   	/*
>
