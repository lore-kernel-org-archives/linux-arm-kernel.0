From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Wed, 4 Nov 2015 13:57:48 +0000
Subject: PCIe host controller behind IOMMU on ARM
Message-ID: <PS1PR06MB11807CBE8EB2AC6B0158D2B5F52A0@PS1PR06MB1180.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am trying to hook up a PCIe host controller that sits behind an IOMMU,
but having some problems.

I'm using the pcie-rcar PCIe host controller and it works fine without
the IOMMU, and I can attach the IOMMU to the controller such that any calls
to dma_alloc_coherent made by the controller driver uses the iommu_ops
version of dma_ops.

However, I can't see how to make the endpoints to utilise the dma_ops that
the controller uses. Shouldn't the endpoints inherit the dma_ops from the
controller? Any pointers for this?

Thanks
Phil
