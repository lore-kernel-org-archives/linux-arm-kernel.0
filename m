From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Jan 2010 00:15:23 +0000
Subject: defining ZRELADDR as PHYS_OFFSET + TEXT_OFFSET
In-Reply-To: <20100127101228.GA17421@pengutronix.de>
References: <20100127101228.GA17421@pengutronix.de>
Message-ID: <20100128001523.GA608@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 11:12:28AM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> currently all platforms need to define zreladdr-y in
> arch/arm/mach-$mach/Makefile.boot and PHYS_OFFSET (in
> arch/arm/mach-$mach/include/mach/memory.h).
> 
> Constraints for these are:
> 
>  TEXTADDR = PAGE_OFFSET + TEXT_OFFSET
>  __virt_to_phys(virt) = virt - PAGE_OFFSET + PHYS_OFFSET (at least for
> 	"small" virtual addresses)
>  ZRELADDR = __virt_to_phys(TEXTADDR)
> 
> (The equallity for __virt_to_phys only holds "normaly" according to
> http://lists.arm.linux.org.uk/lurker/message/20010723.185051.94ce743c.en.html.
> In practice it holds for addresses of the first bank of RAM which is
> enough for the purposes of this mail.)
> 
> So we can deduce ZRELADDR = PHYS_OFFSET + TEXT_OFFSET.
> 
> Is there something I missed or is it possible to get rid of zreladdr-y
> in .../Makefile.boot and define it according to the equation above?

You'd need to find some way to get PHYS_OFFSET out of the C code
into the makefile.  With all sorts of stuff going on in various
platforms memory.h files, that doesn't look simple.
