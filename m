From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 8 Feb 2010 14:06:59 +0800
Subject: [PXA320] How to find I/O registers, base address of ASIX ethernet
	chip?
In-Reply-To: <20100207051122.GK9007@buzzloop.caiaq.de>
References: <19621265275300@webmail108.yandex.ru>
	<20100205042655.GR28972@buzzloop.caiaq.de>
	<20100205075338.GB31903@pengutronix.de>
	<20100207051122.GK9007@buzzloop.caiaq.de>
Message-ID: <f17812d71002072206g13d04ef6jab12c26e54909082@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/2/7 Daniel Mack <daniel@caiaq.de>:
> On Fri, Feb 05, 2010 at 08:53:38AM +0100, Uwe Kleine-K?nig wrote:
>> On Fri, Feb 05, 2010 at 05:26:55AM +0100, Daniel Mack wrote:
>> > The addresses passed to the driver is the I/O area of the chip select
>> > signal used for the Ethernet chip. This setting should be alright, as it
>> > worked well for me.
>> >
>> > If your kernel hangs when accessing this area, you most probably haven't
>> > set up your static bus correctly. The bootloader is in charge of doing
>> > this, and the correct value for CSADRCFG2 is 0x0032C809.
>> I would prefer if Linux didn't rely on the boot loader for that. ?It's
>> not expensive or difficult to set this register in machine setup code,
>> is it?
>>
>
> The boarsds I've been working on need to set this register from the
> bootloader anyway they use Ethernet for TFTP downloads. But you're
> right, in general, there should be a way to set such registers from
> kernel space as well. Eric, any such plans?
>

I think so, the setting of CSADRCFGx and others is really something
like SMEMC initialization, provided we have a smemc.c, we might be
able to have something generic there.

> Daniel
>
