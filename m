From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 15 Jun 2015 19:50:59 +0200
Subject: [PATCH linux-next 2/2] mfd: flexcom: add a driver for Atmel
 Flexible Serial Communication Unit
In-Reply-To: <e85ceae28a0b382b12b809ac7cca891fcb7ac846.1434386119.git.cyrille.pitchen@atmel.com>
References: <cover.1434386119.git.cyrille.pitchen@atmel.com>
 <e85ceae28a0b382b12b809ac7cca891fcb7ac846.1434386119.git.cyrille.pitchen@atmel.com>
Message-ID: <20150615175059.GE17679@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 15/06/2015 at 18:38:05 +0200, Cyrille Pitchen wrote :
> +	err = of_property_read_string(pdev->dev.of_node,
> +				      "atmel,flexcom-mode", &mode);
> +	if (err)
> +		return err;
> +
> +	if (!strcmp(mode, "usart"))
> +		mr = FX_MR_USART;
> +	else if (!strcmp(mode, "spi"))
> +		mr = FX_MR_SPI;
> +	else if (!strcmp(mode, "twi") || !strcmp(mode, "i2c"))
> +		mr = FX_MR_TWI;
> +	else
> +		return -EINVAL;
> +
> +	clk_prepare_enable(clk);
> +	version = __raw_readl(map + FX_VERSION);
> +	__raw_writel(mr, map + FX_MR);
> +	clk_disable_unprepare(clk);
> +
> +	dev_info(&pdev->dev, "version: %#x\n", version);
> +

I would also print the selected mode for debugging convenience,
especially if this is used with device tree overlays.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
