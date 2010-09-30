From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 30 Sep 2010 09:45:37 -0700
Subject: [PATCH 2/4] arm: dis-allow hotplug on MSM
In-Reply-To: <20100930071919.GA6434@ucw.cz>
References: <1284062289-10914-1-git-send-email-dwalker@codeaurora.org>
	<1284062289-10914-3-git-send-email-dwalker@codeaurora.org>
	<20100930071919.GA6434@ucw.cz>
Message-ID: <1285865137.14953.4.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-09-30 at 09:19 +0200, Pavel Machek wrote:
> Hi!
> 
> > MSM doesn't support hotplug, so we prevent it from being
> > select with this added line.
> > 
> > Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
> > ---
> >  arch/arm/Kconfig |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index d2dfbc2..829dd67 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1211,6 +1211,7 @@ config NR_CPUS
> >  config HOTPLUG_CPU
> >  	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
> >  	depends on SMP && HOTPLUG && EXPERIMENTAL
> > +	depends on !ARCH_MSM
> >  	help
> >  	  Say Y here to experiment with turning CPUs off and on.  CPUs
> >  	  can be controlled through /sys/devices/system/cpu.
> 
> This is goodbye to s2ram support, AFAICT.

This depends on SMP tho. It's like saying,

depends on 
-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
