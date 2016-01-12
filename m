From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Tue, 12 Jan 2016 09:39:41 +0100
Subject: [PATCH v2] spi: atmel: improve internal vs gpio chip-select choice
In-Reply-To: <1452528102-26458-1-git-send-email-mans@mansr.com>
References: <1452528102-26458-1-git-send-email-mans@mansr.com>
Message-ID: <5694BBCD.8020700@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mans,

I've tried to apply your patch on a next-20160112 branch to test it but it
failed. I've also looked at the for-next branch of the SPI sub-system git
tree.

It seems that one issue occurred within a chunk patching the atmel_spi_setup()
function. Please see below.

Le 11/01/2016 17:01, Mans Rullgard a ?crit :
[...]
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 08cbb3e43c76..d4a806e24060 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
[...]
> @@ -1603,6 +1611,7 @@ static int atmel_spi_setup(struct spi_device *spi)
>  		}
>  
>  		asd->npcs_pin = npcs_pin;
> +		asd->use_cs_gpio = use_cs_gpio;
>  		spi->controller_state = asd;
>  	} else {
>  		atmel_spi_lock(as);
[...]

There is no 'else' statement in the source code I'm looking at.

Best regards,

Cyrille
