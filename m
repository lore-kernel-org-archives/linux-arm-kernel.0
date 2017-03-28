From: sricharan@codeaurora.org (Sricharan R)
Date: Tue, 28 Mar 2017 21:37:59 +0530
Subject: [PATCH V9 00/11] IOMMU probe deferral support
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA81750D76E@lhreml504-mbs>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
 <58D49845.9060407@hisilicon.com>
 <0ea8022b-a19b-335d-6cc6-81510196f891@codeaurora.org>
 <5FC3163CFD30C246ABAA99954A238FA81750B7CB@lhreml504-mbs>
 <db3d68f8-713c-9ae2-7df9-324bc1b375b1@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA81750CCC4@lhreml504-mbs>
 <f67fb561-4238-6933-04f3-0f910f9232d1@arm.com>
 <8d7ba471-84d4-b9f3-9d2a-de166f6839d4@codeaurora.org>
 <5FC3163CFD30C246ABAA99954A238FA81750D76E@lhreml504-mbs>
Message-ID: <eaf340c4-3d11-fdc5-df0b-b6fa42f35751@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 3/28/2017 7:45 PM, Shameerali Kolothum Thodi wrote:
>
>
>> -----Original Message-----
>> From: Sricharan R [mailto:sricharan at codeaurora.org]
>> Sent: Tuesday, March 28, 2017 5:54 AM
>> To: Robin Murphy; Shameerali Kolothum Thodi; Wangzhou (B);
>> will.deacon at arm.com; joro at 8bytes.org; lorenzo.pieralisi at arm.com;
>> iommu at lists.linux-foundation.org; linux-arm-kernel at lists.infradead.org;
>> linux-arm-msm at vger.kernel.org; m.szyprowski at samsung.com;
>> bhelgaas at google.com; linux-pci at vger.kernel.org; linux-
>> acpi at vger.kernel.org; tn at semihalf.com; hanjun.guo at linaro.org;
>> okaya at codeaurora.org
>> Subject: Re: [PATCH V9 00/11] IOMMU probe deferral support
>>
>> Hi,
>>
> [...]
>
>>>>>  From the logs its clear that  when ixgbevf driver originally probes
>>>>> and adds the device  to smmu  the dma mask is 32, but when it binds
>>>>> to vfio-pci, it becomes 64 bit.
>>>>
>>>> Just to add to that, the mask is set to 64 bit in the ixgebvf driver
>>>> probe[1]
>>>
>>> Aha, but of course it's still the same struct device getting bound to
>>> VFIO later, so whatever mask the first driver set is still in there
>>> when we go through of_dma_configure() the second time (and the fact
>>> that we go through more than once being the new behaviour). So yes,
>>> this is a legitimate problem and we really do need to be robust
>>> against size overflow. I reckon the below tweak of your fix is
>>> probably the way to go; cleaning up the arch_setup_dma_ops() interface
>> can happen later.
>>>
>>
>> ok, i will add this fix separately and also the acpi fix that lorenzo has
>> suggested in patch #8 in to the series after testing confirmation.
>>
> I can confirm that the patches fixes the issues reported here . Both
> DT and ACPI works now.
>

Thanks for the testing. Will repost with the fixes.

Regards,
  Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of Code Aurora Forum, hosted by The Linux Foundation
