From: broonie@kernel.org (Mark Brown)
Date: Tue, 15 Dec 2015 17:17:13 +0000
Subject: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
In-Reply-To: <20151215153218.GA7228@leverpostej>
References: <20151210153004.GA26758@sirena.org.uk>
 <20151210175820.GE14571@e106622-lin>
 <20151211174940.GQ5727@sirena.org.uk>
 <20151214123616.GC3308@e106622-lin>
 <20151214165928.GV5727@sirena.org.uk>
 <20151215122238.GG16007@e106622-lin>
 <20151215133951.GY5727@sirena.org.uk>
 <20151215140135.GI31299@leverpostej>
 <20151215150813.GZ5727@sirena.org.uk>
 <20151215153218.GA7228@leverpostej>
Message-ID: <20151215171713.GA5727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 03:32:19PM +0000, Mark Rutland wrote:
> On Tue, Dec 15, 2015 at 03:08:13PM +0000, Mark Brown wrote:
> > On Tue, Dec 15, 2015 at 02:01:36PM +0000, Mark Rutland wrote:

> > > I really don't want to see a table of magic numbers in the kernel.

> > Right, there's pitfalls there too although not being part of an ABI
> > does make them more manageable.  

> I think that people are very likely to treat them exactly like an ABI,
> w.r.t. any regressions in performance that result from their addition,
> modification, or removal. That becomes really horrible when new CPUs
> appear.

Obviously people are going to get upset if we introduce performance
regressions - but that's true always, we can also introduce problems
with numbers people have put in DT.  It seems like it'd be harder to
manage regressions due to externally provided magic numbers since
there's inherently less information there.

> > One thing it's probably helpful to establish here is how much the
> > specific numbers are going to matter in the grand scheme of things.  If
> > the specific numbers *are* super important then nobody is going to want
> > to touch them as they'll be prone to getting tweaked.  If instead the
> > numbers just need to be ballpark accurate so the scheduler starts off in
> > roughly the right place and the specific numbers don't matter it's a lot
> > easier and having a table in the kernel until we think of something
> > better (if that ever happens) gets a lot easier.

> I agree that we first need to figure out the importance of these
> numbers. I disagree that our first step should be to add a table.

My point there is that if we're not that concerned about the specific
number something in kernel is safer.

> > My expectation is that we just need good enough, not perfect, and that
> > seems to match what Juri is saying about the expectation that most of
> > the fine tuning is done via other knobs.

> My expectation is that if a ballpark figure is good enough, it should be
> possible to implement something trivial like bogomips / loop_per_jiffy
> calculation.

That does have the issue that we need to scale with regard to the
frequency the benchmark gets run at.  That's not an insurmountable
obstacle but it's not completely trivial either.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151215/ffac8009/attachment-0001.sig>
