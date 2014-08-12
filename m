From: ohaugan@codeaurora.org (Olav Haugan)
Date: Tue, 12 Aug 2014 09:56:11 -0700
Subject: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
In-Reply-To: <CAF6AEGvZUanVtPxAt76+AAdOaNwyMJ3cmcJ1srsEYBeG7ELkBQ@mail.gmail.com>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>
 <1407797150-515-2-git-send-email-ohaugan@codeaurora.org>
 <871tsm5vcn.fsf@nvidia.com>
 <CAF6AEGvZUanVtPxAt76+AAdOaNwyMJ3cmcJ1srsEYBeG7ELkBQ@mail.gmail.com>
Message-ID: <53EA472B.3020900@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/12/2014 3:48 AM, Rob Clark wrote:
> On Mon, Aug 11, 2014 at 9:51 PM, Hiroshi Doyu <hdoyu@nvidia.com> wrote:
>> Hi Olav,
>>
>> Olav Haugan <ohaugan@codeaurora.org> writes:
>>
>>> @@ -93,6 +94,10 @@ enum iommu_attr {
>>>   * @detach_dev: detach device from an iommu domain
>>>   * @map: map a physically contiguous memory region to an iommu domain
>>>   * @unmap: unmap a physically contiguous memory region from an iommu domain
>>> + * @map_sg: map a scatter-gather list of physically contiguous memory chunks
>>> + * to an iommu domain
>>> + * @unmap_sg: unmap a scatter-gather list of physically contiguous memory
>>> + * chunks from an iommu domain
>>>   * @iova_to_phys: translate iova to physical address
>>>   * @domain_has_cap: domain capabilities query
>>>   * @add_device: add device to iommu grouping
>>> @@ -110,6 +115,11 @@ struct iommu_ops {
>>>                    phys_addr_t paddr, size_t size, int prot);
>>>         size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
>>>                      size_t size);
>>> +       int (*map_sg)(struct iommu_domain *domain, unsigned long iova,
>>> +                       struct scatterlist *sg, unsigned int nents, int prot,
>>> +                       unsigned long flags);
>>> +       int (*unmap_sg)(struct iommu_domain *domain, unsigned long iova,
>>> +                       size_t size, unsigned long flags);
>>
>> Do you have any exmaple/explanation for the above "flags"?
>>
>> Is this going to be used for iommu global/standard attribute or SoC
>> spcific one?
> 
> iirc, one plan for 'flags' was some sort of DONT_FLUSH_TLB flag for
> drivers which wanted to map/unmap N buffers with a single flush at the
> end.  There might have been some other usages envisioned.
> 

Yes, that was the original intent of the flags for now. I am sure we can
find other uses for this in the future.

Thanks,

Olav

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
