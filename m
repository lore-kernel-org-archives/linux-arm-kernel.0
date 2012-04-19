From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 19 Apr 2012 16:02:02 +0200
Subject: [PATCH 10/17][V2] ARM: OMAP3: cpuidle - remove the 'valid' field
In-Reply-To: <874nss8pn9.fsf@ti.com>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
 <1333570371-1389-11-git-send-email-daniel.lezcano@linaro.org>
 <874nss8pn9.fsf@ti.com>
Message-ID: <4F901ADA.1020302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2012 01:13 AM, Kevin Hilman wrote:
> Daniel Lezcano<daniel.lezcano@linaro.org>  writes:
>
>> With the previous changes all the states are valid, except
>> the last state which can be handled by decreasing the number
>> of states.
>>
>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>> Reviewed-by: Jean Pihet<j-pihet@ti.com>
>> ---

[ ... ]

>>   	if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583)) {
>> -		cx->valid = 0;
>> +		drv->state_count = OMAP3_NUM_STATES - 1;
>>   		pr_warn("%s: core off state C7 disabled due to i583\n",
>>   			__func__);
>
> I'm not too particular about this one, but it might be cleaner to just
> remove this check all together.  This errata already has a check in
> next_valid_state() so strictly speaking, it's not needed here.

Yes, right. Thanks for pointing this.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
