From: decui@microsoft.com (Dexuan Cui)
Date: Fri, 24 Feb 2017 15:10:42 +0000
Subject: [PATCH v1 0/3] PCI: Configure PCIe MPS settings
In-Reply-To: <20170224143224.GA15547@bhelgaas-glaptop.roam.corp.google.com>
References: <20170208224632.14351.89895.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170210215959.GR29169@bhelgaas-glaptop.roam.corp.google.com>
 <MWHPR03MB26690F3B4C7E83596C35D377BF520@MWHPR03MB2669.namprd03.prod.outlook.com>
 <20170224143224.GA15547@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <CY4PR03MB2662B31A164D509D476A3B43BF520@CY4PR03MB2662.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Bjorn Helgaas
> ...
> My question wasn't so much whether pci-hyperv.c *needs* to set MPS; I
> don't expect a guest to need to or even be able to configure things
> like that.

I agree.

> My question is whether it would do any harm if we did eventually do
> MPS configuration in the generic pci_scan_child_bus() path.  If/when
> we do that, the Hyper-V guest will attempt to do MPS configuration.  I
> think this would be a no-op.

Yes. It's a no-op, as I explained in my previous mail.

>  And I think it would also be a no-op if
> we made pci-hyperv.c call pcie_bus_configure_settings() today.

Yes, I can confirm it's a no-op too.

> I'm really just looking for confirmation of that.  If it is true that
> these are no-ops, I would consider adding a pci-hyperv.c call to
> pcie_bus_configure_settings() simply to make it conform to the pattern
> that "everything that calls pci_scan_child_bus() should also call
> pcie_bus_configure_settings()".

Please help to add that. Thanks!
 
> If every caller of pci_scan_child_bus() also calls
> pcie_bus_configure_settings(), it will make it easier in the future to
> fold pcie_bus_configure_settings() into pci_scan_child_bus().
> 
> Bjorn

Thanks! I see.

Thanks,
-- Dexuan
