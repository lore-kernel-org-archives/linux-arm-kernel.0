From: joonas.lahtinen@linux.intel.com (Joonas Lahtinen)
Date: Mon, 19 Feb 2018 11:47:49 +0200
Subject: [PATCH V3 09/29] drm/i915: deprecate pci_get_bus_and_slot()
In-Reply-To: <87bmglb9w5.fsf@intel.com>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
 <1511801886-6753-10-git-send-email-okaya@codeaurora.org>
 <20180216145444.GA11014@bhelgaas-glaptop.roam.corp.google.com>
 <87bmglb9w5.fsf@intel.com>
Message-ID: <151903366919.5458.4766479266211215742@jlahtine-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jani Nikula (2018-02-19 11:34:34)
> On Fri, 16 Feb 2018, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Nov 27, 2017 at 11:57:46AM -0500, Sinan Kaya wrote:
> >> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> >> where a PCI device is present. This restricts the device drivers to be
> >> reused for other domain numbers.
> >> 
> >> Getting ready to remove pci_get_bus_and_slot() function in favor of
> >> pci_get_domain_bus_and_slot().
> >> 
> >> Extract the domain number from drm_device and pass it into
> >> pci_get_domain_bus_and_slot() function.
> >> 
> >> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> >
> > I don't know what happened to this, and it didn't make it into
> > v4.16-rc1.  I applied it to pci/deprecate-get-bus-and-slot for v4.17
> > along with the patch that actually removes pci_get_bus_and_slot().
> 
> It fell between the cracks as we couldn't apply it before getting a
> backmerge on the dependency. Sorry about that.
> 
> Ack for merging through your tree.

I just retested the patch and it still passes CI. We also now have the
dependency in our tree through the backmerge, so I can send this for the
next drm-next pull request. Either way suits me.

Regards, Joonas
