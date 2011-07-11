From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jul 2011 12:42:29 +0100
Subject: [PATCH 11/51] ARM: Kconfig: Allow kprobes on Thumb-2 kernels
In-Reply-To: <1310384021.2258.9.camel@computer2>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
	<1310209058-20980-12-git-send-email-tixy@yxit.co.uk>
	<4E1AD7F2.9020205@ru.mvista.com>
	<1310384021.2258.9.camel@computer2>
Message-ID: <20110711114229.GJ3239@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 12:33:41PM +0100, Tixy wrote:
> On Mon, 2011-07-11 at 15:01 +0400, Sergei Shtylyov wrote: 
> > Hello.
> > 
> > On 09-07-2011 14:56, Tixy wrote:
> > 
> > > From: Jon Medhurst<tixy@yxit.co.uk>
> > 
> > > Signed-off-by: Jon Medhurst<tixy@yxit.co.uk>
> > > ---
> > >   arch/arm/Kconfig |    2 +-
> > >   1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > index 9adc278..b4177c5 100644
> > > --- a/arch/arm/Kconfig
> > > +++ b/arch/arm/Kconfig
> > > @@ -10,7 +10,7 @@ config ARM
> > >   	select GENERIC_ATOMIC64 if (CPU_V6 || !CPU_32v6K || !AEABI)
> > >   	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
> > >   	select HAVE_ARCH_KGDB
> > > -	select HAVE_KPROBES if (!XIP_KERNEL&&  !THUMB2_KERNEL)
> > > +	select HAVE_KPROBES if (!XIP_KERNEL)
> > 
> >     Why not drop useless parens, while at it?
> 
> Every other 'if' clause in that file has these parenthesis so I thought
> I would kept it consistent.

There's plenty of examples where this isn't the case, eg:

        default y if PXA27x || PXA3xx || PXA95x || ARCH_MMP
...
        default 200 if ARCH_EBSA110 || ARCH_S3C2410 || ARCH_S5P64X0 || \
                ARCH_S5PV210 || ARCH_EXYNOS4
        default OMAP_32K_TIMER_HZ if ARCH_OMAP && OMAP_32K_TIMER
        default AT91_TIMER_HZ if ARCH_AT91
        default SHMOBILE_TIMER_HZ if ARCH_SHMOBILE
...
        depends on !ARCH_S5P64X0 && !ARCH_S5PC100
        depends on CPU_ARM920T || CPU_ARM926T || CPU_SA1100 || \
                CPU_V6 || CPU_V6K || CPU_V7 || CPU_XSC3 || CPU_XSCALE

We really need to stop useless additional parens for simple expressions.
