From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 7 May 2012 09:52:54 +0200
Subject: [PATCHv5 1/3] ARM: tegra: Add Tegra AHB driver
In-Reply-To: <20120507074228.GK26481@n2100.arm.linux.org.uk>
References: <1336373032-16881-1-git-send-email-hdoyu@nvidia.com><20120507074228.GK26481@n2100.arm.linux.org.uk>
Message-ID: <20120507.105254.1899925115243585929.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv5 1/3] ARM: tegra: Add Tegra AHB driver
Date: Mon, 7 May 2012 09:42:28 +0200
Message-ID: <20120507074228.GK26481@n2100.arm.linux.org.uk>

> On Mon, May 07, 2012 at 09:43:45AM +0300, Hiroshi DOYU wrote:
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index 5870322..d97e2e2 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -18,7 +18,7 @@ obj-$(CONFIG_SFI)		+= sfi/
> >  # PnP must come after ACPI since it will eventually need to check if acpi
> >  # was used and do nothing if so
> >  obj-$(CONFIG_PNP)		+= pnp/
> > -obj-$(CONFIG_ARM_AMBA)		+= amba/
> > +obj-$(CONFIG_ARM)		+= amba/
> 
> NAK.  This makes amba only buildable for ARM which is not the intention.
> Other architectures do have Primecells.

What about the following?

 +obj-y		+= amba/
