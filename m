From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Jul 2015 15:45:36 +0100
Subject: [PATCH v2 08/10] arm64/debug: Add missing #include
In-Reply-To: <20150713144433.GB10670@e103592.cambridge.arm.com>
References: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
 <1436793967-7138-9-git-send-email-Dave.Martin@arm.com>
 <20150713143436.GG19083@leverpostej>
 <20150713144433.GB10670@e103592.cambridge.arm.com>
Message-ID: <20150713144536.GI19083@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 03:44:34PM +0100, Dave P Martin wrote:
> On Mon, Jul 13, 2015 at 03:34:36PM +0100, Mark Rutland wrote:
> > On Mon, Jul 13, 2015 at 02:25:55PM +0100, Dave P Martin wrote:
> > > <asm/debug-monitors.h> relies on <asm/ptrace.h>, but doesn't
> > > declare this dependency.  This becomes a problem once
> > > debug-monitors.h starts getting included all over the place to get
> > > the BRK immedates.
> > 
> > I take it that's for struct pt_regs down in the ifndef __ASSEMBLY__
> > portion?
> 
> Yes ... I suppose I could move the #include in there, but it seems
> hermless.  I prefer to keep them together.

I was just checking that I hadn't missed something -- no need to move
it.

Mark.

> 
> > 
> > > 
> > > This patch adds the missing #include.
> > > 
> > > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > > ---
> > >  arch/arm64/include/asm/debug-monitors.h |    1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
> > > index 6a17fb8..b5715cb 100644
> > > --- a/arch/arm64/include/asm/debug-monitors.h
> > > +++ b/arch/arm64/include/asm/debug-monitors.h
> > > @@ -20,6 +20,7 @@
> > >  
> > >  #include <asm/esr.h>
> > >  #include <asm/insn.h>
> > > +#include <asm/ptrace.h>
> > 
> > We're also missing <linux/types.h> (for struct list_head, u8, and u32),
> > and <linux/errno.h> (for ENODEV in the reinstall_suspended_bps stub).
> > Would you be able to fold those in?
> 
> Sure, can do.
> 
> > With those:
> > 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Cheers
> ---Dave
> 
> > 
> > Mark.
> > 
> > >  
> > >  /* Low-level stepping controls. */
> > >  #define DBG_MDSCR_SS		(1 << 0)
> > > -- 
> > > 1.7.10.4
> > > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
