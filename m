From: rabin@rab.in (Rabin Vincent)
Date: Mon, 11 Oct 2010 22:45:55 +0530
Subject: [PATCH 2/2] ftrace - add ftrace function_graph support on ARM
In-Reply-To: <20101011082535.GA26355@n2100.arm.linux.org.uk>
References: <4B91A39F.8050502@am.sony.com>
	<20100306201849.GD13262@n2100.arm.linux.org.uk>
	<AANLkTi=apGYBSSr4RK+ZZievacJRcOxrwW_o_hz85P0h@mail.gmail.com>
	<20101009193757.GB28183@n2100.arm.linux.org.uk>
	<20101010220603.GA2723@debian>
	<20101011082535.GA26355@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=33EUPFLzTr3zRHL1+CEm7JpqU18cFzzmpbAsG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 1:55 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> And now to go back to the original question I asked: What is __irq_entry
> used for?

It's used to identify when we're inside the interrupt handling path.
Depending upon the tracing options ("funcgraph-irqs"), this can be
excluded from the trace output.

> If it's to identify those functions which can't be traced through because
> of the stack layout, that's true of all __exception marked functions -
> so we might as well make the linker symbols for irqentry alias the
> exception text symbols.
>
> I see nothing special of just the three functions you mention that warrant
> them being handled separately by ftrace.

See above.  The funcgraph-irqs option is supposed to only affect the
interrupt handling path, not all exception handling.
