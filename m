From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 09 Nov 2009 10:34:06 +0000
Subject: [PATCH 4/4] RealView: Add sparsemem support for the RealView
	PBX platform
In-Reply-To: <20091109101822.GA15646@n2100.arm.linux.org.uk>
References: <20091015121927.739.32071.stgit@pc1117.cambridge.arm.com>
	<20091015122209.739.42849.stgit@pc1117.cambridge.arm.com>
	<20091108174503.GB28368@n2100.arm.linux.org.uk>
	<1257760300.21820.23.camel@pc1117.cambridge.arm.com>
	<20091109101822.GA15646@n2100.arm.linux.org.uk>
Message-ID: <1257762846.21820.27.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-11-09 at 10:18 +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 09, 2009 at 09:51:40AM +0000, Catalin Marinas wrote:
> > On Sun, 2009-11-08 at 17:45 +0000, Russell King - ARM Linux wrote:
> > > On Thu, Oct 15, 2009 at 01:22:09PM +0100, Catalin Marinas wrote:
> > > > +config ARCH_FLATMEM_ENABLE
> > > > +	bool
> > > > +	default y if ARCH_SPARSEMEM_ENABLE
> > > > +
> > > 
> > > I seem to have missed this.  Why do we want to enable flatmem support for
> > > _everything_ which enables sparsemem?
> > 
> > Just to have the option of selecting either flatmem or sparsemem with
> > PBX (though I don't have a strong opinion about this). This can also be
> > done transparently via REALVIEW_HIGH_PHYS_OFFSET.
> 
> If you want to do this, put ARCH_FLATMEM_ENABLE into arch/arm/Kconfig,
> and arrange for the platform(s) where this is optional _and_ not the
> default to select this symbol, in precisely the same way that
> ARCH_SPARSEMEM_ENABLE is handled today.

I don't think it's worth the hassle anyway. If you have
REALVIEW_HIGH_PHYS_OFFSET disabled and FLATMEM, you end up with only
256MB of RAM available, I don't really see a point in this
configuration. With the new patch, if you don't like SPARSEMEM (maybe
for benchmarking reasons), just enable REALVIEW_HIGH_PHYS_OFFSET.

So, are you OK with the latest patch?

-- 
Catalin
