From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 12 Nov 2014 18:37:09 +0700
Subject: [PATCH V2 2/2] PCI: generic: Add msi_parent DT binding
In-Reply-To: <CA+mB=1LKghLd9CuyLgDE9WGG5+VrUJF8r4DEbR7CiZojjoRdvQ@mail.gmail.com>
References: <1415733454-24322-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1415733454-24322-3-git-send-email-suravee.suthikulpanit@amd.com>
 <CA+mB=1LEEtPCixB9Ej74L03yPPH7D6YvfpkZyJgsHCm97-GvKg@mail.gmail.com>
 <CA+mB=1LKghLd9CuyLgDE9WGG5+VrUJF8r4DEbR7CiZojjoRdvQ@mail.gmail.com>
Message-ID: <54634665.5030003@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/12/14 14:09, Srikanth Thokala wrote:
>>> @@ -122,9 +123,19 @@ static int gen_pci_config_write(struct pci_bus *bus, unsigned int devfn,
>>> >>         return PCIBIOS_SUCCESSFUL;
>>> >>  }
>>> >>
>>> >>+static int gen_pci_set_msi_parent(struct pci_bus *bus)
>>> >>+{
>>> >>+       struct gen_pci *pci = bus_to_gen_pci(bus);
>>> >>+
>>> >>+       bus->msi = pci->mchip;
>>> >>+
>>> >>+       return PCIBIOS_SUCCESSFUL;
>>> >>+}
>>> >>+
>>> >>  static struct pci_ops gen_pci_ops = {
>>> >>         .read   = gen_pci_config_read,
>>> >>         .write  = gen_pci_config_write,
>>> >>+       .set_msi_parent = gen_pci_set_msi_parent,
>> >
>> >We assign the msi chip through add_bus() call, do we still need this?
>> >
> There are series of patches from Yijing Wang around this.  You may have
> to go through them.
>
> Srikanth
>

Hm.. I was not aware of this patch. Thanks for the pointer. I'll check 
them out.

Suravee
