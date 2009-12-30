From: swami.iyer@ti.com (Subbrathnam, Swaminathan)
Date: Wed, 30 Dec 2009 18:32:56 +0530
Subject: [PATCH RFC 1/2] MUSB: CPPI 4.1 DMA driver (take 4)
In-Reply-To: <20091230122441.GA16585@gandalf>
References: <19F8576C6E063C45BE387C64729E7394044A2779F5@dbde02.ent.ti.com>
	<19F8576C6E063C45BE387C64729E7394044A2779F6@dbde02.ent.ti.com>
	<20091229125403.GD17147@nokia.com>
	<FCCFB4CDC6E5564B9182F639FC35608702FFF44876@dbde02.ent.ti.com>,
	<20091230122441.GA16585@gandalf>
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FFF4487C@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe,

This code is also being used for other architectures such as OMAP3517,
OMAPL13x etc.

Given this I do not think we can locate it under a mach-* directory.

Have corrected the wrap issue.  Thanks for point it out.

regards
swami

________________________________________
From: Felipe Balbi [me at felipebalbi.com]
Sent: Wednesday, December 30, 2009 5:54 PM
To: Subbrathnam, Swaminathan
Cc: felipe.balbi at nokia.com; Gupta, Ajay Kumar; linux-usb at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Sergei Shtylyov
Subject: Re: [PATCH RFC 1/2] MUSB: CPPI 4.1 DMA driver (take 4)

Hi,

please wrap your mails at 80 characters

On Wed, Dec 30, 2009 at 09:16:08AM +0530, Subbrathnam, Swaminathan
wrote:
> We have been on this front months together now!!! Ideally the place
> holder would be a place independant of platforms as this piece of code
> is more of a platform independant library relating to TI CPPI DMA
> operations.  This would be used during initialization and confiuration
> of CPPI4.x based peripherals.  Though today USB is the only peripheral
> that falls in that catagory ideally other like TI EMAC could fall in
> the same space.
>
> Having said that I also see that there seems to be no roadmap/plan for
> any other peripheral other than USB to use CPPI4.x in the near future.
> TI EMAC seems to continue use CPPI3.x.
>
> This was the reason I had recommended earlier to locate this generic
> CPPI 4.x functionality within MUSB.  This definitely helps in having a
> functional peripheral in the near (and most probably long) term.
>
> I think it is prudent to locate this functionality in the musb
> directory for now.  In future if need arises we can relook at this
> later (I am sure this in all probabilities would not be required).
>
> In either way I would really appreiciate if we can come to a
> conclusion at the earliest.  Appreciate everybody's feedback and
> direction.

You can do like omap and have the generic dma interface sitting in
mach-davinci, then for musb, you'd have a series of wrappers to use the
cppi dma code. Just look at arch/arm/plat-omap/dma.c and
drivers/usb/musb/tusb6010_omap.c

--
balbi
