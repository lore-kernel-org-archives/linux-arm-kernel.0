From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Dec 2010 11:54:08 +0100
Subject: [PATCH 1/2] ARM: convert dma-mapping to asm-generic API
In-Reply-To: <1292926802-12326-1-git-send-email-jamie@jamieiles.com>
References: <1292926802-12326-1-git-send-email-jamie@jamieiles.com>
Message-ID: <201012211154.08821.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 December 2010 11:20:01 Jamie Iles wrote:
> This converts ARM to use the asm-generic/dma-mapping-common API for
> the DMA API. As a side effect, this also allows us to take advantage
> of DMA API debugging (CONFIG_DMA_API_DEBUG).
> 
> We have dma_map_ops for normal, non-coherent architectures, fully
> coherent architectures and architectures that require dmabounce
> support. A dma_ops field is added to struct dev_archdata so platforms
> using an ACP can override the dma operations for that device to be
> fully coherent e.g.
> 
>         struct device *my_coherent_device;
>         my_coherent_device->dev_archdata.dma_ops = &coherent_dma_ops;

I think what's more important here is the ability to use an IOMMU on
some devices while other devices are mapped statically.

I believe at the moment, at least MSM and OMAP support an IOMMU, but
we don't provide support for that in the DMA mapping interface yet.

	Arnd
