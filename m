From: paulius.zaleckas@gmail.com (Paulius Zaleckas)
Date: Sun, 17 Jan 2010 21:37:52 +0200
Subject: [PATCH] Gemini: wrong registers used to set reg_level in
	gpio_set_irq_type()?
In-Reply-To: <4B4F8877.6080105@gmail.com>
References: <4B4F8877.6080105@gmail.com>
Message-ID: <4B536710.4010304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2010 11:11 PM, Roel Kluin wrote:
> It appears the wrong GPIO registers were used
>
> Signed-off-by: Roel Kluin<roel.kluin@gmail.com>
> ---
> I am not sure whether this is right so please review.

Yes, you are right. Thanks for spotting.
I put this patch in my queue.

> diff --git a/arch/arm/mach-gemini/gpio.c b/arch/arm/mach-gemini/gpio.c
> index e726385..fe3bd5a 100644
> --- a/arch/arm/mach-gemini/gpio.c
> +++ b/arch/arm/mach-gemini/gpio.c
> @@ -86,7 +86,7 @@ static int gpio_set_irq_type(unsigned int irq, unsigned int type)
>   	unsigned int reg_both, reg_level, reg_type;
>
>   	reg_type = __raw_readl(base + GPIO_INT_TYPE);
> -	reg_level = __raw_readl(base + GPIO_INT_BOTH_EDGE);
> +	reg_level = __raw_readl(base + GPIO_INT_LEVEL);
>   	reg_both = __raw_readl(base + GPIO_INT_BOTH_EDGE);
>
>   	switch (type) {
> @@ -117,7 +117,7 @@ static int gpio_set_irq_type(unsigned int irq, unsigned int type)
>   	}
>
>   	__raw_writel(reg_type, base + GPIO_INT_TYPE);
> -	__raw_writel(reg_level, base + GPIO_INT_BOTH_EDGE);
> +	__raw_writel(reg_level, base + GPIO_INT_LEVEL);
>   	__raw_writel(reg_both, base + GPIO_INT_BOTH_EDGE);
>
>   	gpio_ack_irq(irq);
