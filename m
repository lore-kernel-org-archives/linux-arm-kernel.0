From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 11 Mar 2016 11:44:26 -0500
Subject: [PATCH V14 5/9] dma: qcom_hidma: implement lower level hardware
 interface
In-Reply-To: <20160311163221.GC13211@localhost>
References: <1454646882-24369-1-git-send-email-okaya@codeaurora.org>
 <1454646882-24369-6-git-send-email-okaya@codeaurora.org>
 <20160311020650.GG11154@localhost> <56E2EC1C.6040107@codeaurora.org>
 <20160311163221.GC13211@localhost>
Message-ID: <56E2F5EA.10207@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/11/2016 11:32 AM, Vinod Koul wrote:
>>>> memcpy(lldev->tre_ring + lldev->tre_write_offset, &tre->tre_local[0],
>>>> > >> +	       TRE_SIZE);
> This one
> 
>>>> > >> +	lldev->tx_status_list[tre->idx].err_code = 0;
>>>> > >> +	lldev->tx_status_list[tre->idx].err_info = 0;
>>>> > >> +	tre->queued = 1;
>>>> > >> +	lldev->pending_tre_count++;
>> > 
>> > Is this the only one without alignment? I couldn't understand what you mean by 
>> > above one?
> quoting Coding Style:
> 
> Statements longer than 80 columns will be broken into sensible chunks, unless
> exceeding 80 columns significantly increases readability and does not hide
> information. 

> "Descendants are always substantially shorter than the parent and
> are placed substantially to the right."
> 
> 

Sorry for my poor English. I never got this rule. 

Which one is a "substantially" right? Can you give me an example?

I need to understand how you'd write this to satisfy the above rule.

like this:

memcpy(lldev->tre_ring + lldev->tre_write_offset, &tre->tre_local[0],
       TRE_SIZE);

or

memcpy(lldev->tre_ring + lldev->tre_write_offset,
       &tre->tre_local[0], TRE_SIZE);

or

memcpy(lldev->tre_ring + lldev->tre_write_offset, &tre->tre_local[0],
							   TRE_SIZE);

or

memcpy(lldev->tre_ring + lldev->tre_write_offset,
	&tre->tre_local[0], 
	TRE_SIZE);

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
