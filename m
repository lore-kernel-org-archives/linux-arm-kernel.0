From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 22 Jun 2018 16:17:24 -0500
Subject: [PATCH 1/2] hwrng: msm: add a spinlock and support for blocking
 reads
In-Reply-To: <4bc0afe1-0189-88c0-40aa-23a312325635@codeaurora.org>
References: <1529594276-12210-1-git-send-email-timur@codeaurora.org>
 <acc7e9d3-8a81-ff15-27c7-78ec7c17f6cc@linaro.org>
 <6d655b97-418e-bacf-7e88-b9179cdc6fd1@codeaurora.org>
 <152968991381.16708.522979730327886581@swboyd.mtv.corp.google.com>
 <4bc0afe1-0189-88c0-40aa-23a312325635@codeaurora.org>
Message-ID: <2ad6d37c-66eb-c173-95bc-f838d03e6741@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22/2018 01:03 PM, Timur Tabi wrote:
> 
>> Perhaps it's because you implemented the 'wait' functionality in this
>> driver? Before the patch there wasn't any sort of wait check so we would
>> bail out if there wasn't any data even if the caller requested that we
>> wait for randomness to be available.
> 
> No, my tests showed the race condition (or at least something that looks 
> like a race condition) even without the 'wait' feature.? I added support 
> for 'wait' only recently, but I've been working with the crypto people 
> for a month on everything else.

Looks like I was wrong.

I created some new tests to reproduce the problem, but I can't reproduce 
it any more.  I can only assume that what I saw as a race condition back 
then was something else entirely.

So all of the spinlock code needs to go.  It looks like at this point, 
if Vinod can add support for QCOM8160 to his patches, the only thing I 
can contribute is support for 'wait'.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
