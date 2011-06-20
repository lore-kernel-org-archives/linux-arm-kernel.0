From: pullip.cho@samsung.com (KyongHo Cho)
Date: Mon, 20 Jun 2011 23:33:00 +0900
Subject: [Linaro-mm-sig] [PATCH 3/8] ARM: dma-mapping: use
	asm-generic/dma-mapping-common.h
In-Reply-To: <1308556213-24970-4-git-send-email-m.szyprowski@samsung.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <BANLkTimHE2jzQAav465WaG3iWVeHPyNRNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

Great job.

On Mon, Jun 20, 2011 at 4:50 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> +static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
> +{
> + ? ? ? dev->archdata.dma_ops = ops;
> +}
> +

Who calls set_dma_ops()?
In the mach. initialization part?
What if a device driver does not want to use arch's dma_map_ops
when machine init procedure set a dma_map_ops?
Even though, may arch defiens their dma_map_ops in archdata of device structure,
I think it is not a good idea that is device structure contains a
pointer to dma_map_ops
that may not be common to all devices in a board.

I also think that it is better to attach and to detach dma_map_ops dynamically.
Moreover, a mapping is not permanent in our Exynos platform
because a System MMU may be turned off while runtime.

DMA API must come with IOMMU API to initialize IOMMU in runtime.

Regards,
Cho KyongHo.
