From: ritesh.harjani@gmail.com (Ritesh Harjani)
Date: Thu, 5 Jun 2014 14:48:07 +0530
Subject: [PATCH 1/1] device.h: arm,
 dma-iommu: Move out dma_iommu_mapping struct
In-Reply-To: <20140604185926.GB30884@kroah.com>
References: <1401869506-48129-1-git-send-email-ritesh.harjani@gmail.com>
 <1401869506-48129-2-git-send-email-ritesh.harjani@gmail.com>
 <20140604175145.GD20812@kroah.com>
 <CAD15agbiuXiiAp62R-NeLeX3rgNftmyb+wGiSVx-FgtcXzxpHA@mail.gmail.com>
 <20140604185926.GB30884@kroah.com>
Message-ID: <CAD15agbUUBsH1Zma7sXMn9PmChKopvqkGLCDEv_HeMWdGjkK=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Thu, Jun 5, 2014 at 12:29 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Jun 05, 2014 at 12:16:28AM +0530, Ritesh Harjani wrote:
>> Hi Greg,
>>
>> Thanks for reviewing.
>>
>> On Wed, Jun 4, 2014 at 11:21 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> > On Wed, Jun 04, 2014 at 01:41:46PM +0530, ritesh.harjani at gmail.com wrote:
>> >> From: Ritesh Harjani <ritesh.harjani@gmail.com>
>> >>
>> >> This patch moves out *mapping pointer of dma_iommu_mapping
>> >> from arch/arm/include/asm/device.h to include/liunux/device.h
>> >
>> > Why?  Who else can use this becides arm devices?
>>
>> Currently only arm and arm64 are the archs at this very moment but
>> later other archs can make use of this, as its an arch independent
>> code. (Similar to as some arch make use of iommu_area_alloc in
>> iommu-helper.c)
>>
>> >
>> >>
>> >> Also, it moves out complete structre definition of dma_iommu_mapping
>> >> to include/linux/iommu-helper.h
>> >>
>> >> This is done since arm iommu's dma-mapping arch independent code,
>> >> needs to be moved out to lib/iommu-helper.c, this means
>> >> dma_iommu_mapping will be arch independent and later other archs
>> >> can make use of it.
>> >
>> > Will that really happen?  Do you have patches that do that?  I'd prefer
>> > to not do stuff like this until you have a patch series that needs it,
>> > otherwise this is just unneeded churn.
>>
>> Yes, foll link has the patch series, (under review)
>> http://www.spinics.net/lists/arm-kernel/msg336896.html
>
> Make this patch 1/3 of that series and resend, I don't want to take this
> one if the others are not accepted.

Sure I will do that.

>
> thanks,
>
> greg k-h

Thanks
Ritesh
