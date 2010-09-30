From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 30 Sep 2010 21:52:37 +0200
Subject: [PATCH 2/4] arm: dis-allow hotplug on MSM
In-Reply-To: <1285870183.14953.7.camel@c-dwalke-linux.qualcomm.com>
References: <1284062289-10914-1-git-send-email-dwalker@codeaurora.org>
	<1284062289-10914-3-git-send-email-dwalker@codeaurora.org>
	<20100930071919.GA6434@ucw.cz>
	<1285865137.14953.4.camel@c-dwalke-linux.qualcomm.com>
	<1285870183.14953.7.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100930195237.GA2174@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > > Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
> > > > ---
> > > >  arch/arm/Kconfig |    1 +
> > > >  1 files changed, 1 insertions(+), 0 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > > index d2dfbc2..829dd67 100644
> > > > --- a/arch/arm/Kconfig
> > > > +++ b/arch/arm/Kconfig
> > > > @@ -1211,6 +1211,7 @@ config NR_CPUS
> > > >  config HOTPLUG_CPU
> > > >  	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
> > > >  	depends on SMP && HOTPLUG && EXPERIMENTAL
> > > > +	depends on !ARCH_MSM
> > > >  	help
> > > >  	  Say Y here to experiment with turning CPUs off and on.  CPUs
> > > >  	  can be controlled through /sys/devices/system/cpu.
> > > 
> > > This is goodbye to s2ram support, AFAICT.
> > 
> > This depends on SMP tho. It's like saying,
> > 
> > depends on 
> 
> That's weird, there was more to this email..
> 
> It's like saying,
> 
> depends on SMP && HOTPLUG && EXPERIMENTAL && !ARCH_MSM
> 
> But ARCH_MSM has no SMP, so the whole thing should short circuit right
> at the start. It's only when you bring in SMP that it get interesting.

If arch_msm has no SMP, then why is change needed?

(I was trying to warn you that you'll need HOTPLUG support to get SMP
suspend support.)
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
