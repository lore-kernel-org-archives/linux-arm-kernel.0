From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 23 Jul 2014 18:00:11 -0400 (EDT)
Subject: [PATCH 4/4] (RFC) X86: add IPI tracepoints
In-Reply-To: <20140721185459.54c81bd5@gandalf.local.home>
References: <1405660735-13408-1-git-send-email-nicolas.pitre@linaro.org>
 <1405660735-13408-5-git-send-email-nicolas.pitre@linaro.org>
 <20140718162750.62cbf965@gandalf.local.home>
 <alpine.LFD.2.11.1407181656160.3647@knanqh.ubzr>
 <20140721185459.54c81bd5@gandalf.local.home>
Message-ID: <alpine.LFD.2.11.1407231751130.6061@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Jul 2014, Steven Rostedt wrote:

> On Fri, 18 Jul 2014 16:59:50 -0400 (EDT)
> Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> 
> > On Fri, 18 Jul 2014, Steven Rostedt wrote:
> > 
> > > On Fri, 18 Jul 2014 01:18:55 -0400
> > > Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > > 
> > >  
> > > > diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
> > > > index be8e1bde07..e154d176cf 100644
> > > > --- a/arch/x86/kernel/smp.c
> > > > +++ b/arch/x86/kernel/smp.c
> > > > @@ -31,6 +31,12 @@
> > > >  #include <asm/apic.h>
> > > >  #include <asm/nmi.h>
> > > >  #include <asm/trace/irq_vectors.h>
> > > > +
> > > > +#define CREATE_TRACE_POINTS
> > > > +#undef TRACE_INCLUDE_PATH
> > > > +#undef TRACE_INCLUDE_FILE
> > > 
> > > I'm curious to why you added the #undefs. I wouldn't think they were
> > > needed.
> > 
> > They are needed because asm/trace/irq_vectors.h included prior that 
> > point defines them for itself and that makes the inclusion of 
> > trace/events/ipi.h fail.
> > 
> 
> Bah, I tried to get rid of the need for those, but it seems that the
> macro magic is getting a bit out of hand. I need a new macro magic
> hat :-p
> 
> What you got here will have to do.

OK.

Now the real question: should I submit it for mainline?  I'm a little 
bothered by the fact that all exception vectors already have tracepoints 
of their own, albeit deeply tied to X86 nomenclature.  But nothing that 
relates to IPI sources.  This patch fixes that by adding some 
tracepoints alongside existing ones which may go a long way in making 
their instrumentation with generic (arch independent) tools.

What do people think?


Nicolas
