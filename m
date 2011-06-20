From: pullip.cho@samsung.com (KyongHo Cho)
Date: Mon, 20 Jun 2011 23:37:53 +0900
Subject: [PATCH 4/8] ARM: dma-mapping: implement dma sg methods on top of
	generic dma ops
In-Reply-To: <1308556213-24970-5-git-send-email-m.szyprowski@samsung.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <BANLkTimwo9bMCevBRxfSZJBrkjDpdihtKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

On Mon, Jun 20, 2011 at 4:50 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> -extern int arm_dma_map_sg(struct device *, struct scatterlist *, int,
> +extern int generic_dma_map_sg(struct device *, struct scatterlist *, int,
> ? ? ? ? ? ? ? ?enum dma_data_direction, struct dma_attrs *attrs);
> -extern void arm_dma_unmap_sg(struct device *, struct scatterlist *, int,
> +extern void generic_dma_unmap_sg(struct device *, struct scatterlist *, int,
> ? ? ? ? ? ? ? ?enum dma_data_direction, struct dma_attrs *attrs);
> -extern void arm_dma_sync_sg_for_cpu(struct device *, struct scatterlist *, int,
> +extern void generic_dma_sync_sg_for_cpu(struct device *, struct scatterlist *, int,
> ? ? ? ? ? ? ? ?enum dma_data_direction);
> -extern void arm_dma_sync_sg_for_device(struct device *, struct scatterlist *, int,
> +extern void generic_dma_sync_sg_for_device(struct device *, struct scatterlist *, int,
> ? ? ? ? ? ? ? ?enum dma_data_direction);
>

I don't understand why you changed arm_dma_*() with generic_dma_*()
even though they're functionality is not changed
and they are still specific to ARM.
They look like that they are generic in the kernel code.

Regards,
Cho KyongHo.
