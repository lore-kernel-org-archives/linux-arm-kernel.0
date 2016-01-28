From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Jan 2016 16:00:22 +0000
Subject: [PATCH] arm64: Add support for Half precision floating point
In-Reply-To: <20160126161151.GE14823@e104818-lin.cambridge.arm.com>
References: <1453823566-26742-1-git-send-email-suzuki.poulose@arm.com>
 <20160126160257.GB28238@arm.com>
 <20160126161151.GE14823@e104818-lin.cambridge.arm.com>
Message-ID: <20160128160022.GM775@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 04:11:51PM +0000, Catalin Marinas wrote:
> On Tue, Jan 26, 2016 at 04:02:58PM +0000, Will Deacon wrote:
> > On Tue, Jan 26, 2016 at 03:52:46PM +0000, Suzuki K Poulose wrote:
> > > ARMv8.2 extensions [1] include an optional feature, which supports
> > > half precision(16bit) floating point/asimd data processing
> > > instructions. This patch adds support for detecting and exposing
> > > the same to the userspace via HWCAPs
> > > 
> > > [1] https://community.arm.com/groups/processors/blog/2016/01/05/armv8-a-architecture-evolution
> > > 
> > > Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> > > ---
> > >  arch/arm64/include/uapi/asm/hwcap.h |    2 ++
> > >  arch/arm64/kernel/cpufeature.c      |    2 ++
> > >  arch/arm64/kernel/cpuinfo.c         |    2 ++
> > >  3 files changed, 6 insertions(+)
> > > 
> > > diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
> > > index 361c8a8..a739287 100644
> > > --- a/arch/arm64/include/uapi/asm/hwcap.h
> > > +++ b/arch/arm64/include/uapi/asm/hwcap.h
> > > @@ -28,5 +28,7 @@
> > >  #define HWCAP_SHA2		(1 << 6)
> > >  #define HWCAP_CRC32		(1 << 7)
> > >  #define HWCAP_ATOMICS		(1 << 8)
> > > +#define HWCAP_FPHP		(1 << 9)
> > > +#define HWCAP_ASIMDHP		(1 << 10)
> > 
> > Where did we get to with the mrs trapping you proposed here?
> > 
> >   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/374609.html
> > 
> > At some point, we need to consider whether or not we want to continue
> > adding new HWCAPs or whether your suggestion above is actually useful
> > to userspace.
> 
> IMO, even if we merge the MRS emulation, I would still like to see
> HWCAPs exported. We are not short on bits yet (53 to go ;)).

I'm less keen. HWCAPs don't align well with the way that the ARM
architecture versions features and we should be encouraging people to
use the MRS emulation if it exists.

> > Did the libc guys get anywhere with a prototype? What do we need to do
> > to make progress with it?
> 
> This investigation should indeed continue but I think it is orthogonal.

Not if its intended to replace HWCAPs in the longterm.

Will
