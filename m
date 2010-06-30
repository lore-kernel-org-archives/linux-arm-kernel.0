From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 30 Jun 2010 12:17:23 +0530
Subject: [PATCH 6/6] omap2/3/4: Add Kconfig option to compile in typical
	omap	features
In-Reply-To: <20100630061726.GQ2822@atomide.com>
References: <20100629113229.16008.2931.stgit@baageli.muru.com>
	<20100629114738.16008.62006.stgit@baageli.muru.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5DB6FC3@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5DB7026@dbde02.ent.ti.com>
	<20100630061726.GQ2822@atomide.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5E4124A@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com]
> Sent: Wednesday, June 30, 2010 11:47 AM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org
> Subject: Re: [PATCH 6/6] omap2/3/4: Add Kconfig option to compile in
> typical omap features
> 
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100629 17:40]:
> > > >
> > > With your series OMAP4 build breaks because of PM and SMP
> dependencies.
> > > To ensure that build doesn't break on OMAP4, I needed below change.
> With
> > > This change I tried your series and it boots OK on OMAP4430 SDP
> 
> Hmm the build does not break for me?
>
Looks like I am missing something here. How do you build OMAP4 alone with
these new changes ??
 
> > Also tested the multi-omap build on OMAP3430 SDP and OMAP4430 SDP. Both
> boots OK.
> >
> > > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > > index 84fecd0..f48f275 100644
> > > --- a/arch/arm/mach-omap2/Kconfig
> > > +++ b/arch/arm/mach-omap2/Kconfig
> > > @@ -7,8 +7,8 @@ config ARCH_OMAP2PLUS_TYPICAL
> > >         default y
> > >         select AEABI
> > >         select REGULATOR
> > > -       select PM
> > > -       select PM_RUNTIME
> > > +       select PM if !ARCH_OMAP4
> > > +       select PM_RUNTIME if !ARCH_OMAP4
> > >         select VFP
> > >         select NEON if ARCH_OMAP3 || ARCH_OMAP4
> > >         select SERIAL_8250
> 
> Let's rather fix whatever the issue is for booting (or building?)
> omap4 with CONFIG_PM and CONFIG_PM_RUNTIME. If we can't implement
> PM yet for omap4, we can just return early if cpu_is_omap44xx.
> 
> CONFIG_SMP we can't enable as that requires various ARM changes
> to work on unicore systems. But hopefully we can enable that too
> at some point with select SMP if ARCH_OMAP4.
> 
