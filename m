From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Nov 2012 10:21:48 +0000
Subject: Building for MMU-less vexpress targets
In-Reply-To: <alpine.LFD.2.02.1211061802240.21033@xanadu.home>
References: <20121105173640.GR3351@mudshark.cambridge.arm.com>
 <201211061733.44781.arnd@arndb.de>
 <alpine.LFD.2.02.1211061533490.21033@xanadu.home>
 <201211062114.49933.arnd@arndb.de>
 <alpine.LFD.2.02.1211061802240.21033@xanadu.home>
Message-ID: <20121107102147.GC23305@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 11:14:06PM +0000, Nicolas Pitre wrote:
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
> 
> Sure, wide build coverage is good.  But pointless builds are not.  
> Comes a point where Kconfig should serve its purpose i.e. help the user 
> make a valid kernel configuration for himself.  And I really think that 
> multi-platform and !MMU together don't make for a valid configuration 
> anymore.

If it's just the physical memory map that gets in the way for multiplatform
!MMU, it's probably worth me pointing out that for PMSAv7 (i.e. R-class
cores) there is a mandated default memory map, which does make this problem
largely disappear.

All said and done, I don't see anybody ever using the option though --
distributions will likely never ship nommu kernels and they typically get
deployed in one place only with an emphasis on keeping the thing small.

Will
