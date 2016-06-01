From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 1 Jun 2016 16:43:53 +0200
Subject: [PATCH 7/9] clocksource/drivers/cadence_ttc: Convert init
 function to return error
In-Reply-To: <20160601143622.GA3766@xsjsorenbubuntu>
References: <1464770093-12667-1-git-send-email-daniel.lezcano@linaro.org>
 <1464770093-12667-8-git-send-email-daniel.lezcano@linaro.org>
 <20160601143622.GA3766@xsjsorenbubuntu>
Message-ID: <574EF4A9.7010405@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2016 04:36 PM, S?ren Brinkmann wrote:
> Hi Daniel,

Hi Soren,

[ ... ]

>> +	err = clk_notifier_register(ttcce->ttc.clk,
>> +				    &ttcce->ttc.clk_rate_change_nb);
>> +	if (err) {
>>   		pr_warn("Unable to register clock notifier.\n");
>> +		return err;
>
> So far we handle this as warning only and move on, as the notifier is
> only needed when frequency scaling is enabled. And even then, the effect
> is usually just that timing is off.

Ok, I will fix it.

[ ... ]

>> -	static int initialized;
>> -	int clksel;
>> +	int clksel, ret;
>>   	u32 timer_width = 16;
>>
>> -	if (initialized)
>> -		return;
>> -
>> -	initialized = 1;
>> -
>
> This also changes behavior. We have multiple of these timer modules in
> our HW and we don't want them all to be used for time keeping. This
> construct made sure that we only use the first timer for which init is
> called leaving the others for non-OS purposes.

Ha, yes. My bad, this change was not supposed to be here.

Thanks for spotting this.

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
