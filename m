From: abelvesa@gmail.com (Abel Vesa)
Date: Wed, 7 Dec 2016 16:11:17 +0000
Subject: [PATCH 6/7] arm: Add livepatch to build if CONFIG_LIVEPATCH
In-Reply-To: <20161207150525.GD13288@linux.suse>
References: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
 <1481043967-15602-7-git-send-email-abelvesa@linux.com>
 <20161207150525.GD13288@linux.suse>
Message-ID: <20161207161117.GA16293@gce>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2016 at 04:05:25PM +0100, Petr Mladek wrote:
> On Tue 2016-12-06 17:06:06, Abel Vesa wrote:
> > Necessary livepatch file added to makefile.
> > 
> > Signed-off-by: Abel Vesa <abelvesa@linux.com>
> > ---
> >  arch/arm/kernel/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> > index ad325a8..9e70220 100644
> > --- a/arch/arm/kernel/Makefile
> > +++ b/arch/arm/kernel/Makefile
> > @@ -48,6 +48,7 @@ obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
> >  obj-$(CONFIG_ARM_ARCH_TIMER)	+= arch_timer.o
> >  obj-$(CONFIG_FUNCTION_TRACER)	+= entry-ftrace.o
> >  obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o insn.o
> > +obj-$(CONFIG_LIVEPATCH)		+= livepatch.o
> 
> It is strange that you add a source file in one patch and make it
> build in a much later patch.
> 
> I suggest to restructure the entire patchset a bit. Please, first
> add support for FTRACE_WITH_REGS. It makes sense on its own.
> Then add the livepatch support on top of it.
> 
> Otherwise, it is not necessary to send v2 immediately for such
> non-trivial code. There might be more people that would want
> to look at it and it might take days until they find a time.
> It is always better to collect some feedback, think about it
> over night(s). Every question often opens many other questions
> and it usually takes some time until all settles down into
> a good picture again.
> 
> Best Regards,
> Petr
You're right, I should send this into two steps. One patchset that
adds FTRACE_WITH_REGS and then a second one that implements the
livepatch and is based on the first one.

Will do that.

Thanks.
