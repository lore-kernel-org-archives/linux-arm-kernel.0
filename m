From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 06 Sep 2010 11:39:42 +0100
Subject: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
In-Reply-To: <20100906100632.GC20903@n2100.arm.linux.org.uk>
References: <4C6CFBAF.6020407@canonical.com>
	<20100819095705.GU12184@atomide.com>
	<20100819102025.GA32151@n2100.arm.linux.org.uk>
	<20100820120622.GL25742@atomide.com>
	<20100830225527.GC11597@atomide.com>
	<20100902133637.GJ26319@n2100.arm.linux.org.uk>
	<20100902161659.GJ11597@atomide.com>
	<1283765333.1926.2.camel@e102109-lin.cambridge.arm.com>
	<20100906093424.GB20903@n2100.arm.linux.org.uk>
	<1283765910.1926.4.camel@e102109-lin.cambridge.arm.com>
	<20100906100632.GC20903@n2100.arm.linux.org.uk>
Message-ID: <1283769582.1926.11.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-09-06 at 11:06 +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 06, 2010 at 10:38:30AM +0100, Catalin Marinas wrote:
> > On Mon, 2010-09-06 at 10:34 +0100, Russell King - ARM Linux wrote:
> > > On Mon, Sep 06, 2010 at 10:28:53AM +0100, Catalin Marinas wrote:
> > > > I haven't followed your patches closely but can we restrict the ARMv6
> > > > SMP/UP support to only those cores that have TEX remapping (most of them
> > > > probably)?
> > >
> > > We don't support TEX remapping on ARMv6.
> >
> > I know but it's easy to enable if useful for the SMP/UP v6/v7
> > combination (with some restrictions).
> 
> It'll make proc-v6.S much more complicated than it already is, requiring
> it to carry both the non-remap and remapping code selected via an ifdef.
> 
> Is it worth it?  For the sake of one conditional in mmu.c, I don't think
> so - and the view is that using TEX remapping to get rid of the shared
> bit is a horrible hack anyway.
> 
> In any case, it's unnecessary.  We can use my word-replacement to modify
> a variable to indicate whether we're running on SMP or not, and so have
> the test for SMP-on-UP in just one place.  Like this:

It looks fine to me. Thanks.

-- 
Catalin
