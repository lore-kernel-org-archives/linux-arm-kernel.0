From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 1 May 2016 00:38:37 -0400
Subject: [PATCH V17 1/3] dmaengine: qcom_hidma: implement lower level
 hardware interface
In-Reply-To: <572264BF.5010703@codeaurora.org>
References: <1460384473-5775-1-git-send-email-okaya@codeaurora.org>
 <1460384473-5775-2-git-send-email-okaya@codeaurora.org>
 <20160426032805.GA2274@localhost> <571F8397.5000803@codeaurora.org>
 <20160426162441.GJ2274@localhost> <572264BF.5010703@codeaurora.org>
Message-ID: <5725884D.5040608@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/28/2016 3:30 PM, Sinan Kaya wrote:
> On 4/26/2016 12:24 PM, Vinod Koul wrote:
>>> +
>>>> +       dev_err(lldev->dev, "error 0x%x, resetting...\n",
>>>> +               cause);
>> right justify this and others as well please
>>
> 
> Can you please point me to other lines that need to be fixed please? It looks good
> to me though it doesn't to you. I want to make sure that I'm touching the right ones.
> You seem to prefer a tab following an open parenthesis in your code. Do you want me to
> add a tab for every single multi-line such that it comes this for instance?
> 
> 
> 	ret = readl_poll_timeout(lldev->trca + HIDMA_TRCA_CTRLSTS_REG, val,
> 				 	HIDMA_CH_STATE(val) == HIDMA_CH_DISABLED, 
> 					1000, 10000); 
> 
> instead of
> 
> 	ret = readl_poll_timeout(lldev->trca + HIDMA_TRCA_CTRLSTS_REG, val,
> 				 HIDMA_CH_STATE(val) == HIDMA_CH_DISABLED, 1000,
> 				 10000); 
> 
> 
>>>>>>>> +int hidma_ll_resume(struct hidma_lldev *lldev)
>>>>>>>> +{
>>>>>>>> +	return hidma_ll_enable(lldev);
>>>>>>>> +}
>>>>>>
>>>>>> why do we need this empty function, use hidma_ll_enable.
>>>>
>>>> hidma_ll_enable is a common function that gets called from multiple places. 
>>>> hidma_ll_resume and hidma_ll_pause is used by the OS interface for pausing
>>>> and resuming the DMA channel. 
>> is there a reason why we can't have the code in resume and that being called
>> internally as well as externally?
>>
> 
> I'll have the pause code in OS layer call hidma_ll_enable and get rid of pause
> function here.
> 


I posted v18 along with all the style corrections and other things you asked me.
Please let me know if there is anything outstanding.



-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
