From: broonie@kernel.org (Mark Brown)
Date: Thu, 24 May 2018 19:15:04 +0100
Subject: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
In-Reply-To: <0e6e71e2-f8ac-7889-0d81-8d8a4c15223d@microchip.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-6-radu.pirea@microchip.com>
 <CAHp75Ve3Ugnjjm8EZkPQTZSvH1qad1e5SqjOn8zz5syHSQea_g@mail.gmail.com>
 <5a3930b867cf8c279953d08c5d5dd1d93113a43b.camel@microchip.com>
 <CAHp75VdRrL25Jgnbk64Qqc5RY3uJdcntJ3xwRdp3F+rRFeTHBA@mail.gmail.com>
 <c23cdde58b9f724f51787c6c38478df983be6efa.camel@microchip.com>
 <20180517045437.GE20254@sirena.org.uk>
 <0e6e71e2-f8ac-7889-0d81-8d8a4c15223d@microchip.com>
Message-ID: <20180524181504.GD4828@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 07:04:11PM +0300, Radu Pirea wrote:

>     if (ctlr->cs_gpios){
>         spi->cs_gpio = ctlr->cs_gpios[spi->chip_select];
>         if(gpio_is_valid(spi->cs_gpio))
>             gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
> 
>     }

You're expected to request the GPIOs in your driver using one of the
modern request functions like gpio_request_one() (or ideally the GPIO
descriptor APIs now) which combine the direction setting and request
into a single operation.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180524/afe4d42a/attachment.sig>
