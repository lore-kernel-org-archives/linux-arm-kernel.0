From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 25 Jan 2010 21:48:29 +0000
Subject: Default machine include placements
In-Reply-To: <20100125145935.GB22481@n2100.arm.linux.org.uk>
References: <20100125100546.GA16340@n2100.arm.linux.org.uk>
	<20100125103216.GB5772@digital-scurf.org>
	<20100125104425.GO26562@trinity.fluff.org>
	<20100125104959.GC5772@digital-scurf.org>
	<20100125105503.GQ26562@trinity.fluff.org>
	<20100125111940.GC16340@n2100.arm.linux.org.uk>
	<20100125115344.GS26562@trinity.fluff.org>
	<20100125120454.GD16340@n2100.arm.linux.org.uk>
	<20100125135445.GU26562@trinity.fluff.org>
	<20100125145935.GB22481@n2100.arm.linux.org.uk>
Message-ID: <20100125214828.GX26562@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 02:59:35PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 25, 2010 at 01:54:45PM +0000, Ben Dooks wrote:
> > On Mon, Jan 25, 2010 at 12:04:54PM +0000, Russell King - ARM Linux wrote:
> > > Given the above, and the "mass population" hasn't happened, maybe part
> > > of the solution to the duplicated header file problem is to start
> > > combining some of these directories?
> > 
> > For plat-s3c64xx/mach-s3c6400/mach-s3c6410 how about moving the
> > plat-s3c64xx in with the machine definitions, as it is quite clear
> > now that it is unlikely to have any friends to join it (dev work is
> > on s5p and onwards).
> > 
> > Either arch/arm/mach-s3c64xx and have all s3c6400 and s3c6410 machines
> > in there, or keep the two mach- directories... I think i'd prefer to
> > see the two directories culled into one.
> 
> I'd prefer that too.

Ok, thanks.
 
> > For the s3c24xx case, it probably is the best case to merges s3c2440 and
> > s3c2442 into mach-s3c244x as they are pretty similar.
> > 
> > s3c2443 is on list of things to expand, it is a different beast to the
> > predecessors.
> 
> Sounds like a reason to keep it separate for the time being.
> 
> > I'll try making patches for this tomorrow and see what people think?
> 
> I'm not sure where mach-s3c24a0 fits in to this stuff - the only thing
> it seems to contain is a load of include files.
> 
> With these changes, it's going to take it from 10 mach-s[35]* directories
> down to 8.  Not sure if it makes much material difference to mach/*.h
> includes though.

Should be an improvement, we've already got V210 and C110 into the
same dir (really just packaging options) and I'll look at culling
the C100 and plat-c11x as this line looks like it ended with the
C100 and the newer devices are differrent beasts.
 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
