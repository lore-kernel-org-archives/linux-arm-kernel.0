From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 30 Sep 2010 12:55:46 -0700
Subject: [PATCH 2/4] arm: dis-allow hotplug on MSM
In-Reply-To: <20100930195237.GA2174@elf.ucw.cz>
References: <1284062289-10914-1-git-send-email-dwalker@codeaurora.org>
	<1284062289-10914-3-git-send-email-dwalker@codeaurora.org>
	<20100930071919.GA6434@ucw.cz>
	<1285865137.14953.4.camel@c-dwalke-linux.qualcomm.com>
	<1285870183.14953.7.camel@c-dwalke-linux.qualcomm.com>
	<20100930195237.GA2174@elf.ucw.cz>
Message-ID: <1285876546.14953.10.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-09-30 at 21:52 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > > Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
> > > > > ---
> > > > >  arch/arm/Kconfig |    1 +
> > > > >  1 files changed, 1 insertions(+), 0 deletions(-)
> > > > > 
> > > > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > > > index d2dfbc2..829dd67 100644
> > > > > --- a/arch/arm/Kconfig
> > > > > +++ b/arch/arm/Kconfig
> > > > > @@ -1211,6 +1211,7 @@ config NR_CPUS
> > > > >  config HOTPLUG_CPU
> > > > >  	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
> > > > >  	depends on SMP && HOTPLUG && EXPERIMENTAL
> > > > > +	depends on !ARCH_MSM
> > > > >  	help
> > > > >  	  Say Y here to experiment with turning CPUs off and on.  CPUs
> > > > >  	  can be controlled through /sys/devices/system/cpu.
> > > > 
> > > > This is goodbye to s2ram support, AFAICT.
> > > 
> > > This depends on SMP tho. It's like saying,
> > > 
> > > depends on 
> > 
> > That's weird, there was more to this email..
> > 
> > It's like saying,
> > 
> > depends on SMP && HOTPLUG && EXPERIMENTAL && !ARCH_MSM
> > 
> > But ARCH_MSM has no SMP, so the whole thing should short circuit right
> > at the start. It's only when you bring in SMP that it get interesting.
> 
> If arch_msm has no SMP, then why is change needed?

I'm getting it ready for SMP .. It's not there yet but will be.

> (I was trying to warn you that you'll need HOTPLUG support to get SMP
> suspend support.)

Yeah, I'm aware of it.. We haven't implemented hotplug yet, so we don't
have suspend support yet for SMP.

Daniel
-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
