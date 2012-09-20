From: vdumpa@nvidia.com (Krishna Reddy)
Date: Wed, 19 Sep 2012 23:40:36 -0700
Subject: [RFC 0/5] ARM: dma-mapping: New dma_map_ops to control IOVA
 more precisely
In-Reply-To: <505A7DB4.4090902@wwwdotorg.org>
References: <1346223335-31455-1-git-send-email-hdoyu@nvidia.com>
 <20120918124918.GK2505@amd.com>
 <20120919095843.d1db155e0f085f4fcf64ea32@nvidia.com>
 <201209190759.46174.arnd@arndb.de> <20120919125020.GQ2505@amd.com>
 <401E54CE964CD94BAE1EB4A729C7087E379FDC1EEB@HQMAIL04.nvidia.com>
 <505A7DB4.4090902@wwwdotorg.org>
Message-ID: <401E54CE964CD94BAE1EB4A729C7087E379FDC1F2D@HQMAIL04.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > On Tegra, the following use cases need specific IOVA mapping.
> > 1. Few MMIO blocks need IOVA=PA mapping setup.
> 
> In that case, why would we enable the IOMMU for that one device; IOMMU
> disabled means VA==PA, right? Perhaps isolation of the device so it can only
> access certain PA ranges for security?

The device(H/W controller) need to access few special memory blocks(IOVA==PA)
and DRAM as well. If IOMMU is disabled, then it has to handle memory fragmentation,
 which defeats the purpose of IOMMU support.
There is also a case where frame buffer memory is passed from BootLoader to Kernel and
display H/W  continues to access it with IOMMU enabled. To support this, the one to one
mapping has to be setup before enabling IOMMU.

-KR
