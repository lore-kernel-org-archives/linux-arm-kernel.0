From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 24 Mar 2014 18:15:02 +0100
Subject: [PATCH 1/2] ARM: clps711x: Add cpuidle driver
In-Reply-To: <1395679441.129942365@f386.i.mail.ru>
References: <1395467076-29462-1-git-send-email-shc_work@mail.ru>
 <53305094.8010008@linaro.org> <1395679441.129942365@f386.i.mail.ru>
Message-ID: <53306816.1090809@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/2014 05:44 PM, Alexander Shiyan wrote:
> Mon, 24 Mar 2014 16:34:44 +0100 ?? Daniel Lezcano <daniel.lezcano@linaro.org>:
>> On 03/22/2014 06:44 AM, Alexander Shiyan wrote:
>>> Add cpuidle support for ARM Cirrus Logic CLPS711X CPUs.
>>> This CPU has an unique internal register and write to this location
>>> will put the system into the Idle State by halting the clock to the
>>> processor until an interrupt is generated.
>>>
>>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>>> ---
> ...
>>> +static struct cpuidle_driver clps711x_idle_driver = {
>>> +	.name		= CLPS711X_CPUIDLE_NAME,
>>> +	.owner		= THIS_MODULE,
>>> +	.states[0]	= {
>>> +		.name		= "HALT",
>>> +		.desc		= "CLPS711X HALT",
>>> +		.enter		= clps711x_cpuidle_halt,
>>> +		.exit_latency	= 1,
>>
>> Did you forget target_residency ? Or just not defined it as it is 0 ?
>
> Yes, zero value.

Ok, thanks. The driver looks good. I will pick it for 3.16.

Thanks
   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
