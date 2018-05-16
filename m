From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 May 2018 10:18:41 +0100
Subject: [PATCH 1/4] amba: Export amba_bustype
In-Reply-To: <CAHp75VfGpS_QkLj4XM8uHW0BAJV0EBWZ_yLP0R2D+ok4Mt=SQg@mail.gmail.com>
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
 <CAHp75VfGpS_QkLj4XM8uHW0BAJV0EBWZ_yLP0R2D+ok4Mt=SQg@mail.gmail.com>
Message-ID: <20180516091841.GH16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 12:16:28PM +0300, Andy Shevchenko wrote:
> On Tue, May 8, 2018 at 10:06 PM, Kim Phillips <kim.phillips@arm.com> wrote:
> > This patch is provided in the context of allowing the Coresight driver
> > subsystem to be loaded as modules.  Coresight uses amba_bus in its call
> > to bus_find_device() in of_coresight_get_endpoint_device() when
> > searching for a configurable endpoint device.  This patch allows
> > Coresight to reference amba_bustype when built as a module.
> 
> > --- a/drivers/amba/bus.c
> > +++ b/drivers/amba/bus.c
> > @@ -197,6 +197,7 @@ struct bus_type amba_bustype = {
> >         .pm             = &amba_pm,
> >         .force_dma      = true,
> >  };
> > +EXPORT_SYMBOL_GPL(amba_bustype);
> 
> Oh,
> 
> What wrong with the approach let's say similar to PCI bus?
> 
> Whenever you have a struct device you may use two helpers:
> 
> dev_is_pci() -> is the device of PCI bus type?
> to_pci_dev() -> get's container of struct device for PCI bus case

How does that help with bus_find_device() which requires the bus_type
structure for the type of devices to be searched?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
