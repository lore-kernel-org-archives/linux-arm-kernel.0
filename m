From: ajay.gupta@ti.com (Gupta, Ajay Kumar)
Date: Wed, 10 Feb 2010 12:16:39 +0530
Subject: [PATCH RFC 1/2] MUSB: CPPI 4.1 DMA driver (take 4)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044A96D44E@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E7394044A2779F5@dbde02.ent.ti.com>
	<19F8576C6E063C45BE387C64729E7394044A2779F6@dbde02.ent.ti.com>
	<20091229125403.GD17147@nokia.com>
	<FCCFB4CDC6E5564B9182F639FC35608702FFF44876@dbde02.ent.ti.com>
	<20091230122441.GA16585@gandalf>  <4B3B5232.5030804@ru.mvista.com>
	<1262179360.17250.6.camel@gandalf>
	<19F8576C6E063C45BE387C64729E7394044A96D44E@dbde02.ent.ti.com>
Message-ID: <19F8576C6E063C45BE387C64729E7394044A96D466@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hello.
> 
> Russell King - ARM Linux wrote:
> 
> >>>>Is there any updated patch on cppi4.1 core also?
> 
> >>>Is there _any_ cppi4.1 core patch anywhere?  Not according to google.
> 
> >>Russell,
> 
> >>Here is the latest version of cppi4.1 core.
> >>http://patchwork.kernel.org/patch/46698/
> 
> [...]
> 
> >>>If it's a USB DMA device (from the patches I can find, that seems to be
> >>>the case) then why can't it live in drivers/usb or drivers/dma ?
> >>
> >>CPPI4.1 DMA engine can be used either by USB or by Ethernet interface
> though
> >>currently only USB is using it but in future even Ethernet devices may
> use it.
> 
> > drivers/dma does seem to be the right place for this.
> 
>     Russell, it makes me wonder why drivers/dma/ seemed the right place to
> you, just because of the name? :-)
>     After spending some time on studying the infrastructure there I came
> to
> conclusion that this is not the right place because all the controllers
> supported there have features like memory-to-memory transfers or even RAID
> function offloading -- which CPPI 4.1 totally lacks (it's there purely to
> serve the peripherals).
>     Adding drivers/dma/ people to this discussion in hopes they can
> correct
> me (or support me :-)...

Russell,

Please provide your thought/suggestion on this issue which is affecting
further development of CPPI4.1 DMA driver.

As Sergei pointed out, arch/arm/common seems to be the best suited place
for this driver. Is this fine for you OR do you see any issue with this
approach?

Please let us know if you need more details.

Regards,
Ajay
> 
> WBR, Sergei
> --
