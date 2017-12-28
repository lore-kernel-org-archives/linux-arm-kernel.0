From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 28 Dec 2017 10:56:46 +0530
Subject: [PATCH] pinctrl/spear/plgpio: Delete two error messages for a
 failed memory allocation in plgpio_probe()
In-Reply-To: <66c3f488-ffdf-e55d-e511-e4af35e670b4@users.sourceforge.net>
References: <66c3f488-ffdf-e55d-e511-e4af35e670b4@users.sourceforge.net>
Message-ID: <20171228052646.GC8652@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27-12-17, 22:39, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 27 Dec 2017 22:34:28 +0100
> 
> Omit extra messages for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/pinctrl/spear/pinctrl-plgpio.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/spear/pinctrl-plgpio.c b/drivers/pinctrl/spear/pinctrl-plgpio.c
> index 6a0ed8ab33b9..d2123e396b29 100644
> --- a/drivers/pinctrl/spear/pinctrl-plgpio.c
> +++ b/drivers/pinctrl/spear/pinctrl-plgpio.c
> @@ -519,10 +519,8 @@ static int plgpio_probe(struct platform_device *pdev)
>  	int ret, irq;
>  
>  	plgpio = devm_kzalloc(&pdev->dev, sizeof(*plgpio), GFP_KERNEL);
> -	if (!plgpio) {
> -		dev_err(&pdev->dev, "memory allocation fail\n");
> +	if (!plgpio)
>  		return -ENOMEM;
> -	}
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	plgpio->base = devm_ioremap_resource(&pdev->dev, res);
> @@ -544,10 +542,8 @@ static int plgpio_probe(struct platform_device *pdev)
>  			sizeof(*plgpio->csave_regs) *
>  			DIV_ROUND_UP(plgpio->chip.ngpio, MAX_GPIO_PER_REG),
>  			GFP_KERNEL);
> -	if (!plgpio->csave_regs) {
> -		dev_err(&pdev->dev, "csave registers memory allocation fail\n");
> +	if (!plgpio->csave_regs)
>  		return -ENOMEM;
> -	}
>  #endif
>  
>  	platform_set_drvdata(pdev, plgpio);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
