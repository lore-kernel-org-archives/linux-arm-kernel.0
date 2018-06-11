From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Mon, 11 Jun 2018 17:36:32 +0200
Subject: [PATCH v6 3/6] mfd: at91-usart: added mfd driver for usart
In-Reply-To: <20180607110020.20565-4-radu.pirea@microchip.com>
References: <20180607110020.20565-1-radu.pirea@microchip.com>
 <20180607110020.20565-4-radu.pirea@microchip.com>
Message-ID: <20180611153632.GG10521@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2018 14:00:17+0300, Radu Pirea wrote:
> +static int at91_usart_mode_probe(struct platform_device *pdev)
> +{
> +	struct mfd_cell cell;
> +	u32 opmode;

This has to be initialized to AT91_USART_MODE_SERIAL...

> +	int err;
> +
> +	err = device_property_read_u32(&pdev->dev, "atmel,usart-mode", &opmode);
> +

because if the property is not present, then opmode will not be modified
which means it could hold the value of AT91_USART_MODE_SPI.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
