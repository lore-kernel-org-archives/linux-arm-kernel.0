From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Jan 2016 15:17:33 +0100
Subject: [PATCH 11/13] dtb: amd: Add PCIe SMMU device tree node
In-Reply-To: <56AA07AA.7050701@arm.com>
References: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20160128111453.GG17123@leverpostej> <56AA07AA.7050701@arm.com>
Message-ID: <6645680.g0j8d12m6d@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 January 2016 12:20:58 Robin Murphy wrote:
> >
> > Will, Robin, thoughts?
> 
> Any IDs specified here would only apply to DMA by the "platform device" 
> side of the host controller itself (as would an equivalent "iommus" 
> property on pcie0 once I finish the SMMUv2 generic binding support I'm 
> working on). In terms of PCI devices, the "mmu-masters" property is 
> overloaded such that only its existence matters, to identify that there 
> _is_ a relationship between the SMMU and the PCI bus(es) behind that 
> host controller.

I wasn't aware that this was actually still specified. I had hoped
we were getting rid of mmu-masters before anyone actually started
using it, but now I see it in ns2.dtsi and fsl-ls2080a.dtsi.

Does anyone know what happened to the plan to use the iommu DT binding
for the ARM SMMU instead? Do we now have to support both ways indefinitely?

	Arnd
