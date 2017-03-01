From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 2 Mar 2017 01:54:42 +0200
Subject: [PATCH 07/20] PCI: implement Devres interface to map PCI config
 space
In-Reply-To: <20170227151436.18698-8-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-8-lorenzo.pieralisi@arm.com>
Message-ID: <CAHp75VfdE6_W+DxhejorLxra2JQDGF3cG0uBedyOohhmcLiKLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2017 at 5:14 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> The introduction of the pci_remap_cfgspace() interface allows
> PCI host controller drivers to map PCI config space through a
> dedicated kernel interface. Current PCI host controller drivers
> use the devm_ioremap_* Devres interfaces to map PCI configuration
> space regions so in order to update them to the new
> pci_remap_cfgspace() mapping interface a new set of Devres interfaces
> should be implemented so that PCI host controller drivers can make
> use of them.
>
> Introduce two new functions in the PCI kernel layer and Devres
> documentation:
>
> - devm_pci_remap_cfgspace()
> - devm_pci_remap_cfg_resource()
>
> so that PCI host controller drivers can make use of them to map
> PCI configuration space regions.

Wouldn't you like to be consistent with current PCI API, i.e.:
1. devm_*() functions called pcim_*() in PCI.
2. If you may notice there is no separate pcim_*map*() stuff, they are
dynamically adapting to the case.

?

-- 
With Best Regards,
Andy Shevchenko
