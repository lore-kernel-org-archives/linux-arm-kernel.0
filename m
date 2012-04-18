From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Apr 2012 07:31:53 +0000
Subject: [PATCH 1/1] arm/dts: Tegra30: Add device tree support for SMMU
In-Reply-To: <20120418.094448.2234414220947028341.hdoyu@nvidia.com>
References: <201204161534.20089.arnd@arndb.de>
 <20120418054140.GA17506@avionic-0098.adnet.avionic-design.de>
 <20120418.094448.2234414220947028341.hdoyu@nvidia.com>
Message-ID: <201204180731.54064.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 April 2012, Hiroshi Doyu wrote:
> If we can consider IOMMU as one of the implementation of DMA(Direct
> Memory Access), the prefix "dma-(window)" may make sense here. Then,
> we don't have to introduce a new concept "IO virtual address(iova)" in
> addition to the existing "bus address"(?)
> 
> Anyway, either name would be ok for me;)

I would just use dma-window, without the "ibm," prefix but following the
same conventions. Note that the of_parse_dma_window function is currently
only defined in powerpc specific code, and should get moved to
drivers/of from arch/powerpc/kernel/prom_parse.c.

	Arnd
