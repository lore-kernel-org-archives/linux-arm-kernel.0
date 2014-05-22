From: ritesh.harjani@gmail.com (Ritesh Harjani)
Date: Thu, 22 May 2014 21:22:38 +0530
Subject: Cache maintenance in arm_iommu_alloc_attrs for iommu_coherent_ops
In-Reply-To: <537DB5F3.4090000@samsung.com>
References: <CAD15agav14RUb473+iCm24HM9eQfWYG8ytZOfpzm5j0e3EX3WQ@mail.gmail.com>
 <CAD15agY8bBQZgcVqJjM2W8x5qHs5ozs-nVa1QJuzmiqHW2wFOg@mail.gmail.com>
 <537DB5F3.4090000@samsung.com>
Message-ID: <CAD15agYLuZ9+4ZYdvS9S54xr=vvZQVtthQxjVeWG8zwUvEO3Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Marek,

I will push in the fixes soon.

Regards
Ritesh


On Thu, May 22, 2014 at 2:01 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hello,
>
>
> On 2014-05-21 11:37, Ritesh Harjani wrote:
>>
>> arm_iommu_mmap_attrs function for iommu_coherent_ops(and also for
>> noncoherent iommu_ops) calls for __get_dma_pgprot.
>>
>>   628 static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs,
>> pgprot_t prot)
>>   629 {
>>   630         prot = dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs) ?
>>   631                             pgprot_writecombine(prot) :
>>   632                             pgprot_dmacoherent(prot);
>>   633         return prot;
>>   634 }
>>
>> Now if someone calls for dma_mmap_coherent, then we should not be
>> changing the memory to be uncached always to make it coherent right
>> (from functino __get_dma_pgprot above) ??
>> It should be based on dma_map_ops, and if it is iommu_coherent_ops,
>> then we should not change the memory to be uncached ??
>
>
> Once again you are right. This also need to be fixed.
>
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
