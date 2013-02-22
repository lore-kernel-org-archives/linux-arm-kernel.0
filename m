From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 22 Feb 2013 09:39:08 +0000
Subject: arm64: select ARCH_WANT_OPTIONAL_GPIOLIB
In-Reply-To: <20130221104644.GB11431@MacBook-Pro.local>
References: <20130218111410.GA10572@e106331-lin.cambridge.arm.com>
 <1634805.kh17mYrJe5@wuerfel>
 <CACxGe6tVk4na2yLi-6r1fTv5QqzgePbo6K+ZtEt-VOy25DQxVQ@mail.gmail.com>
 <1636745.vSza8MrtIn@wuerfel>
 <20130221104644.GB11431@MacBook-Pro.local>
Message-ID: <20130222093908.GA12175@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 21, 2013 at 10:46:44AM +0000, Catalin Marinas wrote:
> On Thu, Feb 21, 2013 at 10:42:57AM +0000, Arnd Bergmann wrote:
> > An architecture should not unconditionally enable 'GENERIC_GPIO'
> > without providing an implementation. In case of arm64, selecting
> > ARCH_WANT_OPTIONAL_GPIOLIB is the right solution, because it
> > lets us enable GPIOLIB when configuring the kernel, and that
> > implicitly turns on GENERIC_GPIO.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ----
> > On Thursday 21 February 2013 10:36:41 Grant Likely wrote:
> > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > index ab4aa54..3fab0db 100644
> > > > --- a/arch/arm64/Kconfig
> > > > +++ b/arch/arm64/Kconfig
> > > > @@ -3,6 +3,7 @@ config ARM64
> > > >         select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
> > > >         select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
> > > >         select ARCH_WANT_FRAME_POINTERS
> > > > +       select ARCH_WANT_OPTIONAL_GPIOLIB
> > > >         select ARM_AMBA
> > > >         select ARM_ARCH_TIMER
> > > >         select CLONE_BACKWARDS
> > > > @@ -92,9 +93,6 @@ config SWIOTLB
> > > >  config IOMMU_HELPER
> > > >         def_bool SWIOTLB
> > > >
> > > > -config GENERIC_GPIO
> > > > -       def_bool y
> > > > -
> > > >  source "init/Kconfig"
> > > >
> > > >  source "kernel/Kconfig.freezer"
> > > 
> > > I've not asked Linus to pull the GPIO tree yet because of this issue.
> > > Can someone please test this on aarch64 and send me a properly
> > > formatted patch?
> > 
> > It was wrong, the new version below is good though. Tested with defconfig
> > and allyesconfig on arm64. I found a few more trivial issues with arm64
> > allyesconfig that I fixed up as well. I'll send separate patches
> > for those.
> 
> That's what I just tried, it looks ok to me:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Maybe Mark can try it with -next (I only tested with 3.8).

I've just tried the updated patch on next-20130222; arm64 defconfig builds
successfully.

Thanks,
Mark.
