From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 19 Mar 2013 10:54:59 -0700
Subject: [Linaro-mm-sig] [PATCH 2/2] drivers: dma-contiguous: add
 initialization from device tree
In-Reply-To: <51433C8B.20607@samsung.com>
References: <1360845928-8107-1-git-send-email-m.szyprowski@samsung.com>
 <1360845928-8107-3-git-send-email-m.szyprowski@samsung.com>
 <511D586A.5060902@codeaurora.org> <51433C8B.20607@samsung.com>
Message-ID: <5148A673.5060806@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/15/2013 8:21 AM, Marek Szyprowski wrote:
>>
>> This scheme of associating devices with CMA regions by base does not
>> work if you want to let CMA figure out where to place the region (base
>> = 0). Can we use the name to associate the device with the region? I
>> had been working on something similar internally and that was the only
>> solution I had come up with to associate arbitrary CMA nodes with
>> devices.
>
> Right, support for base = 0 requires different handling, but I thought
> that if
> we use the device tree approach, the designer already knows the complete
> memory
> configuration, so providing the correct base address is not that hard.

Not necessarily. The sizes of and number of regions may change depending 
on use cases. It's much easier to let Linux figure out where to place 
the regions vs. having to manually place everything each time.
(This also gets into the fact that some of the way we use CMA is a 
'grey' area that isn't actually hardware related)

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
