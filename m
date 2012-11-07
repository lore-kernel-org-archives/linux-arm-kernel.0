From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Nov 2012 13:29:26 +0000
Subject: Building for MMU-less vexpress targets
In-Reply-To: <alpine.LFD.2.02.1211061802240.21033@xanadu.home>
References: <20121105173640.GR3351@mudshark.cambridge.arm.com>
 <201211062114.49933.arnd@arndb.de>
 <alpine.LFD.2.02.1211061802240.21033@xanadu.home>
Message-ID: <201211071329.26995.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 November 2012, Nicolas Pitre wrote:
> On Tue, 6 Nov 2012, Arnd Bergmann wrote:
> 
> > On Tuesday 06 November 2012, Nicolas Pitre wrote:
> > > I really think that it makes no sense at all to support !MMU kernels in 
> > > a multi-platform kernel build, even if the set of included platforms 
> > > were all !MMU.  The kernel has to be linked for the physical address of 
> > > the target and not a common invariant virtual address.
> > 
> > There are two separate aspects here: One is to run a kernel on !MMU that is
> > built to support multiple platforms. I agree that this is rather pointless
> > and not interesting.
> > 
> > The other point is being able to build such a kernel, and this is what Will
> > seems to be interested in more.
> 
> What's the point of building a pointless and uninteresting kernel?

Built-time coverage is the only one I can think of, but I think it's a
good reason. Being able to build an "allyesconfig" with MMU disabled
sounds like a good sniff test to see if something broke and is much faster
than building all the defconfigs.

> > The two options are either to make
> > vexpress be single-platform when building for !MMU, or to allow multiplatform
> > kernels to be built without MMU support in principle. I think the second
> > option is more logical and avoids complex Kconfig constructs.
> 
> Well, I'd rather prefer to think that the first option is the most 
> logical between those 2 options, regardless of Kconfig complexity 
> issues.
> 
> I didn't look, but just making MULTIPLATFORM depend on !MMU, and 
> VEXPRESS depend on MULTIPLATFORM || MMU should be close to what is 
> needed, no?

Fine with me too. I suppose you just made the same logic error that
I had earlier in this thread and meant !MMU where you wrote MMU.

	Arnd
