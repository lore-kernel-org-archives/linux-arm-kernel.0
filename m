From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Nov 2014 18:38 +0100
Subject: [PATCH 00/11] ARM: at91: remove !DT support for at91rm9200
In-Reply-To: <20141127171243.GL4508@piout.net>
References: <cover.1417103399.git.nicolas.ferre@atmel.com>
 <3550407.q87bWB4Jdt@wuerfel> <20141127171243.GL4508@piout.net>
Message-ID: <27354361.uIQEXGDqXb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 18:12:43 Alexandre Belloni wrote:
> On 27/11/2014 at 17:49:50 +0100, Arnd Bergmann wrote :
> > On Thursday 27 November 2014 17:06:28 Nicolas Ferre wrote:
> > > This is the last series of patches that removes the non-Device-Tree board
> > > support for older Atmel SoCs.
> > > Again, for the record, it was announced here
> > > https://lkml.org/lkml/2014/9/10/293 ([ANNOUNCE] ARM: at91: removal of board
> > > files) two months ago.
> > > Several files beyond at91rm9200 are touched this time as I tried to remove the
> > > biggest parts that were related to !DT SoC initializations. More cleanup is
> > > certainly needed to remove dead code.
> > > 
> > > The diffstat is also pretty big as a lot of at91rm9200 boards were remaining.
> > > 
> > 
> > Awesome stuff!
> > 
> > Two questions:
> > 
> > - is anything holding this up from getting merged in 3.19?
> > 
> 
> If you think this is not too late in the cycle, I would say go ahead 

I'd say we should do it, unless there are last-minute regressions.

> > - Are there any remaining issues that keep us from using multiplatform?
> >   I know you all have been working on those a lot, but I haven't
> >   checked what is still missing.
> > 
> 
> As discussed some weeks ago, I prepared patches to switch sama5d[3-4] to
> multiplatform. We are still missing the SMC and matrix drivers to switch
> sam9 and rm9200.
> 
> The currently affected drivers are:
>  - drivers/ata/pata_at91.c (SMC)
>  - drivers/pcmcia/at91_cf.c (SMC)
>  - drivers/usb/gadget/udc/at91_udc.c (Matrix, this is the only one
>    for sam9)
>  - sound/atmel/ac97c.c (that one is still not converted to DT anyway...)
>  - drivers/watchdog/at91rm9200_wdt.c (WIP, will be converted properly to
>    an MFD)
> 
> I'll resume working on that in December.

Ok, sounds great.

> Do you want me to submit the sama5d[3-4] switch for 3.19? I'll have to
> rebase on that series. The main remaining issue is that I couldn't work
> out a way not breaking the defconfigs, even after talking with the
> Kconfig maintainer so doing first sama5 then sam9/rm9200 will break the
> defconfigs for sam9/rm9200 twice.

Probably better to do all of mach-at91 at once for 3.20 so we don't break
anything trying to make both aproaches work together.

	Arnd
