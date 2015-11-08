From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 8 Nov 2015 17:00:00 -0500
Subject: [PATCH] dma: fix returnvar.cocci warnings
In-Reply-To: <563FC111.4060308@syse.no>
References: <alpine.DEB.2.10.1511080843100.2637@hadrien>
 <563FC111.4060308@syse.no>
Message-ID: <563FC5E0.8030301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/8/2015 4:39 PM, Daniel K. wrote:
> On 11/08/2015 07:45 AM, Julia Lawall wrote:
>>   Remove unneeded variable used to store return value.
>>
>> --- a/drivers/dma/qcom/hidma_ll.c
>> +++ b/drivers/dma/qcom/hidma_ll.c
>> @@ -567,14 +567,13 @@ int hidma_ll_resume(struct hidma_lldev *
>>
>>   static int hidma_ll_hw_start(struct hidma_lldev *lldev)
>>   {
>> -	int rc = 0;
>>   	unsigned long irqflags;
>>
>>   	spin_lock_irqsave(&lldev->lock, irqflags);
>>   	writel(lldev->tre_write_offset, lldev->trca + TRCA_DOORBELL_OFFSET);
>>   	spin_unlock_irqrestore(&lldev->lock, irqflags);
>>
>> -	return rc;
>> +	return 0;
>>   }
>>
>>   bool hidma_ll_isenabled(struct hidma_lldev *lldev)
>
> Seems rather pointless, what about 'static void ...' and dropping the
> return statement?
>
>
> Daniel K.
>

Yes, that's what I ended up doing. rc was forgotten there because I had 
to restructure code to use the issue_pending API.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
