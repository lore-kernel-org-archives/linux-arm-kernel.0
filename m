From: giometti@enneenne.com (Rodolfo Giometti)
Date: Tue, 17 Nov 2009 19:02:00 +0100
Subject: [PATCH] arm pxa: remove "direction input" forcing for IRQ GPIOs
In-Reply-To: <20091117171116.GB14091@buzzloop.caiaq.de>
References: <1258456906-12338-1-git-send-email-giometti@linux.it>
	<20091117114429.GT14091@buzzloop.caiaq.de>
	<20091117120501.GC8008@gundam.enneenne.com>
	<20091117123422.GU14091@buzzloop.caiaq.de>
	<20091117123721.GG8008@gundam.enneenne.com>
	<20091117124334.GW14091@buzzloop.caiaq.de>
	<20091117125953.GI8008@gundam.enneenne.com>
	<20091117130653.GX14091@buzzloop.caiaq.de>
	<20091117143846.GK8008@gundam.enneenne.com>
	<20091117171116.GB14091@buzzloop.caiaq.de>
Message-ID: <20091117180200.GL4737@enneenne.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2009 at 06:11:16PM +0100, Daniel Mack wrote:
> On Tue, Nov 17, 2009 at 03:38:47PM +0100, Rodolfo Giometti wrote:
> > On Tue, Nov 17, 2009 at 02:06:53PM +0100, Daniel Mack wrote:
> > > On Tue, Nov 17, 2009 at 01:59:53PM +0100, Rodolfo Giometti wrote:
> > > > On Tue, Nov 17, 2009 at 01:43:34PM +0100, Daniel Mack wrote:
> > > 
> > > No, that's exactly my point. You don't need to set the pin to output
> > > direction to make use of those pull features. More than that, when
> > > confiugured as output, the pull flags actually don't make sense.
> > 
> > I just looking at pxa27x user manual but I don't see such pull-up
> > functionality... are you sure these settings aren't pxa3xx specific?
> > =:-o
> 
> I haven't checked the datasheet but the header files that defines this
> macro only. And it didn't appear to be PXA3x specific.

I cannot find such register nor pull-up/down management into whole
PXA27x user manual.

> Anyway, if this is unavailable on your hardware, the proper way would be
> to place an external resistor on the board (given that you can modify
> the schematics).

Why should I do as you suggest when the CPU can support such
electrical configuration?

> I'm still not convinced that driving the pad as output GPIO and then
> applying a different level externally to generate an IRQ is intended.

No external different level applyed! Just a pull-down enabled by a
machanical switch: if no cards are inserted I read 1 but if I insert a
card I got 0 due the pull-down enabling.

I tested the code on my hardware who works perfectly.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti at enneenne.com
Linux Device Driver                          giometti at linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
