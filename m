From: ben-linux@fluff.org (Ben Dooks)
Date: Sun, 13 Jun 2010 06:16:26 +0100
Subject: [PATCH] ARM: Add ARCH_HAS_L2X0 and make CACHE_L2X0 config
	depend on that
In-Reply-To: <1276279087.31800.6.camel@c-dwalke-linux.qualcomm.com>
References: <1276272211-13065-1-git-send-email-olof@lixom.net>
	<1276279087.31800.6.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100613051625.GA7248@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 11, 2010 at 10:58:07AM -0700, Daniel Walker wrote:
> On Fri, 2010-06-11 at 11:03 -0500, Olof Johansson wrote:
> 
> > diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> > index 346ae14..419b957 100644
> > --- a/arch/arm/mm/Kconfig
> > +++ b/arch/arm/mm/Kconfig
> > @@ -759,11 +759,13 @@ config CACHE_FEROCEON_L2_WRITETHROUGH
> >  	  Say Y here to use the Feroceon L2 cache in writethrough mode.
> >  	  Unless you specifically require this, say N for writeback mode.
> >  
> > +config ARCH_HAS_L2X0
> > +	bool
> > +	default n
> > +
> 
> I made a similar change not too long ago, but Russell wanted the define
> to be HAVE_CACHE_L2X0 ..

possibly, I was thinking ARM_L2X0 would also be an option, since if I
remeber correctly it is selecting the driver not the availability of
it.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
