From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Tue, 29 May 2018 11:32:00 +0200
Subject: [PATCH v4 3/6] mfd: at91-usart: added mfd driver for usart
In-Reply-To: <CAHp75VeeiFhShuMOVzuy2FjxrkfsxxzhyfAnwQNOoeaRwZ103Q@mail.gmail.com>
References: <20180525171941.26766-1-radu.pirea@microchip.com>
 <20180525171941.26766-4-radu.pirea@microchip.com>
 <CAHp75VeeiFhShuMOVzuy2FjxrkfsxxzhyfAnwQNOoeaRwZ103Q@mail.gmail.com>
Message-ID: <20180529093200.GB4793@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/05/2018 11:00:49+0300, Andy Shevchenko wrote:
> On Fri, May 25, 2018 at 8:19 PM, Radu Pirea <radu.pirea@microchip.com> wrote:
> > This mfd driver is just a wrapper over atmel_serial driver and
> > spi-at91-usart driver. Selection of one of the drivers is based on a
> > property from device tree. If the property is not specified, the default
> > driver is atmel_serial.
> 
> > +       depends on OF
> 
> What makes this driver OF specific?
> 
> > +       err = of_property_read_u32(np, "atmel,usart-mode", &opmode);
> 
> Check unified device property API.
> 

We don't care, this makes the driver OF specific and this is the correct
thing to do.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
