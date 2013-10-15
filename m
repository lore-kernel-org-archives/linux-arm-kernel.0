From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 15 Oct 2013 08:16:31 +0200
Subject: [PATCH V2 1/2] ARM: at91: cpuidle: convert to platform driver
In-Reply-To: <20131014232539.GM11420@ns203013.ovh.net>
References: <1381781721-11866-1-git-send-email-daniel.lezcano@linaro.org>
 <20131014232539.GM11420@ns203013.ovh.net>
Message-ID: <525CDDBF.3060500@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2013 01:25 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 22:15 Mon 14 Oct     , Daniel Lezcano wrote:
>> Using the platform driver model is a good way to separate the cpuidle specific
>> code from the low level pm code. It allows to remove the dependency between
>> these two components.
>>
>> The platform_device is located in the pm code and a 'set' function has been
>> added to set the standby function from the AT91_SOC_START initialization
>> function. Each SoC with a cpuidle driver will set the standby function in the
>> platform_data field at init time. Then pm code will register the cpuidle
>> platform device.
>>
>> The cpuidle driver will register the platform_driver and use the device's
>> platform_data as a standby callback in the idle path.
>
> I've an issue while re-reading the pm code
>
> we use the xx_standby for 2 drivers cpuidle and suspend/resume
>
> with all the cpu_is_xxxx
>
> so you need to do one more step in this series
> by cleaning up the PM_SUSPEND_STANDBY to as you put a function pointer with
> the correct one in pm.c

I was plannning to send it as a separate patch.

> otherwise looks good

Cool. Thanks for the review.

   -- Daniel

[ ... ]

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
