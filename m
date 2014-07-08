From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 8 Jul 2014 11:42:48 +0100
Subject: [PATCH v8 2/9] pci: Export find_pci_host_bridge() function.
In-Reply-To: <20140707232749.GA22939@google.com>
References: <1404240214-9804-1-git-send-email-Liviu.Dudau@arm.com>
 <1404240214-9804-3-git-send-email-Liviu.Dudau@arm.com>
 <20140707232749.GA22939@google.com>
Message-ID: <20140708104248.GB6501@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 12:27:49AM +0100, Bjorn Helgaas wrote:
> On Tue, Jul 01, 2014 at 07:43:27PM +0100, Liviu Dudau wrote:
> > This is a useful function and we should make it visible outside the
> > generic PCI code. Export it as a GPL symbol.
> > 
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > Tested-by: Tanmay Inamdar <tinamdar@apm.com>
> > ---
> >  drivers/pci/host-bridge.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> > index 0e5f3c9..36c669e 100644
> > --- a/drivers/pci/host-bridge.c
> > +++ b/drivers/pci/host-bridge.c
> > @@ -16,12 +16,13 @@ static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
> >  	return bus;
> >  }
> >  
> > -static struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
> > +struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
> >  {
> >  	struct pci_bus *root_bus = find_pci_root_bus(bus);
> >  
> >  	return to_pci_host_bridge(root_bus->bridge);
> >  }
> > +EXPORT_SYMBOL_GPL(find_pci_host_bridge);
> 
> There's nothing in this series that uses find_pci_host_bridge(), so 
> how about we just wait until we have something that needs it?
> 
> Also, if/when we export this, I'd prefer a name that starts with "pci_"
> as most of the other interfaces do.

Understood.

I was using the function in the other patch series that adds PCIe support to arm64
in order to provide a pci_domain_nr() implementation. But I might not need it
in the end if I go ahead with separating pci_host_bridge creation from bus
creation.

Best regards,
Liviu

> 
> >  void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
> >  				 void (*release_fn)(struct pci_host_bridge *),
> > -- 
> > 2.0.0
> > 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
