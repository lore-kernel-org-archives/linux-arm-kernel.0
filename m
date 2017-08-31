From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Thu, 31 Aug 2017 22:21:00 +0800
Subject: [Question] PCI ACS is broken for ARM SMMU v3?
Message-ID: <59A81B4C.3020402@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will and Alex,

pci_request_acs is called in drivers/iommu/arm-smmu-v3.c to set pci_acs_enable.

PCI subsystem tries to enable ACS as below:

	pci_device_add
		--> pci_init_capabilities
			--> pci_enable_acs

in ACPI PCI driver. However, ACPI PCI driver will be called before SMMU v3 driver,
which will lead pci_enable_acs to return directly as pci_acs_enable is not set
before SMMU v3 driver loading.

I think this is a bug, what do you think about this problem?

Best,
Zhou
