From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Wed, 6 May 2015 09:34:25 -0500
Subject: [V2 PATCH 2/5] arm64 : Introduce support for ACPI _CCA object
In-Reply-To: <5549E834.1040305@arm.com>
References: <1430838729-21572-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1430838729-21572-3-git-send-email-Suravee.Suthikulpanit@amd.com>
 <5549E834.1040305@arm.com>
Message-ID: <554A2671.8020804@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/6/2015 5:08 AM, Robin Murphy wrote:
> [...]
>> +static void __dummy_sync_single_for_cpu(struct device *dev,
>> +                    dma_addr_t dev_addr, size_t size,
>> +                    enum dma_data_direction dir)
>> +{
>> +}
>> +
>> +static void __dummy_sync_single_for_device(struct device *dev,
>> +                       dma_addr_t dev_addr, size_t size,
>> +                       enum dma_data_direction dir)
>> +{
>> +}
>
> Minor point, but I don't see the need to have multiple dummy functions
> with identical signatures - just have a generic dummy_sync_single and
> assign it to both ops.
>
>> +static void __dummy_sync_sg_for_cpu(struct device *dev,
>> +                    struct scatterlist *sgl, int nelems,
>> +                    enum dma_data_direction dir)
>> +{
>> +}
>> +
>> +static void __dummy_sync_sg_for_device(struct device *dev,
>> +                       struct scatterlist *sgl, int nelems,
>> +                       enum dma_data_direction dir)
>> +{
>> +}
>
> Ditto here with dummy_sync_sg.

Hi Robin,

Good point. I'll take care of that in V3.

>
> I wonder if there's any argument for putting the dummy DMA ops somewhere
> common, like drivers/base/dma-mapping.c?
>
> Robin.

Hm.. If this approach will be adopted by other architectures, then it 
would make sense. Currently, this is only used by arm64. So, I think it 
is okay to leave this here for now.

Thanks,
Suravee
