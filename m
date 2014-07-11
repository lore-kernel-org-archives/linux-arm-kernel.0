From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 11 Jul 2014 16:02:34 +0100
Subject: [PATCH] bus: ARM CCN PMU driver
In-Reply-To: <20140711142135.GA21766@n2100.arm.linux.org.uk>
References: <1405088056-29181-1-git-send-email-pawel.moll@arm.com>
 <20140711142135.GA21766@n2100.arm.linux.org.uk>
Message-ID: <1405090954.32598.60.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-07-11 at 15:21 +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 11, 2014 at 03:14:16PM +0100, Pawel Moll wrote:
> > diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> > index 1f37d98..6ab2a62 100644
> > --- a/drivers/bus/Kconfig
> > +++ b/drivers/bus/Kconfig
> > @@ -4,14 +4,6 @@
> >  
> >  menu "Bus devices"
> >  
> > -config BRCMSTB_GISB_ARB
> > -	bool "Broadcom STB GISB bus arbiter"
> > -	depends on ARM
> > -	help
> > -	  Driver for the Broadcom Set Top Box System-on-a-chip internal bus
> > -	  arbiter. This driver provides timeout and target abort error handling
> > -	  and internal bus master decoding.
> > -
> ...
> > diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
> > index 6a4ea7e..493b4ff 100644
> > --- a/drivers/bus/Makefile
> > +++ b/drivers/bus/Makefile
> > @@ -2,14 +2,15 @@
> >  # Makefile for the bus drivers.
> >  #
> >  
> > -obj-$(CONFIG_BRCMSTB_GISB_ARB)	+= brcmstb_gisb.o
> 
> I assume that as these exist in the patch, you haven't looked through
> the patch to check what you're actually submitting... 

This is, obviously, my bad and lack of attention after last minute
rebase, for which I apologise.

> how can we be
> sure that the rest of the patch is what you intend to submit?

Of course you can't be sure, unless you are willing to take my word for
it. Maybe the fact that 46% of the added lines contains upper- or
lowercase string "CCN" matching the subject can support my plea.

Pawel
