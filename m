From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 4 Dec 2013 13:41:56 +0000
Subject: [PATCH v6 3/3] mfd: max14577: Add device tree bindings document
In-Reply-To: <1386164272.6195.3.camel@AMDC1943>
References: <1386153615-25456-1-git-send-email-k.kozlowski@samsung.com>
 <1386153615-25456-4-git-send-email-k.kozlowski@samsung.com>
 <20131204112039.GC907@lee--X1> <1386164272.6195.3.camel@AMDC1943>
Message-ID: <20131204134156.GA25422@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > +MAXIM MAX14577 multi-function device
> > 
> > Why is Maxim capitalised in such a way?
> > 
> > If you're going to use the term Multi-Function Device, please
> > capitalise it.
> > 
> > > +MAX14577 is a Multi-function device with Micro-USB Interface Circuit, Li+
> > 
> > Same here.
> 
> I'll fix this. The MAXIM capitalization came from other drivers.

No need to repeat mistakes. I believe it should be Maxim.

> > > +Example:
> > > +	max14577 at 25 {
> > > +		compatible = "maxim,max14577";
> > > +		reg = <0x25>;
> > > +		interrupt-parent = <&gpx1>;
> > > +		interrupts = <5 0>;
> > 
> > I'm gussing this is IRQ5 and the 0 is flags? If so, please use
> > #defines for the flags.
> 
> This is a standard interrupt binding. The max14577 MFD core driver
> ignores the interrupt flags and always uses IRQF_TRIGGER_FALLING. I can
> fix this with new patch for drivers/mfd/max14577.c but still I don't see
> what should be added in documentation.

s/0/IRQ_TYPE_NONE

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
