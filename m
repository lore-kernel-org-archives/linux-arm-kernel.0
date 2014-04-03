From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Apr 2014 20:03:33 +0100
Subject: [PATCH 06/75] ARM: outer cache: add documentation of outer
 cache functions
In-Reply-To: <533BD8A2.5070808@monstr.eu>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYUc-0004WH-16@rmk-PC.arm.linux.org.uk> <533BD8A2.5070808@monstr.eu>
Message-ID: <20140403190333.GU7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 02, 2014 at 11:30:10AM +0200, Michal Simek wrote:
> On 03/28/2014 04:14 PM, Russell King wrote:
> > Add some documentation to cover the outer cache functions so that their
> > requirements can be better understood.  Of particular note are the
> > flush_all() and disable() methods which must not be called except in
> > very specific circumstances.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  arch/arm/include/asm/outercache.h | 48 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 47 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
> > index 0e4420858990..bd80540fe8b9 100644
> > --- a/arch/arm/include/asm/outercache.h
> > +++ b/arch/arm/include/asm/outercache.h
> > @@ -39,35 +39,75 @@ struct outer_cache_fns {
> >  extern struct outer_cache_fns outer_cache;
> >  
> >  #ifdef CONFIG_OUTER_CACHE
> > -
> > +/**
> > + * outer_inv_range: invalidate range of outer cache lines
> 
> This is not proper kernel-doc format.

Fixed, thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
