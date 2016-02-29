From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 29 Feb 2016 11:47:28 +0000
Subject: [PATCH 1/2] iommu/mediatek: select ARM_DMA_USE_IOMMU
In-Reply-To: <5357325.sBkT8ESvOS@wuerfel>
References: <1456737553-496245-1-git-send-email-arnd@arndb.de>
 <2734684.OJWJHS6snX@wuerfel> <56D429F0.7010409@arm.com>
 <5357325.sBkT8ESvOS@wuerfel>
Message-ID: <56D42FD0.8030302@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/02/16 11:29, Arnd Bergmann wrote:
> On Monday 29 February 2016 11:22:24 Robin Murphy wrote:
>>>>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>>>> index b325954cf8f8..ea0998921702 100644
>>>>> --- a/drivers/iommu/Kconfig
>>>>> +++ b/drivers/iommu/Kconfig
>>>>> @@ -341,6 +341,7 @@ config MTK_IOMMU
>>>>>      bool "MTK IOMMU Support"
>>>>>      depends on ARM || ARM64
>>>>>      depends on ARCH_MEDIATEK || COMPILE_TEST
>>>>> +   select ARM_DMA_USE_IOMMU
>>>>
>>>> If going down this route, I'd be inclined to add an "if ARM" there, just
>>>> for clarity.
>>>
>>> That would run into the NEED_SG_DMA_LENGTH problem on other architectures
>>> that don't already set it, right?
>>
>> Sorry, I'm lost - wouldn't "depends on ARM || ARM64" make other
>> architectures moot? arm64 already has NEED_SG_DMA_LENGTH=y by default.
>>
>
> Nevermind, I didn't notice the dependency on the architecture.
>
> What is keeping us from having 'depends on ARM || ARM64 || COMPILE_TEST'?

IIRC it got changed because the kbuild test robot was consistently 
blowing up due to missing definitions on things like parisc.

Robin.

> I assume it doesn't work yet, but it would be nice to get that done
> at some point so we can take advantage of automated build testing like
> coverity.
>
> 	Arnd
>
