From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 1 Oct 2015 12:19:31 +0100
Subject: [PATCH v5 00/23] ILP32 for ARM64
In-Reply-To: <20150930164103.GC15635@sirena.org.uk>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
 <20150930101918.GA9753@e104818-lin.cambridge.arm.com>
 <20150930164103.GC15635@sirena.org.uk>
Message-ID: <20151001111931.GD6963@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 05:41:03PM +0100, Mark Brown wrote:
> On Wed, Sep 30, 2015 at 11:19:19AM +0100, Catalin Marinas wrote:
> > On Wed, Sep 30, 2015 at 01:13:57AM +0300, Yury Norov wrote:
> 
> > >  - What for ILP32 on ARM64?
> > > 	See https://lkml.org/lkml/2015/4/13/814
> > > 	and http://permalink.gmane.org/gmane.comp.lib.uclibc.buildroot/121100
> > > 	Briefly,
> > > 	 - for compatibility;
> > > 	 - for performance;
> > > 	 - for memory saving.
> 
> > Does anyone actually need this ABI? And by "need" I don't mean a
> > tick-box on product fliers but actually someone going to use it on real
> > systems in the field. Because I'm not keen on maintaining an ABI in the
> > kernel just as a PR exercise. I have yet to see conclusive benchmarks
> > that ILP32 is a real win vs LP64 but happy to be proven wrong.
> 
> Indeed.  On that subject there was some discussion at Linaro Connect
> last week about work (being done outside Linaro, not sure how public it
> is at this point) to pull together the current state of the art into a
> Docker container image which people can use for benchmarking and as a
> reference for how to pull things together.  That should help with the
> analysis, it'll at least make it easier for other people to reproduce
> any benchmarking results.

That's fine and I would welcome it. However, I'm definitely against
using non-agreed ABI and further spreading such toolchains (or kernel
patches; Linaro's tracking kernel has kept these patches for a long
time, even though the ABI has been NAK'ed).

-- 
Catalin
