From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 30 Jan 2013 13:59:57 -0800
Subject: [PATCH] ARM:mach-msm: seting tail NUL after strncpy
In-Reply-To: <8ya4nhywe2o.fsf@huya.qualcomm.com>
References: <5108A913.6080304@asianux.com> <8ya4nhywe2o.fsf@huya.qualcomm.com>
Message-ID: <510997DD.8080600@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/13 13:33, David Brown wrote:
> Chen Gang <gang.chen@asianux.com> writes:
>
>>   temp need NUL terminated, or next ptr may cause issue.
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> ---
>>  arch/arm/mach-msm/clock-debug.c |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/mach-msm/clock-debug.c
>> b/arch/arm/mach-msm/clock-debug.c
>> index 4886404..bdca900 100644
>> --- a/arch/arm/mach-msm/clock-debug.c
>> +++ b/arch/arm/mach-msm/clock-debug.c
>> @@ -105,6 +105,8 @@ int __init clock_debug_add(struct clk *clock)
>>  		return -ENOMEM;
>>
>>  	strncpy(temp, clock->dbg_name, ARRAY_SIZE(temp)-1);
>> +	temp[ARRAY_SIZE(temp)-1] = '\0';
>> +
>>  	for (ptr = temp; *ptr; ptr++)
> I believe that Stephen Boyd is putting some significant work into this
> code.  Stephen, can you see if this bug is still in your current
> version of the code, and make sure that it is fixed there?
>

This entire file is deleted in my set of patches that moves the current
MSM clock code to the common clock framework.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
