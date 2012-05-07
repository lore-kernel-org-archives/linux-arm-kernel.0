From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 7 May 2012 11:23:33 +0200
Subject: [PATCHv5 1/3] ARM: tegra: Add Tegra AHB driver
In-Reply-To: <201205070859.29174.arnd@arndb.de>
References: <20120507074228.GK26481@n2100.arm.linux.org.uk><20120507.105254.1899925115243585929.hdoyu@nvidia.com><201205070859.29174.arnd@arndb.de>
Message-ID: <20120507.122333.2024326166703361049.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv5 1/3] ARM: tegra: Add Tegra AHB driver
Date: Mon, 7 May 2012 10:59:28 +0200
Message-ID: <201205070859.29174.arnd@arndb.de>

> On Monday 07 May 2012, Hiroshi Doyu wrote:
> > > On Mon, May 07, 2012 at 09:43:45AM +0300, Hiroshi DOYU wrote:
> > > > diff --git a/drivers/Makefile b/drivers/Makefile
> > > > index 5870322..d97e2e2 100644
> > > > --- a/drivers/Makefile
> > > > +++ b/drivers/Makefile
> > > > @@ -18,7 +18,7 @@ obj-$(CONFIG_SFI)         += sfi/
> > > >  # PnP must come after ACPI since it will eventually need to check if acpi
> > > >  # was used and do nothing if so
> > > >  obj-$(CONFIG_PNP)          += pnp/
> > > > -obj-$(CONFIG_ARM_AMBA)             += amba/
> > > > +obj-$(CONFIG_ARM)          += amba/
> > > 
> > > NAK.  This makes amba only buildable for ARM which is not the intention.
> > > Other architectures do have Primecells.
> > 
> > What about the following?
> > 
> >  +obj-y         += amba/
> 
> Looks ok to me, but which problem are you trying to solve anyway? Tegra
> always enables ARM_AMBA, so AFAICT there is no difference between this
> and the original code.

Tegra doesn't enable ARM_AMBA and Tegra doesn't use the following
"drivers/amba/bus.c" right now. I needed to make this directory
available to ones without ARM_AMBA enabled.

drivers/amba/Makefile:

obj-$(CONFIG_ARM_AMBA)		+= bus.o
obj-$(CONFIG_TEGRA_AHB)		+= tegra-ahb.o
