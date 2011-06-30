From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 30 Jun 2011 17:09:48 +0200
Subject: kernel panic in spi_complete() on spitz (PXA270)
In-Reply-To: <1309445118.4406.47.camel@oct.suse.cz>
References: <1308845380.4533.54.camel@oct.suse.cz>
	<201106301352.21684.marek.vasut@gmail.com>
	<1309445118.4406.47.camel@oct.suse.cz>
Message-ID: <201106301709.48818.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 30, 2011 04:45:18 PM Stanislav Brabec wrote:
> Marek Vasut wrote:
> > On Thursday, June 23, 2011 06:09:40 PM Stanislav Brabec wrote:
> > > Hallo.
> > > 
> > > These Oops and kernel panic were observed on a Zaurus (spitz) machine
> > > (ARMv5, PXA270).
> > 
> > Looks similar to "Re: [PATCH v2] Input: Make ADS7846 independent on
> > regulator"
> 
> I don't see any trace in that thread. But yes, I was testing your patch
> from this thread. Without it, ADS7846 does not work on spitz (ADS7846
> does not have any dedicated regulator there). I want to
> add .needs_regulator bool to ads7846.c and send the patch again to the
> list.
> 
> After sending the trace I was able to reproduced it several times by
> attaching of external charger.
> 
> Then I tried to apply "[PATCH] MAX1111: Fix race condition causing NULL
> pointer exception", connected charger that periodically disconnects and
> not seen the crash again. No OOPS was seen after ~100 reconnects.
> 
> So I guess that MAX1111 AC voltage reading (via SPI) was involved in an
> incorrect moment and race happened there and your MAX1111 race condition
> fix fixes it.

It's not mine, it's from Pavel Herrmann actually ;-)

But yes, it's likely either this or the regulator stuff again (which I believed 
was fixed).
