From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Mar 2010 16:16:49 +0000
Subject: [PATCH 04/10] ARM: ftrace: allow building without frame pointers
In-Reply-To: <1268585766.13400.4.camel@localhost>
References: <1268462987-8271-1-git-send-email-rabin@rab.in>
	<1268462987-8271-5-git-send-email-rabin@rab.in>
	<1268585766.13400.4.camel@localhost>
Message-ID: <1268842609.15804.7.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2010-03-14 at 16:56 +0000, Steven Rostedt wrote:
> On Sat, 2010-03-13 at 12:19 +0530, Rabin Vincent wrote:
> > With a new enough GCC, ARM function tracing can be supported without the
> > need for frame pointers.  This is essential for Thumb-2 support, since
> > frame pointers aren't available then.
> >
> > Signed-off-by: Rabin Vincent <rabin@rab.in>
> 
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index 13e13d4..e10519f 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -124,7 +124,7 @@ if FTRACE
> >  config FUNCTION_TRACER
> >       bool "Kernel Function Tracer"
> >       depends on HAVE_FUNCTION_TRACER
> > -     select FRAME_POINTER
> > +     select FRAME_POINTER if (!ARM_UNWIND)
> 
> I'm fine with this if the ARM maintainers are.
> 
> Acked-by: Steven Rostedt <rostedt@goodmis.org>

I think we did this already in other places, so:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
