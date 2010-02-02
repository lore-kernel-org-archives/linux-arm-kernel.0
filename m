From: jamie.iles@picochip.com (Jamie Iles)
Date: Tue, 2 Feb 2010 18:48:31 +0000
Subject: [PATCH 4/5] arm: enable support for software perf events
In-Reply-To: <20100202174000.GB29701@n2100.arm.linux.org.uk>
References: <1263471256-3739-1-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-2-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-3-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-4-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-5-git-send-email-jamie.iles@picochip.com>
	<20100202174000.GB29701@n2100.arm.linux.org.uk>
Message-ID: <20100202184831.GH4305@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2010 at 05:40:00PM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 14, 2010 at 12:14:15PM +0000, Jamie Iles wrote:
> > The perf events subsystem allows counting of both hardware and
> > software events. This patch implements the bare minimum for software
> > performance events.
> > 
> > Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@elte.hu>
> > ---
> >  arch/arm/Kconfig                  |    2 ++
> >  arch/arm/include/asm/perf_event.h |   31 +++++++++++++++++++++++++++++++
> >  arch/arm/mm/fault.c               |    7 +++++++
> >  3 files changed, 40 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/include/asm/perf_event.h
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 293a879..72646b2 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -21,6 +21,8 @@ config ARM
> >  	select HAVE_KERNEL_GZIP
> >  	select HAVE_KERNEL_LZO
> >  	select GENERIC_ATOMIC64
> 
> This conflicts - this select is only if !CPU_32v6K in my kernel.
> 
> What's the implication?  Does this perf stuff require these atomic64
> stuff (in which case, those symbols should only be selected if
> GENERIC_ATOMIC64 is also selected.)
> 
> Please sort this out.
As Will mentioned, the correct case should be 'GENERIC_ATOMIC64 if
(!CPU_32v6K)' due to my patches being off a tree without the native
atomic64's. I can rebase onto next if that's easier.

Jamie
