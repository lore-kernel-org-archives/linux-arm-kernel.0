From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Thu, 5 Jan 2017 13:58:42 -0800
Subject: [PATCH v2] soc: ti: Drop wait from wkup_m3_rproc_boot_thread
In-Reply-To: <482666d0-7915-ead2-c514-2651a4967a43@ti.com>
References: <1483486889-3662-1-git-send-email-spjoshi@codeaurora.org>
 <482666d0-7915-ead2-c514-2651a4967a43@ti.com>
Message-ID: <927ed4ce-b2a6-699d-9a35-795633484b82@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2017 01:08 PM, Suman Anna wrote:
> On 01/03/2017 05:41 PM, Sarangdhar Joshi wrote:
>> The function wkup_m3_rproc_boot_thread waits for
>> asynchronous firmware loading to parse the resource table
>> before calling rproc_boot(). However, as the resource table
>> parsing has been moved to rproc_boot(), there's no need to
>> wait for the asynchronous firmware loading completion.
>> So, drop this.
>>
>> CC: Dave Gerlach <d-gerlach@ti.com>
>> CC: Suman Anna <s-anna@ti.com>
>> CC: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
>
> + Tony and Santosh, not sure who is picking up the wkup_m3 related patches.
>
> Only one minor nit, I would prefer the patch subject to start with
> soc: ti: wkup_m3_ipc: ....

Sure, will update the subject line.

Regards,
Sarang

>
> Tested-by: Suman Anna <s-anna@ti.com>
>
> regards
> Suman
>
>> ---
>>
>> This patch seems to be doing an independent clean up now. Hence
>> removing it from the series.
>>
>>  drivers/soc/ti/wkup_m3_ipc.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
>> index 8823cc8..8bfa44b 100644
>> --- a/drivers/soc/ti/wkup_m3_ipc.c
>> +++ b/drivers/soc/ti/wkup_m3_ipc.c
>> @@ -370,8 +370,6 @@ static void wkup_m3_rproc_boot_thread(struct wkup_m3_ipc *m3_ipc)
>>  	struct device *dev = m3_ipc->dev;
>>  	int ret;
>>
>> -	wait_for_completion(&m3_ipc->rproc->firmware_loading_complete);
>> -
>>  	init_completion(&m3_ipc->sync_complete);
>>
>>  	ret = rproc_boot(m3_ipc->rproc);
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
