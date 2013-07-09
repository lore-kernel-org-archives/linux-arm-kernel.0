From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 08 Jul 2013 19:38:58 -0700
Subject: [PATCH V3] of: Set the DMA mask to 64 bits when dma_addr_t is
 64-bits
In-Reply-To: <20130708104254.GS24642@n2100.arm.linux.org.uk>
References: <1367008266-1431-1-git-send-email-lauraa@codeaurora.org>
 <517AF270.8040106@gmail.com>
 <CACVXFVPfkqP+UyoGd-+QFRzndSam_DtU=utrBPYCPjQCGQ_F6g@mail.gmail.com>
 <51D71F81.5090503@codeaurora.org>
 <20130708104254.GS24642@n2100.arm.linux.org.uk>
Message-ID: <51DB77C2.4060705@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/8/2013 3:42 AM, Russell King - ARM Linux wrote:
>>
>> The problem is the way the arm_dma_limit is set up, all dma allocations
>> are currently broken regardless of if the actual device supports 64-bit
>> addresses or not.
>
> Please explain this statement.
>

The statement was a bit shortsighted given recent discussions. My point 
was that on LPAE systems right now without ZONE_DMA, the allocation 
fails by default (i.e. no call to set_mask) even if the device could 
support 64-bit physical memory. Based on this thread though, drivers 
should stop assuming the dma_mask will be set up properly and always set 
the mask appropriately.

The conclusion also seems to be that if devices on an LPAE system can't 
handle > 32-bit addresses and want to limit via mask, ZONE_DMA must be 
set up.

Please correct me if I misunderstood anything.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
