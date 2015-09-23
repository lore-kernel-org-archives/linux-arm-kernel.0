From: djkurtz@google.com (Daniel Kurtz)
Date: Wed, 23 Sep 2015 13:19:11 +0800
Subject: [PATCH] arm/dma-mapping: Clarify arm_*_sync_sg_* usage
In-Reply-To: <e8d48fcd1f09604fcb21e3912979a001fdb5709a.1442948705.git.robin.murphy@arm.com>
References: <e8d48fcd1f09604fcb21e3912979a001fdb5709a.1442948705.git.robin.murphy@arm.com>
Message-ID: <CAGS+omCUMKhZh5YcE5D-EzuMSycOJD9CHN8y3QxU1AHj1ND9UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Wed, Sep 23, 2015 at 3:06 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> The comments on the arm_iommu_sync_sg_* functions are misleading, and
> do not hold up to scrutiny against the DMA API documentation. Since
> cache maintenance is performed on the CPU addresses of the original
> list, not the virtual DMA entries filled in by arm_iommu_map_sg,
> passing in fewer than the original number of entries can only result
> in the corresponding subset of the buffer being flushed/invalidated
> while the rest is skipped, which is almost certainly not what the
> caller desires.
>
> Fix all the relevant comments to say the correct thing; no functional
> difference for arm_dma_sync_sg*, as the current implementation of
> arm_dma_map_sg always returns the same number of entries as passed in
> if it succeeds.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Thanks for fixing these confuse comments!

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
