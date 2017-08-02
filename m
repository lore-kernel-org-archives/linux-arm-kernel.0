From: j-keerthy@ti.com (Keerthy)
Date: Wed, 2 Aug 2017 16:29:16 +0530
Subject: [PATCH v2 2/3] gpio: davinci: Handle the return value of
 davinci_gpio_irq_setup function
In-Reply-To: <1500543738-9696-3-git-send-email-j-keerthy@ti.com>
References: <1500543738-9696-1-git-send-email-j-keerthy@ti.com>
 <1500543738-9696-3-git-send-email-j-keerthy@ti.com>
Message-ID: <32ca2ace-bca3-4819-d3fb-10331cd0213c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 20 July 2017 03:12 PM, Keerthy wrote:
> Currently davinci_gpio_irq_setup return value is ignored. Handle the
> return value appropriately.

Linus,

Any comments on this? Sorry if i pinged too soon. The rest 2 of this
series were pulled by you. So just wanted to check on this one if you
had specific comments.

Regards,
Keerthy

> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/gpio/gpio-davinci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> index 27499ec..d6fb1ce 100644
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -237,7 +237,10 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>  		goto err;
>  
>  	platform_set_drvdata(pdev, chips);
> -	davinci_gpio_irq_setup(pdev);
> +	ret = davinci_gpio_irq_setup(pdev);
> +	if (ret)
> +		goto err;
> +
>  	return 0;
>  
>  err:
> 
