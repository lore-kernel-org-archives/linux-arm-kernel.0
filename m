From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Jun 2013 20:22:10 +0200
Subject: SCU registers mapping for CA9/CA5 cores
In-Reply-To: <20130624090640.GZ2718@n2100.arm.linux.org.uk>
References: <CADApbei3QOCQRmo_oYZ_XiUVupq+4uUs7WNe6f7k_OG0LHB3=w@mail.gmail.com>
 <201306211129.22625.arnd@arndb.de>
 <20130624090640.GZ2718@n2100.arm.linux.org.uk>
Message-ID: <201306262022.11103.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 June 2013, Russell King - ARM Linux wrote:
> On Fri, Jun 21, 2013 at 11:29:22AM +0200, Arnd Bergmann wrote:
> > I think we could actually move everything between VMALLOC_END and
> > ffff0000 into a larger fixmap. This would be a substantial change,
> > but it would give us more vmalloc space for most configurations
> > and more flexibility with what else we could put into fixmap.
> 
> ... at the expense of:
> (a) having to look up the PTE table pointer every time we want to add or
> remove a mapping,

Is that a frequent operation? I guess it's not important given the
argument below.

> (b) wasting the top 15 pages from being used.
> 
> Also, the placement of some of these pages matters especially for the
> VIPT aliasing caches, where cache colouring becomes important.  So an
> enum in fixmap isn't going to work for those.

x86 deals with alignment through some extra tricks, it's certainly doable
but I agree it's not improving readability if you do that.

> Really, the value to such a change is very low and is really just churn
> for churn's sake.  "Oh we can do something different!"  No.

Ok, fair enough.

I also saw the patch for early_ioremap, which would basically require
doing something like this. I'll comment on that email separately.

	Arnd
