From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 18 Jul 2014 16:59:50 -0400 (EDT)
Subject: [PATCH 4/4] (RFC) X86: add IPI tracepoints
In-Reply-To: <20140718162750.62cbf965@gandalf.local.home>
References: <1405660735-13408-1-git-send-email-nicolas.pitre@linaro.org>
 <1405660735-13408-5-git-send-email-nicolas.pitre@linaro.org>
 <20140718162750.62cbf965@gandalf.local.home>
Message-ID: <alpine.LFD.2.11.1407181656160.3647@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Jul 2014, Steven Rostedt wrote:

> On Fri, 18 Jul 2014 01:18:55 -0400
> Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> 
>  
> > diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
> > index be8e1bde07..e154d176cf 100644
> > --- a/arch/x86/kernel/smp.c
> > +++ b/arch/x86/kernel/smp.c
> > @@ -31,6 +31,12 @@
> >  #include <asm/apic.h>
> >  #include <asm/nmi.h>
> >  #include <asm/trace/irq_vectors.h>
> > +
> > +#define CREATE_TRACE_POINTS
> > +#undef TRACE_INCLUDE_PATH
> > +#undef TRACE_INCLUDE_FILE
> 
> I'm curious to why you added the #undefs. I wouldn't think they were
> needed.

They are needed because asm/trace/irq_vectors.h included prior that 
point defines them for itself and that makes the inclusion of 
trace/events/ipi.h fail.

> -- Steve
> 
> > +#include <trace/events/ipi.h>
> > +
> >  /*
> >   *	Some notes on x86 processor bugs affecting SMP operation:
> >   *
> 
> 
