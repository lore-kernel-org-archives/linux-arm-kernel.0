From: tony@atomide.com (Tony Lindgren)
Date: Tue, 11 Oct 2011 16:58:27 -0700
Subject: [PATCH 1/7] ARM: Add __arm_ioremap_exec for mapping external
	memory as MT_MEMORY
In-Reply-To: <20111011134048.28b9b19b@queued.net>
References: <20111007194242.18205.64009.stgit@kaulin.local>
	<20111007194543.18205.36115.stgit@kaulin.local>
	<20111011134048.28b9b19b@queued.net>
Message-ID: <20111011235827.GB2293@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andres Salomon <dilinger@queued.net> [111011 14:11]:
> On Fri, 07 Oct 2011 12:45:43 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > This allows mapping external memory such as SRAM for use.
> > 
> > This is needed for some small chunks of code, such as reprogramming
> > SDRAM memory source clocks that can't be executed in SDRAM. Other
> > use cases include some PM related code.
> 
> 
> Acked-by: Andres Salomon <dilinger@queued.net>
> 
> Looks good to me, thanks for doing this.  I only have one very minor
> quibble below, which could be addressed in a later patch..

> > +void __iomem *
> > +__arm_ioremap_exec(unsigned long phys_addr, size_t size, int cached)
> 
> I'd rather see this as 'bool cached', so it's clear we're talking
> about a simple boolean (rather than bits).

Sure, thanks, updated version below. Will also update the patch in
Russell's patch system.

Tony
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ioremap-exec.patch
Type: text/x-diff
Size: 1937 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111011/a970586f/attachment-0001.bin>
