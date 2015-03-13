From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 13 Mar 2015 22:22:37 +0100
Subject: [PATCH 3/6] ARM64: cpuidle: Replace cpu_suspend by the common
 ARM/ARM64 function
In-Reply-To: <20150313182102.GS30671@e104818-lin.cambridge.arm.com>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org>
 <1425385777-14766-4-git-send-email-daniel.lezcano@linaro.org>
 <20150313182102.GS30671@e104818-lin.cambridge.arm.com>
Message-ID: <5503551D.2020202@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2015 07:21 PM, Catalin Marinas wrote:
> On Tue, Mar 03, 2015 at 01:29:34PM +0100, Daniel Lezcano wrote:
>> Call the common ARM/ARM64 'arm_cpuidle_suspend' instead of cpu_suspend function
>> which is specific to ARM64.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/cpuidle/cpuidle-arm64.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
>> index 39a2c62..0cea244 100644
>> --- a/drivers/cpuidle/cpuidle-arm64.c
>> +++ b/drivers/cpuidle/cpuidle-arm64.c
>> @@ -49,7 +49,7 @@ static int arm64_enter_idle_state(struct cpuidle_device *dev,
>>   		 * call the CPU ops suspend protocol with idle index as a
>>   		 * parameter.
>>   		 */
>> -		ret = cpu_suspend(idx);
>> +		arm_cpuidle_suspend(idx);
>
> Nitpick: why don't we just rename the arm one cpuidle_suspend()?

I don't have a strong opinion on that. Actually, the cpuidle_ prefix is 
used by the arch agnostic code in drivers/cpuidle/cpuidle.c.

If Rafael agrees on changing it to this function name, I am ok also.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
