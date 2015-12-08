From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 8 Dec 2015 09:33:45 -0500
Subject: [PATCH V7 3/3] dma: add Qualcomm Technologies HIDMA channel driver
In-Reply-To: <20151205080030.GJ1854@localhost>
References: <1448245707-27499-1-git-send-email-okaya@codeaurora.org>
 <1448245707-27499-4-git-send-email-okaya@codeaurora.org>
 <20151130085948.GC3901@localhost> <565CAC4C.7080909@codeaurora.org>
 <20151201113458.GL3901@localhost> <565E0E1D.1040505@codeaurora.org>
 <565F40A5.2040701@codeaurora.org> <20151205080030.GJ1854@localhost>
Message-ID: <5666EA49.2030206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/5/2015 3:00 AM, Vinod Koul wrote:
> On Wed, Dec 02, 2015 at 02:04:05PM -0500, Sinan Kaya wrote:
>>>>> You are missing the point. Channel can be paused, yes but the descriptor
>>>>> is in queue and is not paused. The descriptor running is paused, yes.
>>>>> There is subtle difference between these
>>> I'll follow your recommendation. PAUSE for the currently active
>>> descriptor and DMA_IN_PROGRESS for the rest.
>>>
>>
>> I'm now confused.
>>
>> I looked at several DMA driver implementations.
>>
>> 1. They call dma_cookie_status function to see if the job is done.
>> 2. If done, they return right ahead.
>> 3. Otherwise, dma_cookie_status returns DMA_IN_PROGRESS.
>> 4. Next the code checks if the channel is paused and return value is
>> DMA_IN_PROGRESS. The code changes return code to DMA_PAUSED.
>>
>> Whereas, I was returning paused first before even checking if the
>> descriptor is done. Are you OK with the sequence 1..4 above?
> 
> Yes am okay with this with slight change in 4.
> 
> You should set to PAUSED only for current descriptor and not for the ones in
> queue
> 
OK, I'll work on it.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
