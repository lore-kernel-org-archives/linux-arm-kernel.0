From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 13 Dec 2013 17:31:15 -0700
Subject: [PATCH 5/5] arm64: Add LOAD_OFFSET symbol for linker scripts
In-Reply-To: <1386980430.1002.96.camel@smoke>
References: <cover.1386879684.git.geoff@infradead.org>
 <92660d1b81279aa6784a33eff2f102e78d883931.1386879684.git.geoff@infradead.org>
 <20131213164517.GM19177@mudshark.cambridge.arm.com>
 <1386980430.1002.96.camel@smoke>
Message-ID: <20131214003115.GI12904@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 04:20:30PM -0800, Geoff Levand wrote:
> > Can you be more specific about why we need this please? We don't seem to use
> > this on ARM, and I can't really think of a sensible value to define it as,
> > either. PAGE_OFFSET is a virtual address, which doesn't make much sense to
> > me, but perhaps I'm missing something.
> 
> As I mentioned before, LOAD_OFFSET defaults to zero if it is not defined by the
> arch, so our arm64 vmlinux files currently have their paddr's equal to their
> vaddr's, so something like 0xffffffc000080000.

FWIW, I posted a similar patch for ARM32 last year:

https://lkml.org/lkml/2012/9/30/145

We are using it here to convey to desired load address to the boot
loader. My patch makes LOAD_OFFSET equal to PLAT_PHYS_OFFSET for
non-relocatable kernels, 0 otherwise.

If ARM64 takes Geoffs changes I can resend my patch for ARM32.

Regards,
Jason
