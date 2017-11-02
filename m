From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 2 Nov 2017 07:50:02 -0500
Subject: [PATCH] dmaengine: dmatest: bug out when dma test times out
In-Reply-To: <21c3bb47-8ce6-fb53-9087-5f6bd3250bae@codeaurora.org>
References: <1509565797-5219-1-git-send-email-awallis@codeaurora.org>
 <20171102081758.GD3187@localhost>
 <21c3bb47-8ce6-fb53-9087-5f6bd3250bae@codeaurora.org>
Message-ID: <36367ec9-61b1-9701-2dec-667b175ed90d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2017 07:11 AM, Adam Wallis wrote:
>> This will essentially kill the system. People have been trying to remove
>> usage of BUG(), we should not do that. Complaining violently makes sense..
>>
> Understood. In my testing, the system is effectively shot if you run the dmatest
> in a tight enough loop, however, at least using a WARN would alert the user that
> the kernel might be in an unstable state. I will submit another patch with a
> WARN, even though, I hope a proper fix can be introduced at some point. I am not
> familiar enough with this code to propose such a fix at the moment though.

I think Adam's original patch is correct, because as he said, the code 
as it is today corrupts the kernel.  The BUG() is a stop-cap measure to 
prevent the user from thinking that the kernel is stable when it isn't.

So I think that either dmatest gets fixed properly today (which Adam 
said he cannot do), or you should apply his patch until the code can get 
fixed.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
