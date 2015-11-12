From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 12 Nov 2015 10:16:20 -0500
Subject: [PATCH] sched/rt: hide push_irq_work_func declaration
In-Reply-To: <20151112145331.GC17308@twins.programming.kicks-ass.net>
References: <3810009.VdDTV0h1Qp@wuerfel>
 <20151112145331.GC17308@twins.programming.kicks-ass.net>
Message-ID: <20151112101620.2dcd5dce@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Nov 2015 15:53:31 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Nov 12, 2015 at 03:22:22PM +0100, Arnd Bergmann wrote:
> > -#ifdef CONFIG_SMP
> > +#if IS_ENABLED(CONFIG_SMP) && defined(HAVE_RT_PUSH_IPI)
> >  static void push_irq_work_func(struct irq_work *work);
> >  #endif  
> 
> I think we can get tid of the whole HAVE_RT_PUSH_IPI thing after:
> 8053871d0f7f ("smp: Fix smp_call_function_single_async() locking")
> 
> That should allow us to use smp_calling_function_single_async() instead
> of irq_work_queue_on(), removing the dependency on irq_work.

Interesting. I'll have to take a look at that.

-- Steve
