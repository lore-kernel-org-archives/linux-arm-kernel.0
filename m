From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 28 Jun 2011 14:24:07 +0100
Subject: Problem with GDB when debugging IRQ handlers
In-Reply-To: <20110628120928.GD21898@n2100.arm.linux.org.uk>
References: <20110627125306.GA30646@doriath.ww600.siemens.net>
	<20110627132735.GE16103@n2100.arm.linux.org.uk>
	<4E088DE1.2060809@gmail.com> <4E089AB3.1090801@codesourcery.com>
	<20110628103946.GC21898@n2100.arm.linux.org.uk>
	<BANLkTi=zjTerne0VbYq-6NaPBuXcZBDGjA@mail.gmail.com>
	<20110628120928.GD21898@n2100.arm.linux.org.uk>
Message-ID: <20110628132407.GB7255@1n450.cable.virginmedia.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 01:09:28PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 28, 2011 at 08:06:27PM +0800, Hui Zhu wrote:
> > If this kernel didn't open FRAME_POINTER, what will happen?
> 
> I can't answer that question directly, as I don't use a toolchain new
> enough to generate proper unwind information.
> 
> However, I haven't seen any problems being reported on the list with
> bad/broken backtraces from the kernel, so my _assumption_ is that the
> kernel is fine with its own debug info.

I tested this when contributing the unwinding support and it was ok. The
reason is that the svc_entry macro in entry-armv.S adds some annotations
line .fnstart and .save that generate the correct unwinding bytecodes
(but as I said, that's different from the dwarf information which
probably needs different annotations).

-- 
Catalin
