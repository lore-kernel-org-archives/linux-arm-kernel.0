From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Mon, 4 Sep 2017 20:33:22 +0800
Subject: [Question] PCI ACS is broken for ARM SMMU v3?
In-Reply-To: <59A81B4C.3020402@hisilicon.com>
References: <59A81B4C.3020402@hisilicon.com>
Message-ID: <59AD4812.3020602@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+to: Lorenzo

On 2017/8/31 22:21, Zhou Wang wrote:
> Hi Will and Alex,
> 
> pci_request_acs is called in drivers/iommu/arm-smmu-v3.c to set pci_acs_enable.
> 
> PCI subsystem tries to enable ACS as below:
> 
> 	pci_device_add
> 		--> pci_init_capabilities
> 			--> pci_enable_acs
> 
> in ACPI PCI driver. However, ACPI PCI driver will be called before SMMU v3 driver,
> which will lead pci_enable_acs to return directly as pci_acs_enable is not set
> before SMMU v3 driver loading.
> 
> I think this is a bug, what do you think about this problem?
> 
> Best,
> Zhou
> 
> 
> 
> 
> 
> .
> 
