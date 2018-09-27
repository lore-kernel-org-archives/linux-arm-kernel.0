From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 27 Sep 2018 12:00:35 +0200
Subject: [PATCH] clocksource/drivers/timer-atmel-pit: properly handle
 error cases
In-Reply-To: <d2b356f9-6a29-0ce2-c511-ac1aff8e91ca@microchip.com>
References: <20180425101439.28908-1-alexandre.belloni@bootlin.com>
 <20180501083626.GE27619@mai>
 <d2b356f9-6a29-0ce2-c511-ac1aff8e91ca@microchip.com>
Message-ID: <f5f48a3e-233d-99e8-bd8c-978b4ca2a7cc@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/09/2018 14:38, Nicolas Ferre wrote:
> Daniel,
> 
> On 01/05/2018 at 10:36, Daniel Lezcano wrote:
>> On Wed, Apr 25, 2018 at 12:14:39PM +0200, Alexandre Belloni wrote:
>>> smatch now reports a possible leak:
>>>
>>> smatch warnings:
>>> drivers/clocksource/timer-atmel-pit.c:183 at91sam926x_pit_dt_init()
>>> warn: possible memory leak of 'data'
>>>
>>> Ensure data is freed before exiting with an error.
>>>
>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>>> ---
>>
>> Applied for 4.17-rc
> 
> We don't see it in Mainline as of 4.19-rc neither in linux-next. Has it
> been forgotten?

Yes, my bad. I thought it was merge in tip:timers/urgent

Let me resend another PR for 4.19-rc and Cc stable@




-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
