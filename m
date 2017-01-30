From: sricharan@codeaurora.org (Sricharan)
Date: Mon, 30 Jan 2017 17:30:58 +0530
Subject: [PATCH V7 07/11] iommu: of: Handle IOMMU lookup failure with
 deferred probing or error
In-Reply-To: <34a703f0-3b37-88f0-46fa-b56ab6717a42@codeaurora.org>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
 <1485188293-20263-8-git-send-email-sricharan@codeaurora.org>
 <34a703f0-3b37-88f0-46fa-b56ab6717a42@codeaurora.org>
Message-ID: <008f01d27af0$88e897d0$9ab9c770$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>-----Original Message-----
>From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Sinan Kaya
>Sent: Sunday, January 29, 2017 10:06 PM
>To: Sricharan R <sricharan@codeaurora.org>; robin.murphy at arm.com; will.deacon at arm.com; joro at 8bytes.org;
>lorenzo.pieralisi at arm.com; iommu at lists.linux-foundation.org; linux-arm-kernel at lists.infradead.org; linux-arm-
>msm at vger.kernel.org; m.szyprowski at samsung.com; bhelgaas at google.com; linux-pci at vger.kernel.org; linux-acpi at vger.kernel.org
>Subject: Re: [PATCH V7 07/11] iommu: of: Handle IOMMU lookup failure with deferred probing or error
>
>On 1/23/2017 11:18 AM, Sricharan R wrote:
>> @@ -107,7 +107,7 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>>  	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>>  	if (ret < 0) {
>>  		dma_addr = offset = 0;
>> -		size = dev->coherent_dma_mask + 1;
>> +		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
>>  	} else {
>
>what's happening here?

Sorry, not relevant. Will remove this. Has come in because of some rebase mistake.

Regards,
 Sricharan
