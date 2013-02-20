From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 20 Feb 2013 10:13:54 +0200
Subject: [PATCH v4 02/11] gpio: pxa: clean code with same variable name
In-Reply-To: <1361290948-16669-3-git-send-email-haojian.zhuang@linaro.org>
References: <1361290948-16669-1-git-send-email-haojian.zhuang@linaro.org>
 <1361290948-16669-3-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <512485C2.50504@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/13 18:22, Haojian Zhuang wrote:
> Clean code to avoid similar variable. Now use gc for gpio_chip,
> and use c/chip for pxa_gpio_chip. It's used to avoid confusion.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Tested-by: Igor Grinberg <grinberg@compulab.co.il>

Minor issue below for your consideration.

> ---
>  drivers/gpio/gpio-pxa.c |  102 +++++++++++++++++++++++------------------------
>  1 file changed, 50 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
> index a4c6687..e611bed 100644
> --- a/drivers/gpio/gpio-pxa.c
> +++ b/drivers/gpio/gpio-pxa.c

[...]

> @@ -147,7 +147,7 @@ static inline int __gpio_is_occupied(unsigned gpio)
>  	int ret, af = 0, dir = 0;
>  
>  	pxachip = gpio_to_pxachip(gpio);
> -	base = gpio_chip_base(&pxachip->chip);
> +	base = gpio_chip_base(&pxachip->gc);

I don't mind leaving this as it is, but according
to your commit message, the above should be:
c/chip = gpio_to_pxachip(gpio);
base = gpio_chip_base(&c/chip->gc);

For your consideration.

>  	gpdr = readl_relaxed(base + GPDR_OFFSET);
>  
>  	switch (gpio_type) {

[...]


-- 
Regards,
Igor.
