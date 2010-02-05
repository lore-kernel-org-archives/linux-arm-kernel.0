From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 5 Feb 2010 08:53:38 +0100
Subject: [PXA320] How to find  I/O registers, base address of ASIX
	ethernet chip?
In-Reply-To: <20100205042655.GR28972@buzzloop.caiaq.de>
References: <19621265275300@webmail108.yandex.ru>
	<20100205042655.GR28972@buzzloop.caiaq.de>
Message-ID: <20100205075338.GB31903@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Fri, Feb 05, 2010 at 05:26:55AM +0100, Daniel Mack wrote:
> On Thu, Feb 04, 2010 at 12:21:40PM +0300, Dennis Semakin wrote:
> > Configuration:
> > Computer module is Toradex Colibri PXA320.
> > Board is Colibri Evaluation Board.
> > 
> > Obviously, to access the I/O register of network card, we need to map them into memory, using the ioremap() function.
> > To do this driver (ax88796.c) use platform_get_resource() function to get the physical address of the I/O registers from the board definition (arch/arm/mach-pxa/colibri-pxa320.c). This function returns a pointer to a struct resource, which contains two interesting fields : start and end (both are physical address).
> > Then call ioremap function to remap the memory area returned by platform_get_resource.
> > Right?
> > 
> > Ok. When I start kernel on my board, kernel loading stops on network initialization during call to the address resource.start.
> > So, what could I do if the address (field start in resource structure) is not valid?
> > Can I find it? (I mean address) Maybe I should ask something: where are ethernet chip I/O registers mapped in the memory?
> 
> The addresses passed to the driver is the I/O area of the chip select
> signal used for the Ethernet chip. This setting should be alright, as it
> worked well for me.
> 
> If your kernel hangs when accessing this area, you most probably haven't
> set up your static bus correctly. The bootloader is in charge of doing
> this, and the correct value for CSADRCFG2 is 0x0032C809.
I would prefer if Linux didn't rely on the boot loader for that.  It's
not expensive or difficult to set this register in machine setup code,
is it?

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
