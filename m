From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Oct 2011 23:44:12 +0100
Subject: Please help with the OMAP static mapping mess
In-Reply-To: <alpine.LFD.2.02.1110031744100.9106@xanadu.home>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
	<20111003205658.GJ6324@atomide.com>
	<alpine.LFD.2.02.1110031744100.9106@xanadu.home>
Message-ID: <20111003224411.GA19897@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2011 at 06:09:57PM -0400, Nicolas Pitre wrote:
> On Mon, 3 Oct 2011, Tony Lindgren wrote:
> > Having the SRAM base address move around with different sizes also
> > requires the SoC detection.. Otherwise we can end up mapping wrong
> > size and end up trying to access secure SRAM that will hang the system.
> > 
> > The way to fix it is to move SRAM init happen much later so we don't
> > have to map it early. I guess now we could use ioremap for SRAM,
> > although we may not want device attributes for the executable code?
> > Got any suggestions here on how we should map SRAM later on?
> 
> You can use a variant of ioremap() such as __arm_ioremap() which let you 
> specify the memory attribute.

Just be aware that __arm_ioremap() always ends up with stuff in the
kernel domain, but that's not what you end up with using create_mapping().
So I'd prefer it if you didn't suggest that __arm_ioremap() should be used
with types not listed in asm/io.h.
