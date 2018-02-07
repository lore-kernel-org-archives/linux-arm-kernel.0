From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Wed, 7 Feb 2018 17:43:15 +0100
Subject: [PATCH 2/2] usb: gadget: udc: atmel: convert to use GPIO
 descriptors
In-Reply-To: <CACRpkdYe-caycymfzosGTgnQUgf2jrLU9vfJEsT+bupqexCAxQ@mail.gmail.com>
References: <20180201093432.21919-1-ludovic.desroches@microchip.com>
 <20180201093432.21919-2-ludovic.desroches@microchip.com>
 <CACRpkdYe-caycymfzosGTgnQUgf2jrLU9vfJEsT+bupqexCAxQ@mail.gmail.com>
Message-ID: <20180207164315.GJ2580@rfolt0960.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 07, 2018 at 02:55:35PM +0100, Linus Walleij wrote:
> On Thu, Feb 1, 2018 at 10:34 AM, Ludovic Desroches
> <ludovic.desroches@microchip.com> wrote:
> 
> > Use GPIO descriptors instead of relying on the old method.
> > Include irq.h header since it is needed and was indirectly
> > included through of_gpio.h.
> >
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Thank you for doing gpiod conversions. Making the world
> a better place!

Thanks, I wish it would be so easy!

I will send a v2 because I have the same issue that the one pointed by
Andy about the gpiod conversion for the lcd driver.

- udc->vbus_pin = devm_gpiod_get_optional(&pdev->dev, "atmel,vbus", GPIOD_IN);
+ udc->vbus_pin = devm_gpiod_get(&pdev->dev, "atmel,vbus", GPIOD_IN);
+ if (IS_ERR(udc->vbus_pin))
+ 	udc->vbus_pin = NULL;

I am not sure if I should prefer devm_gpiod_get_optional or
devm_gpiod_get.

Regards

Ludovic
