From: davidb@codeaurora.org (David Brown)
Date: Thu, 09 Jun 2011 16:31:06 -0700
Subject: [PATCH] msm: timer: compensate for timer shift in
	msm_read_timer_count
In-Reply-To: <1307626910.16418.1.camel@m0nster> (Daniel Walker's message of
	"Thu, 09 Jun 2011 06:41:50 -0700")
References: <1307591042-2369-1-git-send-email-johlstei@codeaurora.org>
	<1307626910.16418.1.camel@m0nster>
Message-ID: <8ya1uz2inut.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09 2011, Daniel Walker wrote:

>> diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
>> index 38b95e9..b3579fe 100644
>> --- a/arch/arm/mach-msm/timer.c
>> +++ b/arch/arm/mach-msm/timer.c
>> @@ -100,7 +100,7 @@ static cycle_t msm_read_timer_count(struct clocksource *cs)
>>  {
>>  	struct msm_clock *clk = container_of(cs, struct msm_clock, clocksource);
>>  
>> -	return readl(clk->global_counter);
>> +	return readl(clk->global_counter) >> clk->shift;
>>  }
>
> Could you comment in the code with something explaining what the shift
> is doing.

Probably best to describe this near msm_clock's definition (or
MSM_DGT_SHIFT), since it is a bit unclear what these values are.
A good (but short) description of how the shifts and even why.

The comment shouldn't be in the function body (CodingStyle, chapter 8).

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
