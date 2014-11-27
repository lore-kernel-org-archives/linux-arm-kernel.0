From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 27 Nov 2014 12:33:34 +0000
Subject: [STLinux Kernel] [PATCH 1/4] spi: Add new driver for
 STMicroelectronics' SPI Controller
In-Reply-To: <1417088636-11994-2-git-send-email-lee.jones@linaro.org>
References: <1417088636-11994-1-git-send-email-lee.jones@linaro.org>
 <1417088636-11994-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20141127123334.GA20048@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

<snip>

> +static int spi_st_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	struct spi_master *master;
> +	struct resource *res;
> +	struct spi_st *spi_st;
> +	int num_cs, cs_gpio, i, ret = 0;
> +	u32 var;
> +	
> +	printk("LEE: %s: %s()[%d]: Probing\n", __FILE__, __func__, __LINE__);

You've left a debug print in here.

regards,

Peter.
