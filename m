From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 20 Jun 2016 11:24:09 +0200
Subject: [PATCH V2 25/63] clocksource/drivers/mxs_timer: Convert init
 function to return error
In-Reply-To: <20160620091506.GO9711@e106497-lin.cambridge.arm.com>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
 <1466112442-31105-26-git-send-email-daniel.lezcano@linaro.org>
 <20160620091506.GO9711@e106497-lin.cambridge.arm.com>
Message-ID: <5767B639.2090102@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2016 11:15 AM, Liviu Dudau wrote:
> On Thu, Jun 16, 2016 at 11:26:44PM +0200, Daniel Lezcano wrote:
>> The init functions do not return any error. They behave as the following:
>>
>>    - panic, thus leading to a kernel crash while another timer may work and
>>         make the system boot up correctly
>>
>>    or
>>
>>    - print an error and let the caller unaware if the state of the system
>>
>> Change that by converting the init functions to return an error conforming
>> to the CLOCKSOURCE_OF_RET prototype.
>>
>> Proper error handling (rollback, errno value) will be changed later case
>> by case, thus this change just return back an error or success in the init
>> function.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

Actually, this is fixed for mxs [1] (sorry the Cc script is misbehaving).

> This patch needs rework as it is changing (incompletely) two files that have different
> maintainers.

Let me resend the mps2 driver.

Thanks.

   -- Daniel

[1] http://www.spinics.net/lists/kernel/msg2281624.html


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
