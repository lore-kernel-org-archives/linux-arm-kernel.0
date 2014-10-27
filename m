From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 27 Oct 2014 12:12:38 +0100
Subject: [RFC PATCH v3 5/7] dma-mapping: detect and configure IOMMU in
 of_dma_configure
In-Reply-To: <20141027105158.GE8768@arm.com>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
 <20140922092909.GJ1470@ulmo> <20140922175027.GK7936@arm.com>
 <4572757.M4IDlCz5Vc@avalon> <20141027105158.GE8768@arm.com>
Message-ID: <544E28A6.8090209@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-10-27 11:51, Will Deacon wrote:
> On Tue, Oct 14, 2014 at 01:53:59PM +0100, Laurent Pinchart wrote:
>> On Monday 22 September 2014 18:50:27 Will Deacon wrote:
>>> On Mon, Sep 22, 2014 at 10:29:10AM +0100, Thierry Reding wrote:
>>>> Agreed. I wonder how useful it is to know the set of IOMMU instances
>>>> that each device can master through. Wouldn't it be more useful to keep
>>>> a list of master interfaces for each device? The set of IOMMU instances
>>>> can trivially be derived from that.
>>> I'm struggling to think how that would look. What do you mean by `master
>>> interfaces' in terms of the code we have in Linux? At the end of the day,
>>> the list of IOMMU instances (i.e. iommu_dma_mapping) exists because you
>>> and Laurent have use-cases involving devices mastering through multiple
>>> IOMMUs. If it doesn't work for you, it might be best for you to send me
>>> the patch ;)
>> Just for the record, I've brought up the topic of masters being served by
>> multiple IOMMUs, but don't have a use case for it (yet at least). I do have
>> masters served through multiple streams with separate stream IDs, but all by
>> the same IOMMU.
> Ok. I spoke to Arnd, David and Joerg at LPC and the consensus was that the
> DMA-mapping API should *not* be exposed to the details of masters that
> master through multiple IOMMUs. Instead, that should be abstracted by the
> device API by exposing that device as a single struct device.
>
> So, that's certainly an area that needs more work and I'll drop the limited
> support I'd cooked up from this patch set in the next version.

Great! That's more or less something I've already implemented on top of your
previous patchset, as I didn't have any good idea how to manage multiple 
masters
separately. I'm waiting for your next update and I will rebase my 
patches soon.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
