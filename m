From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 12 Apr 2011 16:01:01 +0100
Subject: [RFC PATCH 1/5] gemini: convert to basic-mmio-gpio
In-Reply-To: <20110412143714.GA8931@oksana.dev.rtsoft.ru>
References: <1302522502-24381-1-git-send-email-jamie@jamieiles.com>
	<1302522502-24381-2-git-send-email-jamie@jamieiles.com>
	<20110412143714.GA8931@oksana.dev.rtsoft.ru>
Message-ID: <20110412150101.GG10225@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anton,

On Tue, Apr 12, 2011 at 06:37:14PM +0400, Anton Vorontsov wrote:
> On Mon, Apr 11, 2011 at 12:48:18PM +0100, Jamie Iles wrote:
> > The basic-mmio-gpio driver is capable of supporting this controller so
> > convert the platform to use it for basic GPIO support.
> > 
> > Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> > ---
> [...]
> > +#define GPIO_RES(__name, __addr) \
> > +	{ \
> > +		.start = (__addr), \
> > +		.end = (__addr) + 0x3, \
> > +		.flags = IORESOURCE_MEM, \
> > +		.name = #__name, \
> > +	}
> 
> Btw, how about moving this (repetitive) macro into basic_mmio_gpio.h?
> 
> Assuming, that there could be IRQ resources later, making
> something like BGPIO_MEM_RES(name, addr, sz)?

Yes, that sounds reasonable.

> Or, even better, some generic shorthand macro in linux/ioport.h?
> 
> #define IORES(__type, __name, __addr, __size)	\
> 	{					\
> 		.start = (__addr), 		\
> 		.end = (__addr) + (__size),	\
> 		.flags = IORESOURCE_##__type, 	\
> 		.name = #__name, 		\
> 	}

I'm not sure about this - it looks multiple flags can be OR'd together 
and resources nested so singling out this particular case for a macro 
doesn't feel right to me.

Jamie
