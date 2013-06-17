From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 17 Jun 2013 15:02:04 +0100
Subject: [PATCH 1/2] arm: vexpress: select HAVE_ARM_ARCH_TIMER
In-Reply-To: <1371476885.3483.36.camel@hornet>
References: <1371462316-9201-1-git-send-email-mark.rutland@arm.com>
 <1371462316-9201-2-git-send-email-mark.rutland@arm.com>
 <1371476885.3483.36.camel@hornet>
Message-ID: <20130617140204.GF6809@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 02:48:05PM +0100, Pawel Moll wrote:
> On Mon, 2013-06-17 at 10:45 +0100, Mark Rutland wrote:
> > When building a ARCH_MULTI_V7 kernel, support for the architected timers
> > won't be enabled out-of-the-box even when ARCH_VEXPRESS is selected,
> > which is unexpected and disappointing when using a coretile with
> > architected timers.
> > 
> > Fix this up by having ARCH_VEXPRESS select HAVE_ARM_ARCH_TIMER.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Pawel Moll <pawel.moll@arm.com>
> > ---
> >  arch/arm/mach-vexpress/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> > index 5907e10..e0f4974 100644
> > --- a/arch/arm/mach-vexpress/Kconfig
> > +++ b/arch/arm/mach-vexpress/Kconfig
> > @@ -9,6 +9,7 @@ config ARCH_VEXPRESS
> >  	select COMMON_CLK_VERSATILE
> >  	select CPU_V7
> >  	select GENERIC_CLOCKEVENTS
> > +	select HAVE_ARM_ARCH_TIMER
> >  	select HAVE_ARM_SCU if SMP
> >  	select HAVE_ARM_TWD if LOCAL_TIMERS
> >  	select HAVE_CLK
> 
> Acked-by: Pawel Moll <pawel.moll@arm.com>
> 
> Do you want me to queue it for 3.12?

That would be great, yes please :)

Thanks,
Mark.
