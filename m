From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Mar 2016 13:03:38 +0000
Subject: 4.5.0-rc6: kernel BUG at ../mm/memory.c:1879
In-Reply-To: <56DD795C.9020903@suse.cz>
References: <nbjnq6$fim$1@ger.gmane.org>
 <56DD795C.9020903@suse.cz>
Message-ID: <20160307130338.GI19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07, 2016 at 01:51:40PM +0100, Vlastimil Babka wrote:
> [+CC ARM, module maintainers/lists]
> 
> On 03/07/2016 12:14 PM, Matwey V. Kornilov wrote:
> >
> >Hello,
> >
> >I see the following when try to boot 4.5.0-rc6 on ARM TI AM33xx based board.
> >
> >     [   13.907631] ------------[ cut here ]------------
> >     [   13.912323] kernel BUG at ../mm/memory.c:1879!
> 
> That's:
> BUG_ON(addr >= end);
> 
> where:
> end = addr + size;
> 
> All these variables are unsigned long, so they overflown?
> 
> I don't know ARM much, and there's no code for decodecode, but if I get the
> calling convention correctly, and the registers didn't change, both addr is
> r1 and size is r2, i.e. both bf006000. Weird.

A fix has been recently merged for this.  Look out for
"ARM: 8544/1: set_memory_xx fixes"

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
