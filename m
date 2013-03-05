From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Tue, 5 Mar 2013 12:56:20 +0000
Subject: [PATCH v2 1/4] spi/davinci: add DT binding documentation
In-Reply-To: <6918845.dALXSKksQd@wuerfel>
References: <1362401955-9616-1-git-send-email-prakash.pm@ti.com>
 <1362401955-9616-2-git-send-email-prakash.pm@ti.com>
 <6918845.dALXSKksQd@wuerfel>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA4854E@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Mar 04, 2013 at 21:59:16, Arnd Bergmann wrote:
> On Monday 04 March 2013 18:29:12 Manjunathappa, Prakash wrote:
> > diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
> > new file mode 100644
> > index 0000000..a62d7a8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/spi-davinci.txt
> > @@ -0,0 +1,51 @@
> > +Davinci SPI controller device bindings
> > +
> > +Required properties:
> > +- #address-cells: number of cells required to define a chip select
> > +	address on the SPI bus. Should be set to 1.
> > +- #size-cells: should be zero.
> > +- compatible:
> > +	- "ti,dm644x-spi" for SPI used similar to that on DM644x SoC family
> > +	- "ti,da8xx-spi" for SPI used similar to that on DA8xx SoC family
> 
> In general, you should avoid wildcards in "compatible" properties.
> Better use the number of the first chip that introduced the specific
> version of the device.
> 

Correct, will accommodate this change.

> > +- reg: Offset and length of SPI controller register space
> > +- num-cs: Number of chip selects
> > +- ti,davinci-spi-intr-line: interrupt line used to connect the SPI
> > +	IP to the interrupt controller withn the SoC. Possible values
> > +	are 0 and 1. Manual says one of the two possible interrupt
> > +	lines can be tied to the interrupt controller. Set this
> > +	based on a specifc SoC configuration.
> > +- interrupts: interrupt number offset at the irq parent
> 
> I would not call this an "offset". It is an interrupt descriptor
> which may be something other than a simple number.
> 

I am planning to drop from this documentation as it is common property.

> Unfortunately, there is no way to provide an "invalid" interrupt,
> otherwise you could just list both interrupts, out of which at
> least one should be valid, and drop the ti,davinci-spi-intr-line
> property.
> 

This is different from interrupt number, this is used to specifies out
of 2 lines from SPI IP which is tied to INTC. Some discussion about it:
https://lkml.org/lkml/2012/11/16/404
	
> One thing you could do instead though is to use the "interrupt-names"
> property to define "irq0" and "irq1" interrupts, and in the
> implementation use the first one you find.
> 

In IP specification it is mentioned as spi-intr-line, I prefer to retain this
property as davinci-spi-intr-line.

Thanks,
Prakash
