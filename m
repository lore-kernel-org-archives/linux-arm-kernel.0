From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 11 Jun 2014 09:44:08 -0400
Subject: [PATCH] arm/ftrace: Fix function_return_addr() to
 function_return_address()
In-Reply-To: <CAMuHMdWm+hpumykRG2FudDPYSVODv1WoU6_tPv5D3HCPDQtDSw@mail.gmail.com>
References: <1394862048-28758-1-git-send-email-takahiro.akashi@linaro.org>
 <1398851676-16389-1-git-send-email-takahiro.akashi@linaro.org>
 <1398851676-16389-2-git-send-email-takahiro.akashi@linaro.org>
 <CAMuHMdWs9i4pBNbn-RTpv_-K5W7YGED=KtEtFSci=7YHdNKpfw@mail.gmail.com>
 <20140611092330.7930eff2@gandalf.local.home>
 <CAMuHMdWm+hpumykRG2FudDPYSVODv1WoU6_tPv5D3HCPDQtDSw@mail.gmail.com>
Message-ID: <20140611094408.0a6dedc3@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Jun 2014 15:38:49 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Steven,
> 
> On Wed, Jun 11, 2014 at 3:23 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > The clean up of CALLER_ADDR*() functions required the archs to either
> > use the default __builtin_return_address(X) (where X > 0) or override
> > it with something the arch can use. To override it, the arch would
> > define function_return_address(x).
> 
> ftrace_return_address(x)
> 
> > The arm architecture requires this to be redefined but instead of
> > defining function_return_address(x) it defined function_return_addr(x).
> 
> ftrace_return_address(x) ... ftrace_return_address(x)

As long as I got the patch part right ;-)

Will, please update the change log with the correct name. Including the
subject. Thanks!

-- Steve

> 
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Nevertheless, your patch kills the warnings. Thanks!
> 
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> > ----
> > diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
> > index eb577f4..39eb16b 100644
> > --- a/arch/arm/include/asm/ftrace.h
> > +++ b/arch/arm/include/asm/ftrace.h
> > @@ -52,7 +52,7 @@ extern inline void *return_address(unsigned int level)
> >
> >  #endif
> >
> > -#define ftrace_return_addr(n) return_address(n)
> > +#define ftrace_return_address(n) return_address(n)
> >
> >  #endif /* ifndef __ASSEMBLY__ */
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
