From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Jan 2010 11:19:40 +0000
Subject: Default machine include placements
In-Reply-To: <20100125105503.GQ26562@trinity.fluff.org>
References: <20100125040255.GN26562@trinity.fluff.org>
	<20100125100546.GA16340@n2100.arm.linux.org.uk>
	<20100125103216.GB5772@digital-scurf.org>
	<20100125104425.GO26562@trinity.fluff.org>
	<20100125104959.GC5772@digital-scurf.org>
	<20100125105503.GQ26562@trinity.fluff.org>
Message-ID: <20100125111940.GC16340@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 10:55:03AM +0000, Ben Dooks wrote:
> On Mon, Jan 25, 2010 at 10:49:59AM +0000, Daniel Silverstone wrote:
> > On Mon, Jan 25, 2010 at 10:44:25AM +0000, Ben Dooks wrote:
> > > We do a bit of #include <plat/xxx-base.h> already for some things.
> > > The 'empty' headers always seme to end up catching more copyright
> > > statement than the space they end up saving.
> > 
> > I guess it depends if you're aiming for space savings or "only one place to fix
> > a bug" in that case.
> 
> The big one is bug repetition, which happened with the s3c64xx clksrc
> code. The internal Samsung trees ended up with 4 similar copies of this
> code, each with its own unique problems. Whilst this problem is quite
> easy to fix (and it is now fixed in the current kernel) the other problem
> is the size of submission for each new CPU support.

You're talking about .c files here, not header files.

> One solution is just to make mach-s5p and stick all s5p implementations
> in there, but this could end up with one quite big directory or a large
> number of sub directiories springing up for CPU specific support.

CPU or SoC?  Please don't confuse the two terms - they're entirely
different things.  There's no need what so ever to separate out CPU
specific support because the kernel already does that for you.

SoC specific is what I think you mean.

I personally think that the proliferation of mach-s* directories for
Samsung is becoming a problem in itself - some of these directories
contain next to nothing, and others are duplications with minimal
changes.

For example, the differences between s3c6400 and s3c6410 are minimal,
yet they have most of the contained non-board code duplicated.  Also,
the mach-s3c2442 directory seems to only support one board - GTA02,
and mach-s3c2443 seems to be a similar story.

You're worried about a mach-*/ directory becoming too big, but you
don't seem to have noticed that the arch/arm directory has 15 (!)
Samsung directories.
