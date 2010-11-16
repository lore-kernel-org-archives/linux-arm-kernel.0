From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Nov 2010 19:33:35 +0000
Subject: [PATCH v3 15/20] ARM: LPAE: use phys_addr_t instead of
	unsigned long for physical addresses
In-Reply-To: <4CE2D811.50701@codeaurora.org>
References: <1289842829-3027-1-git-send-email-catalin.marinas@arm.com>
	<1289842829-3027-16-git-send-email-catalin.marinas@arm.com>
	<4CE2D811.50701@codeaurora.org>
Message-ID: <20101116193335.GD21926@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 11:14:25AM -0800, Stephen Boyd wrote:
> On 11/15/2010 09:40 AM, Catalin Marinas wrote:
> > @@ -188,21 +189,21 @@
> >   * translation for translating DMA addresses.  Use the driver
> >   * DMA support - see dma-mapping.h.
> >   */
> > -static inline unsigned long virt_to_phys(void *x)
> > +static inline phys_addr_t virt_to_phys(void *x)
> >  {
> >  	return __virt_to_phys((unsigned long)(x));
> >  }
> 
> As you're already in the area can you mark the argument to
> virt_to_phys() as const? I ran into a compiler warning due to that the
> other day.

It may make sense to mark it const volatile, as that's the most
permissive set of attributes possible (iow, it'll accept any pointer
without warning.)  However, might be an idea to check what other
arches do.
