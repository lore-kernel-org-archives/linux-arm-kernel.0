From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Tue, 2 May 2017 19:06:42 -0700
Subject: [PATCH 1/2] remoteproc: Introduce rproc_{start,stop}() functions
In-Reply-To: <20170503000205.GZ15143@minitux>
References: <1493758742-26148-1-git-send-email-spjoshi@codeaurora.org>
 <20170503000205.GZ15143@minitux>
Message-ID: <c3cce8b1-7c46-7a6f-0cde-d38400b4ea0b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/2017 05:02 PM, Bjorn Andersson wrote:
> On Tue 02 May 13:59 PDT 2017, Sarangdhar Joshi wrote:
>
>> In the context of recovering from crash,
>> rproc_trigger_recovery() does rproc_shutdown() followed
>> by rproc_boot(). The remoteproc resources are cleaned up
>> in rproc_shutdown() and immediately reallocated in
>> rproc_boot() which is an unnecessary overhead.
>>
>> Furthermore, we want the memory regions to be accessible
>> after stopping the remote processor, to be able to extract
>> the memory content for a coredump.
>>
>> The current patch factors out the code in rproc_boot() and
>
> "This patch factors..."
>
>> rproc_shutdown() path and introduces rproc_{start,stop}()
>> in order to avoid resource allocation overhead.
>>
>
> I think the result of the two patches looks good.
>
> But I would prefer if you splice them differently. If I read the patches
> correctly you should be able to introduce rproc_start()/stop() and move
> rproc_boot()/shutdown() over to use these in one patch and then in a
> second patch modify the behavior of the recovery.
>
> That way if one bisects any issues to either one we know if it was the
> refactoring or the modification of the recovery behavior.

Yes, got your point. I will split it into two separate patches.

Regards,
Sarang

>
> Regards,
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
