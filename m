From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Sep 2009 16:38:18 +0100
Subject: [PATCH 1/2] ARM: Pass IFSR register to do_PrefetchAbort()
In-Reply-To: <cc557aab0909180808p675c182eke41b23019a609b9a@mail.gmail.com>
References: <f00f1348d91d2403ea0f1c5f05b3ac713664fe7b.1253281256.git.kirill@shutemov.name>
	<alpine.DEB.1.00.0909181422370.11448@ak-desktop>
	<cc557aab0909180445o33b6792ewf62a4f5e7589547@mail.gmail.com>
	<4AB39EC3.4050202@nokia.com>
	<cc557aab0909180808p675c182eke41b23019a609b9a@mail.gmail.com>
Message-ID: <1253288298.9567.45.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-09-18 at 18:08 +0300, Kirill A. Shutemov wrote:
> On Fri, Sep 18, 2009 at 5:52 PM, Aaro Koskinen <aaro.koskinen@nokia.com> wrote:
> > Hello,
> >
> > Kirill A. Shutemov wrote:
> >>>
> >>>  #ifdef CONFIG_CPU_PABRT_NOIFAR
> >>> -# ifdef CPU_PABORT_HANDLER
> >>> +# ifdef CPU_PABORT_HANDLER_IFAR
> >>>  #  define MULTI_PABORT 1
> >>>  # else
> >>> -#  define CPU_PABORT_HANDLER(reg, insn)        mov reg, insn
> >>> +#  define CPU_PABORT_HANDLER_IFAR(reg, insn)   mov reg, insn
> >>> +#  define CPU_PABORT_HANDLER_IFSR(reg)         mrc p15, 0, reg, cr5,
> >>> cr0, 1
> >>
> >> It's incorrect. We have IFSR only on ARMv7.
> >
> > It seems my assumption on the availability of that register was wrong, but I
> > think it's available at least on ARMv6, and also that IFAR can be
> > optional...
> 
> I can't find anything in ARMv6-M Architecture Reference Manual by
> keywords "ifar" or "ifsr".

ARMv6-M is for the M-profile CPUs (Thumb or Thumb-2 only ISA, no MMU ,
it doesn't even have CP15).

You would need to check the A profile. Try the ARMv7-AR reference manual
(now freely available, though it needs a click-through) which has a
section on differences with the ARMv6 as well.

-- 
Catalin
