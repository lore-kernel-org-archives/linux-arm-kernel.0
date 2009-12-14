From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 14 Dec 2009 16:20:03 +0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <001001ca7cd8$517ce440$f476acc0$@deacon@arm.com>
References: <1260799481-29951-1-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-2-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-3-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-4-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-5-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-6-git-send-email-jamie.iles@picochip.com>
	<001001ca7cd8$517ce440$f476acc0$@deacon@arm.com>
Message-ID: <20091214162003.GI4141@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2009 at 04:13:05PM -0000, Will Deacon wrote:
> > diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> > index fc5c05b..89a26ea 100644
> > --- a/arch/arm/mm/Kconfig
> > +++ b/arch/arm/mm/Kconfig
> > @@ -791,3 +791,11 @@ config ARM_L1_CACHE_SHIFT
> >  	int
> >  	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
> >  	default 5
> > +
> > +config HW_PERF_EVENTS
> > +	bool "Enable hardware performance counter support for perf events"
> > +	depends on PERF_EVENTS && CPU_HAS_PMU && CPU_V6
> > +	default n
> > +	help
> > +	  Enable hardware performance counter support for perf events. If
> > +	  disabled, perf events will use software events only.
> > --
> > 1.6.5.4
> 
> Why are you modifying mm/Kconfig? I think it would be better to change the
> Makefile to use CONFIG_HAVE_PERF_EVENTS rather than define a new bool.
Because this bool says that we support hardware perf events. If it isn't set,
we can still do perf events, but only the software variety. This allows us to
do software events for ARMv5 and earlier, but also do hardware counter support
where available.

Jamie
