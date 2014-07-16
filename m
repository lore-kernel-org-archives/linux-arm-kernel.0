From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Wed, 16 Jul 2014 10:59:24 +0200
Subject: [PATCH v3 08/12] Documentation: bindings: add doc for the USB2
 ChipIdea USB driver
In-Reply-To: <23972141.94aiK9jz66@wuerfel>
References: <1405499166-6726-1-git-send-email-antoine.tenart@free-electrons.com>
 <1405499166-6726-9-git-send-email-antoine.tenart@free-electrons.com>
 <23972141.94aiK9jz66@wuerfel>
Message-ID: <20140716085924.GA28151@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Jul 16, 2014 at 10:39:36AM +0200, Arnd Bergmann wrote:
> On Wednesday 16 July 2014 10:26:02 Antoine T?nart wrote:
> > +
> > +Required properties:
> > +- compatible: should be "chipidea,usb2"
> > +- reg: base address and length of the registers
> > +- interrupts: interrupt for the USB controller
> > +
> > +Optional properties:
> > +- clocks: reference to the USB clock
> > +- usb-phy: reference to the USB PHY
> 
> I think the phy reference should use the standard phy binding, using
> "phys" property to refer to a node that has a "#phy-cells" property.
> 
> It seems the code gets this right, but just the documentation is wrong.

I moved this PHY driver from usb/phy/ to phy/ and forgot to update this
property. I'll fix it.

> 
> > +- vbus-supply: reference to the VBUS regulator
> > +- dma-mask: DMA bit mask
> 
> No. Do not use "dma-mask" as a property, that is a pure Linux specific
> concept. The DT way to express this is to use the 'dma-ranges' property
> in the device's parent to describe any bus-related restrictions, and
> for the driver to ask for a mask that matches what the hardware is
> capable of (which may be smaller or larger than what the bus supports).

Ok. I'll answer in the CI driver's thread.

Thanks!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
