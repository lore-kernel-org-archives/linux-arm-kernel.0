From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 18 May 2012 15:18:32 -0400
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <alpine.LFD.2.02.1205161552490.1640@xanadu.home>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201205161528.27318.arnd@arndb.de>
 <alpine.LFD.2.02.1205161246080.1640@xanadu.home>
 <201205161946.34179.arnd@arndb.de>
 <alpine.LFD.2.02.1205161552490.1640@xanadu.home>
Message-ID: <20120518191832.GC24238@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 04:20:36PM -0400, Nicolas Pitre wrote:
> On Wed, 16 May 2012, Arnd Bergmann wrote:
> 
> > On Wednesday 16 May 2012, Nicolas Pitre wrote:
> > > > 
> > > > AFAICT, those are shared between most of those socs, and I would not want
> > > > to change the code in them to the new name.
> > > 
> > > Why not?  Module aliases can be used if that is a concern.
> > > 
> > > > If we change the directory
> > > > name to something completely different, it no longer matches the driver
> > > > names.
> > > 
> > > I wouldn't consider this as a major concern.  For example, the ethernet 
> > > driver that all those SOCs use is not called "orion".
> > 
> > It's not a big thing, I just feel that leaving the drivers alone makes
> > it a bit easier to port patches between kernel versions.
> 
> Sure.  My point is that we can rename the SOC directory and leave 
> drivers alone if we wish to minimize churn.  Drivers can be renamed at a 
> later time if that is seen as useful.
> 
> > Another argument
> > for orion is that it's nicer to read as a function name prefix than
> > mrvl_ebu_* as you suggested. The main counterargument to keeping orion_
> > as I understand it is that it's actually only the name for the oldest
> > members of this family, right? This is a good point, but we also have
> > a lot of other cases in the kernel where code is named after the first
> > thing that used it, e.g. arch/x86 was called arch/i386 for a long time
> > and we still have tons of references to that.
> 
> Indeed.  "sa1100" is another example of that and I didn't want to rename 
> it to sa11x0 at the time.
> 
> But in the sa1100 or i386 cases, the alternatives are close enough not 
> to cause too much confusion.
> 
> In this case, we have wildly different names referring to the same chip 
> family, and "orion" is far from hinting that it also constitute the 
> support for Kirkwood, Dove or (some not all) Armadas, unless you are 
> familiar with some legacy Marvell products.  This is why in this case I 
> think that a directory name change might be appropriate, _especially_ if 
> we're going to cause churn by moving things around already.
> 
> I agree that mrvl_ebu_* is not pretty.  This could be mv_ebu_* or 
> mvebu_*.  Unless someone has another logical identifier to suggest which 
> would capture all that family of SOCs that came out of EBU in Marvell of 
> course.

I prefer mvebu_* ...  nice and concise.

thx,

Jason.
