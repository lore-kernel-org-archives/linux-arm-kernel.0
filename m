From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 May 2010 19:42:56 +0100
Subject: arm926_dma_flush_range undefined!
In-Reply-To: <1273663120.23818.72.camel@e102109-lin.cambridge.arm.com>
References: <4BE2C013.4040009@atmel.com>
	<1273154831.2094.11.camel@e102109-lin.cambridge.arm.com>
	<20100506175907.GA15797@n2100.arm.linux.org.uk>
	<4BE926B5.7090602@atmel.com>
	<20100511094448.GB18828@n2100.arm.linux.org.uk>
	<4BE95C54.5070008@atmel.com>
	<20100511134409.GB27201@n2100.arm.linux.org.uk>
	<1273663120.23818.72.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100512184256.GB22371@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 12, 2010 at 12:18:40PM +0100, Catalin Marinas wrote:
> For non-aliasing VIPT hardware we still have the option of doing what
> the IA-64 and PowerPC guys have done (flushing in set_pte_at with
> PG_arch_1 meaning "clean"). It may even work for VIVT caches if we take
> care to also flush the kernel alias in set_pte_at.

It should work for VIVT as well, so lets just go ahead and negate the
PG_arch_1 meaning.  I was rather expecting this to be done a month or
so ago while we still had plenty of time before the next merge window -
and given where we are now (maybe 2 weeks away) I think it's too risky
to push into the upcoming window.

I'm already planning on scheduling the ioremap and LMB changes for the
following window, and I think this should be scheduled likewise.

> If you are ok with this approach, I'll prepare some patches (it seems
> that trying to get an agreement with other architectures isn't very
> productive).

That's what I've always found with this issue; whenever I've talked
with the mainline community about PIO cache coherency, the result has
always been non-productive.  Hence why it's always remained a problem
for us.

The issue is that too many people have their own strong ideas about
how "we" should fix the problem - and each idea is different, and they
don't accept each other's ideas.  They won't even talk to each other
and discuss their differences to resolve it either, presumably because
they see that it's not their problem to resolve.

I'm rather heartened by the outcome of your attempts to discuss this;
it has illustrated that there's no possibility of an agreement being
reached, which although sad, merely confirms my conclusion formed over
the past years.

However, thanks for making the effort; it's a shame it wasn't more
productive in the end.
