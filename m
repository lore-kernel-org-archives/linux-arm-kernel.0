From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 25 Jan 2010 11:53:44 +0000
Subject: Default machine include placements
In-Reply-To: <20100125111940.GC16340@n2100.arm.linux.org.uk>
References: <20100125040255.GN26562@trinity.fluff.org>
	<20100125100546.GA16340@n2100.arm.linux.org.uk>
	<20100125103216.GB5772@digital-scurf.org>
	<20100125104425.GO26562@trinity.fluff.org>
	<20100125104959.GC5772@digital-scurf.org>
	<20100125105503.GQ26562@trinity.fluff.org>
	<20100125111940.GC16340@n2100.arm.linux.org.uk>
Message-ID: <20100125115344.GS26562@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 11:19:40AM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 25, 2010 at 10:55:03AM +0000, Ben Dooks wrote:
> > On Mon, Jan 25, 2010 at 10:49:59AM +0000, Daniel Silverstone wrote:
> > > On Mon, Jan 25, 2010 at 10:44:25AM +0000, Ben Dooks wrote:
> > > > We do a bit of #include <plat/xxx-base.h> already for some things.
> > > > The 'empty' headers always seme to end up catching more copyright
> > > > statement than the space they end up saving.
> > > 
> > > I guess it depends if you're aiming for space savings or "only one place to fix
> > > a bug" in that case.
> > 
> > The big one is bug repetition, which happened with the s3c64xx clksrc
> > code. The internal Samsung trees ended up with 4 similar copies of this
> > code, each with its own unique problems. Whilst this problem is quite
> > easy to fix (and it is now fixed in the current kernel) the other problem
> > is the size of submission for each new CPU support.
> 
> You're talking about .c files here, not header files.

Sorry, I'm trying to apply the same principles to all files being
created during the development process.

> > One solution is just to make mach-s5p and stick all s5p implementations
> > in there, but this could end up with one quite big directory or a large
> > number of sub directiories springing up for CPU specific support.
> 
> CPU or SoC?  Please don't confuse the two terms - they're entirely
> different things.  There's no need what so ever to separate out CPU
> specific support because the kernel already does that for you.

Sorry, it has been the end of a long day for me. SoCs are the problem
here and it is unfortuante whilst the core of the Samsung support is
pretty similar, each SoC or couple of SoCs is not the same as their
neigbours.
 
> SoC specific is what I think you mean.
> 
> I personally think that the proliferation of mach-s* directories for
> Samsung is becoming a problem in itself - some of these directories
> contain next to nothing, and others are duplications with minimal
> changes.
> 
> For example, the differences between s3c6400 and s3c6410 are minimal,
> yet they have most of the contained non-board code duplicated.

I would disagree on that, most of the common s3c6400 and s3c6410 is
contained in plat-s3c64xx with the machine directories containing the
cpu sepcific initialisation bits, such as the changes in the ARM CLKDIV
the VIC popuilation and the extra devices that the s3c6410 have.

It does however mean that mach-s3c6400 and mach-s3c6410 are not heavily
populated with machines, especially as the intended new Openmoko device
never appeared.

>  Also,
> the mach-s3c2442 directory seems to only support one board - GTA02,
> and mach-s3c2443 seems to be a similar story.

Unfortunately there seems to be very few people interested in actually
submitting s3c2443 machines. The s3c2442 ended up in a pile of iPAQs
but again there doesn't seem to be a lot of interest in getting anything
submitted (I don't belive that S3C2442 actually made it into anything
other than the large OEM chanell and thus hasn't been seen in anything
other than iPAQ type devices - although I could be wrong)
 
> You're worried about a mach-*/ directory becoming too big, but you
> don't seem to have noticed that the arch/arm directory has 15 (!)
> Samsung directories.

If someone would like to suggest alternate layouts, then please let
me know what people think. It was hoped that there would be many
people that would be submitting machines for these SoCs and that
each directory would overflow with support. This is unfrortunately
not the case. 

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
