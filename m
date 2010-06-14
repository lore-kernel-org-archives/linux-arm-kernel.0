From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 14 Jun 2010 15:29:58 +0100
Subject: Request review of device tree documentation
In-Reply-To: <20100614094740.GB7881@n2100.arm.linux.org.uk>
References: <1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
	<1276408773.1962.574.camel@pasglop>
	<AANLkTinwL0XtMNG13inr_1UliOlqZkyr4dlvG-ZGL9JT@mail.gmail.com>
	<20100614073828.GA6095@n2100.arm.linux.org.uk>
	<4C15DE2E.1050905@firmworks.com>
	<20100614092559.GA7881@n2100.arm.linux.org.uk>
	<1276508170.2552.43.camel@pasglop>
	<20100614094740.GB7881@n2100.arm.linux.org.uk>
Message-ID: <20100614142958.GA9550@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Mon, Jun 14, 2010 at 07:36:10PM +1000, Benjamin Herrenschmidt wrote:
> > However, there's a lot of room for abuse here and I'm worried that if it
> > becomes widespread, we'll start seeing vendors use that as a way to do
> > some kind of HAL and hide various platform methods in there (clock
> > control, nvram, etc...).
> 
> This is what I'm worried about too.
> 
> As I said in my first reply in this thread, calling out from the kernel
> will kill performance due to the time taken to shut down the caches and
> MMU, which can only be done safely with all exceptions turned off.

Some applications use ARM (or other "embedded"-ish CPU) as opposed to
x86 PCs, to get predictable and reasonable interrupt latency.

x86 PCs sometimes have unpredictable interrupt latency due to those
mystery interrupts that the BIOS handles and the OS can't see or
block.  It's a different cause, but let's not duplicate the symptom
where it isn't wanted.

Even if opaque firmware callouts were fast, it would be an issue with
real-time kernels if they couldn't depend on that as an auditable fact.

-- Jamie
