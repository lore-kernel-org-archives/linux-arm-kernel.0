From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 26 Sep 2011 16:00:11 -0400 (EDT)
Subject: Pull request: removal of most instances of mach/memory.h
In-Reply-To: <20110926191055.GP22455@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1109062158450.20358@xanadu.home>
	<alpine.LFD.2.00.1109130849590.20358@xanadu.home>
	<alpine.LFD.2.00.1109201349400.12663@xanadu.home>
	<20110926131524.GJ22455@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109260952490.2718@xanadu.home>
	<alpine.LFD.2.00.1109261023360.2718@xanadu.home>
	<20110926191055.GP22455@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1109261514330.2718@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 26 Sep 2011, Russell King - ARM Linux wrote:

> On Mon, Sep 26, 2011 at 10:33:28AM -0400, Nicolas Pitre wrote:
> >       ARM: mach-ep93xx: remove mach/memory.h and Kconfig selection of SDRAM bank
> 
> Are you planning to totally kill off ZBOOT_ROM too?  Because removing
> the zreladdr stuff is doing exactly that.

It looks like ZBOOT_ROM is not used on that platform at all.  However, 
the ability to have a single defconfig and binary for the whole platform 
is something that the mach-ep93xx maintainers are looking for.  Having 
ZBOOT_ROM depend on and use CONFIG_PHYS_OFFSET would probably makes 
sense eventually.

> This also gives additional merge conflicts elsewhere, and while git
> rerere makes some of them easy, the quantity is going to be a right
> pain to deal with on a repeated basis.

Again, I'm perfectly willing to use a different base for this series and 
fix the conflicts myself if you give me one.


Nicolas
