From: martinwguy@gmail.com (Martin Guy)
Date: Sun, 9 May 2010 17:47:34 +0100
Subject: [PATCH v7 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <20100509092917.GR26418@gw.healthdatacare.com>
References: <cover.1273120206.git.mika.westerberg@iki.fi>
	<3729cd3650f5af6aebfc5bae02ff6aad1b9b1e82.1273120206.git.mika.westerberg@iki.fi>
	<AANLkTimZywbu5KVvnUouLUoY1GUxWGlYoSgIbUlRDT5w@mail.gmail.com>
	<20100509092917.GR26418@gw.healthdatacare.com>
Message-ID: <AANLkTiks2l9N1uXisctdI3aiNmFavIHzvwbOTcgeFGbZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/9/10, Mika Westerberg <mika.westerberg@iki.fi> wrote:
> On Sat, May 08, 2010 at 06:32:47PM +0100, Martin Guy wrote:
>  > On 5/6/10, Mika Westerberg <mika.westerberg@iki.fi> wrote:
>  > > This patch adds an SPI master driver for the Cirrus EP93xx SPI controller found
>  > >  in EP93xx chips.
>
> >    I'm confused by the change in this version of the structure of the
>  > board setup code.
>
>  For Sim.One, I modified your patches a bit and resulting patch is
>  included. Note that I have hooked EGPIO9 as a chip select but in
>  normal case (SFRMOUT) you can just do following (leave .controller_data
>  as NULL):

Many thanks. If you want to submit this to mainline there are just a
couple of changes to make:

> +#define MMC_CHIP_SELECT_GPIO EP93XX_GPIO_LINE_EGPIO9

EGPIO9 is part of the keyboard controller - I don't think we can
hijack that for a patch to the mainline kernel! I've used EGPIO15
which is unused and on TP17 just south of the CPU.

>                 .mode                   = SPI_MODE_0,

Using SPI_MODE_3 increases the read speed from 319 kB/s to 367 kB/s -
even when using a GPIO as the chip select.

Your 4GB card fix works here too, though I'm seeing no difference in
anything between using SFRMOUT and a GPIO for the chip select. Did you
see any functionality or performance improvements using a GPIO for CS
with the SD cards you are testing?

Thanks again

    M
