From: rabin@rab.in (Rabin Vincent)
Date: Tue, 23 Feb 2010 22:40:58 +0530
Subject: [PATCH 09/10] ARM: ftrace: add Thumb-2 support to dynamic ftrace
In-Reply-To: <1266932100.19540.12.camel@frodo>
References: <1266090518-31120-1-git-send-email-rabin@rab.in>
	<1266090518-31120-10-git-send-email-rabin@rab.in>
	<1266932100.19540.12.camel@frodo>
Message-ID: <20100223171058.GA5836@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2010 at 08:35:00AM -0500, Steven Rostedt wrote:
> On Sun, 2010-02-14 at 01:18 +0530, Rabin Vincent wrote:
> > --- a/arch/arm/include/asm/ftrace.h
> > +++ b/arch/arm/include/asm/ftrace.h
> > @@ -18,7 +18,11 @@ struct dyn_arch_ftrace {
> >  
> >  static inline unsigned long ftrace_call_adjust(unsigned long addr)
> >  {
> > +#ifdef CONFIG_THUMB2_KERNEL
> > +	return addr & ~1;
> 
> Would it be safe to do that for all arm archs? Instead of adding a
> config option around it. Or do some arm archs need the lsb set.
> 
> I'm just saying a comment here would look better than #ifdef #else.

You're right; I'll change this.  It's safe even when we build for the
ARM instruction set.

Rabin
