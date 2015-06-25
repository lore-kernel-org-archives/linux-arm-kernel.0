From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 25 Jun 2015 11:08:28 +0200
Subject: imx6 GPIO1 interrupts
In-Reply-To: <CAMB+bfKULf-2wJbw8LH7r345_EvTOktS6zBJnNzAh69dZPtStw@mail.gmail.com>
References: <CAMB+bfKULf-2wJbw8LH7r345_EvTOktS6zBJnNzAh69dZPtStw@mail.gmail.com>
Message-ID: <20150625090828.GB6035@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

probably not helpful for your original question, but ...

On Thu, Feb 19, 2015 at 10:09:40AM -0800, Joshua Clayton wrote:
> Freescale imx6 has gpios use shared irqs that trigger across 16 pins
> at a time. These are supported in the mainline kernel.
> 
> The first 8 pins on GPIO1 also have their own interrupts on the GIC.
> I have a kluge sort of working,  and am wondering what it would take
> for me to fully support these in a way that might be mainlined.
> 
> What I am doing:
> (error checking removed for brevity)
> 
>         /* request the shared gpio irq to set the correct edge bits */
>         gpiod = gpiod_get(my->dev, "diffirq");
>         ret = gpiod_direction_input(gpiod);
... you should make this read:

	gpiod = gpiod_get(my->dev, "diffirq", GPIOD_IN);

instead. It's easier and gpiod_get with only two parameters will go away
soon.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
