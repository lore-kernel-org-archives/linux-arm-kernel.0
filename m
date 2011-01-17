From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 17 Jan 2011 12:31:24 +0100
Subject: [PATCH] sched: provide scheduler_ipi() callback in response to
	smp_send_reschedule()
In-Reply-To: <20110117112637.GA18599@n2100.arm.linux.org.uk>
References: <1295262433.30950.53.camel@laptop>
	<20110117112637.GA18599@n2100.arm.linux.org.uk>
Message-ID: <1295263884.30950.54.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-01-17 at 11:26 +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 17, 2011 at 12:07:13PM +0100, Peter Zijlstra wrote:
> > diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
> > index 42aa078..c4a570b 100644
> > --- a/arch/alpha/kernel/smp.c
> > +++ b/arch/alpha/kernel/smp.c
> > @@ -587,6 +587,7 @@ handle_ipi(struct pt_regs *regs)
> >  		case IPI_RESCHEDULE:
> >  			/* Reschedule callback.  Everything to be done
> >  			   is done by the interrupt return path.  */
> > +			scheduler_ipi();
> >  			break;
> >  
> >  		case IPI_CALL_FUNC:
> > diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> > index 9066473..ffde790 100644
> > --- a/arch/arm/kernel/smp.c
> > +++ b/arch/arm/kernel/smp.c
> > @@ -579,6 +579,7 @@ asmlinkage void __exception do_IPI(struct pt_regs *regs)
> >  				 * nothing more to do - eveything is
> >  				 * done on the interrupt return path
> >  				 */
> > +				scheduler_ipi();
> 
> Maybe remove the comment "everything is done on the interrupt return path"
> as with this function call, that is no longer the case.
> 
> Looks like the same is true for Alpha as well?

Right, will do, thanks! It looks like I've somewhat inconsistent with
that.
