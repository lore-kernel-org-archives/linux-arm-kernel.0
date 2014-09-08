From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 8 Sep 2014 15:05:34 +0100
Subject: [PATCH v10 06/10] PCI: Introduce generic domain handling for PCI
 busses.
In-Reply-To: <20140908140321.GF22717@arm.com>
References: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com>
 <1410184472-17630-7-git-send-email-Liviu.Dudau@arm.com>
 <20140908140321.GF22717@arm.com>
Message-ID: <20140908140533.GM27864@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 03:03:21PM +0100, Catalin Marinas wrote:
> On Mon, Sep 08, 2014 at 02:54:28PM +0100, Liviu Dudau wrote:
> > The handling of PCI domains (or PCI segments in ACPI speak) is
> > usually a straightforward affair but its implementation is
> > currently left to the architectural code, with pci_domain_nr(b)
> > querying the value of the domain associated with bus b.
> > 
> > This patch introduces CONFIG_PCI_DOMAINS_GENERIC as an
> > option that can be selected if an architecture want a
> > simple implementation where the value of the domain
> > associated with a bus is stored in struct pci_bus.
> > 
> > The architectures that select CONFIG_PCI_DOMAINS_GENERIC will
> > then have to implement pci_bus_assign_domain_nr() as a way
> > of setting the domain number associated with a root bus.
> > All child busses except the root bus will inherit the domain_nr
> > value from their parent.
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Catalin Marinas <Catalin.Marinas@arm.com>
> > [Renamed pci_set_domain_nr() to pci_bus_assign_domain_nr()]
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 
> I'm probably the author here, but the patch log doesn't say so (I don't
> mind, just a remark).

I've took you patch initially from an email fragment, sorry, should've
altered the commiter accordingly.

Best regards,
Liviu

> 
> -- 
> Catalin

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
