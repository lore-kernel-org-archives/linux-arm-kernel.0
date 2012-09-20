From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 19 Sep 2012 20:21:40 -0600
Subject: [RFC 0/5] ARM: dma-mapping: New dma_map_ops to control IOVA more
 precisely
In-Reply-To: <401E54CE964CD94BAE1EB4A729C7087E379FDC1EEB@HQMAIL04.nvidia.com>
References: <1346223335-31455-1-git-send-email-hdoyu@nvidia.com>
 <20120918124918.GK2505@amd.com>
 <20120919095843.d1db155e0f085f4fcf64ea32@nvidia.com>
 <201209190759.46174.arnd@arndb.de> <20120919125020.GQ2505@amd.com>
 <401E54CE964CD94BAE1EB4A729C7087E379FDC1EEB@HQMAIL04.nvidia.com>
Message-ID: <505A7DB4.4090902@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2012 07:44 PM, Krishna Reddy wrote:
>> When a device driver would only use the IOMMU-API and needs small DMA-
>> able areas it has to re-implement something like the DMA-API (basically an
>> address allocator) for that. So I don't see a reason why both can't be used in a
>> device driver.
> 
> On Tegra, the following use cases need specific IOVA mapping.
> 1. Few MMIO blocks need IOVA=PA mapping setup.

In that case, why would we enable the IOMMU for that one device; IOMMU
disabled means VA==PA, right? Perhaps isolation of the device so it can
only access certain PA ranges for security?
