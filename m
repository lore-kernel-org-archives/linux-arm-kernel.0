From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 17 Nov 2009 18:11:16 +0100
Subject: [PATCH] arm pxa: remove "direction input" forcing for IRQ GPIOs
In-Reply-To: <20091117143846.GK8008@gundam.enneenne.com>
References: <1258456906-12338-1-git-send-email-giometti@linux.it>
	<20091117114429.GT14091@buzzloop.caiaq.de>
	<20091117120501.GC8008@gundam.enneenne.com>
	<20091117123422.GU14091@buzzloop.caiaq.de>
	<20091117123721.GG8008@gundam.enneenne.com>
	<20091117124334.GW14091@buzzloop.caiaq.de>
	<20091117125953.GI8008@gundam.enneenne.com>
	<20091117130653.GX14091@buzzloop.caiaq.de>
	<20091117143846.GK8008@gundam.enneenne.com>
Message-ID: <20091117171116.GB14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2009 at 03:38:47PM +0100, Rodolfo Giometti wrote:
> On Tue, Nov 17, 2009 at 02:06:53PM +0100, Daniel Mack wrote:
> > On Tue, Nov 17, 2009 at 01:59:53PM +0100, Rodolfo Giometti wrote:
> > > On Tue, Nov 17, 2009 at 01:43:34PM +0100, Daniel Mack wrote:
> > 
> > No, that's exactly my point. You don't need to set the pin to output
> > direction to make use of those pull features. More than that, when
> > confiugured as output, the pull flags actually don't make sense.
> 
> I just looking at pxa27x user manual but I don't see such pull-up
> functionality... are you sure these settings aren't pxa3xx specific?
> =:-o

I haven't checked the datasheet but the header files that defines this
macro only. And it didn't appear to be PXA3x specific.

Anyway, if this is unavailable on your hardware, the proper way would be
to place an external resistor on the board (given that you can modify
the schematics).

I'm still not convinced that driving the pad as output GPIO and then
applying a different level externally to generate an IRQ is intended.

Daniel
