From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 07 Apr 2013 22:52:44 +0200
Subject: [PATCH 7/9] intel: cpuidle: remove stop/start critical timings
In-Reply-To: <3375360.P4DAA9Jd5Y@vostro.rjw.lan>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
 <1364991322-20585-7-git-send-email-daniel.lezcano@linaro.org>
 <3375360.P4DAA9Jd5Y@vostro.rjw.lan>
Message-ID: <5161DC9C.3020703@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2013 12:31 AM, Rafael J. Wysocki wrote:
> On Wednesday, April 03, 2013 02:15:20 PM Daniel Lezcano wrote:
>> The start/stop_critical_timings are called from arch/x86/kernel/process.c
>> in the cpu_idle loop function.
>>
>> Remove the ones in the cpuidle driver.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> For this one I need an ACK from Len.
> 
> Len, any objections?


Len ? ping ...

>> ---
>>  drivers/idle/intel_idle.c |    3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
>> index 5d66750..c99c31e 100644
>> --- a/drivers/idle/intel_idle.c
>> +++ b/drivers/idle/intel_idle.c
>> @@ -339,7 +339,6 @@ static int intel_idle(struct cpuidle_device *dev,
>>  	if (!(lapic_timer_reliable_states & (1 << (cstate))))
>>  		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
>>  
>> -	stop_critical_timings();
>>  	if (!need_resched()) {
>>  
>>  		__monitor((void *)&current_thread_info()->flags, 0, 0);
>> @@ -348,8 +347,6 @@ static int intel_idle(struct cpuidle_device *dev,
>>  			__mwait(eax, ecx);
>>  	}
>>  
>> -	start_critical_timings();
>> -
>>  	if (!(lapic_timer_reliable_states & (1 << (cstate))))
>>  		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
>>  
>>


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

  * English - detected
  * English
  * French

  * English
  * French

 <javascript:void(0);> <#>
