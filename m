From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 06 Nov 2012 18:14:06 -0500 (EST)
Subject: Building for MMU-less vexpress targets
In-Reply-To: <201211062114.49933.arnd@arndb.de>
References: <20121105173640.GR3351@mudshark.cambridge.arm.com>
 <201211061733.44781.arnd@arndb.de>
 <alpine.LFD.2.02.1211061533490.21033@xanadu.home>
 <201211062114.49933.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1211061802240.21033@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Nov 2012, Arnd Bergmann wrote:

> On Tuesday 06 November 2012, Nicolas Pitre wrote:
> > I really think that it makes no sense at all to support !MMU kernels in 
> > a multi-platform kernel build, even if the set of included platforms 
> > were all !MMU.  The kernel has to be linked for the physical address of 
> > the target and not a common invariant virtual address.
> 
> There are two separate aspects here: One is to run a kernel on !MMU that is
> built to support multiple platforms. I agree that this is rather pointless
> and not interesting.
> 
> The other point is being able to build such a kernel, and this is what Will
> seems to be interested in more.

What's the point of building a pointless and uninteresting kernel?

Sure, wide build coverage is good.  But pointless builds are not.  
Comes a point where Kconfig should serve its purpose i.e. help the user 
make a valid kernel configuration for himself.  And I really think that 
multi-platform and !MMU together don't make for a valid configuration 
anymore.

> We have made VEXPRESS depend on MULTIPLATFORM, which broke support for 
> building a non-MMU vexpress kernel, and I think we should fix that.

No argument there.

> The two options are either to make
> vexpress be single-platform when building for !MMU, or to allow multiplatform
> kernels to be built without MMU support in principle. I think the second
> option is more logical and avoids complex Kconfig constructs.

Well, I'd rather prefer to think that the first option is the most 
logical between those 2 options, regardless of Kconfig complexity 
issues.

I didn't look, but just making MULTIPLATFORM depend on !MMU, and 
VEXPRESS depend on MULTIPLATFORM || MMU should be close to what is 
needed, no?


Nicolas
