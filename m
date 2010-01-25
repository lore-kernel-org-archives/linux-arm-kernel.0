From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 25 Jan 2010 14:03:47 +0000
Subject: Default machine include placements
In-Reply-To: <20100125120454.GD16340@n2100.arm.linux.org.uk>
References: <20100125040255.GN26562@trinity.fluff.org>
	<20100125100546.GA16340@n2100.arm.linux.org.uk>
	<20100125103216.GB5772@digital-scurf.org>
	<20100125104425.GO26562@trinity.fluff.org>
	<20100125104959.GC5772@digital-scurf.org>
	<20100125105503.GQ26562@trinity.fluff.org>
	<20100125111940.GC16340@n2100.arm.linux.org.uk>
	<20100125115344.GS26562@trinity.fluff.org>
	<20100125120454.GD16340@n2100.arm.linux.org.uk>
Message-ID: <20100125140347.GV26562@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 12:04:54PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 25, 2010 at 11:53:44AM +0000, Ben Dooks wrote:
> > > I personally think that the proliferation of mach-s* directories for
> > > Samsung is becoming a problem in itself - some of these directories
> > > contain next to nothing, and others are duplications with minimal
> > > changes.
> > > 
> > > For example, the differences between s3c6400 and s3c6410 are minimal,
> > > yet they have most of the contained non-board code duplicated.
> > 
> > I would disagree on that, most of the common s3c6400 and s3c6410 is
> > contained in plat-s3c64xx with the machine directories containing the
> > cpu sepcific initialisation bits, such as the changes in the ARM CLKDIV
> > the VIC popuilation and the extra devices that the s3c6410 have.
> 
> You may disagree, but my comment was based upon diffing the two
> directories, and comparing mach-s3c6400/s3c6400.c with mach-s3c6410/cpu.c:

Sorry, I did think that I had tried hard to eliminate the common code
from the two SoCs... looking at it after the event it seems that there
is still a bit of work to do.
 
This unfrotunately doesn't really solve the solution fully for the
plat-s5p case just yet, as these SoCs may be similar but have a few
problems with respect to the peripheral placement and some of the
more interestesting configurations.

It may be we just accept the compromise of repeated header files and
deal with this once we've sorted out exactly what we want to do.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
