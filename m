From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Oct 2011 10:25:44 +0100
Subject: [PATCH v5 11/11] ARM: pxa: add clk support in gpio driver
In-Reply-To: <1318858517-22494-12-git-send-email-haojian.zhuang@marvell.com>
References: <1318858517-22494-1-git-send-email-haojian.zhuang@marvell.com>
	<1318858517-22494-12-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20111027092544.GH19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2011 at 09:35:17PM +0800, Haojian Zhuang wrote:
> diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
> index 2d20118..d278925 100644
> --- a/drivers/gpio/gpio-pxa.c
> +++ b/drivers/gpio/gpio-pxa.c
> @@ -489,6 +492,14 @@ static int __devinit pxa_gpio_probe(struct platform_device *pdev)
>  	if (irq0 > 0)
>  		gpio_offset = 2;
>  
> +	clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk)) {
> +		printk(KERN_ERR "Error %ld to get gpio clock\n", PTR_ERR(clk));

Please use dev_err() for new error printk statements when you have a
struct device available.
