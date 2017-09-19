From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 19 Sep 2017 17:54:37 +0200
Subject: [PATCH 1/2] clocksource: stm32: rework driver to use only one
 timer
In-Reply-To: <CA+M3ks45pUwv=dL6Gd6=Nvm1y5zRvtsFEU1bFoHht0xUDc3UVw@mail.gmail.com>
References: <1505375812-19037-1-git-send-email-benjamin.gaignard@linaro.org>
 <1505375812-19037-2-git-send-email-benjamin.gaignard@linaro.org>
 <9e5cae53-0a57-f2e9-cbb1-dde484619fca@linaro.org>
 <CA+M3ks45pUwv=dL6Gd6=Nvm1y5zRvtsFEU1bFoHht0xUDc3UVw@mail.gmail.com>
Message-ID: <cb440fab-b2a9-13ff-6f8a-4bce2eb2bc54@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/09/2017 09:59, Benjamin Gaignard wrote:
> 2017-09-18 23:30 GMT+02:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
>> On 14/09/2017 09:56, Benjamin Gaignard wrote:
>>> Rework driver code to use only one timer for both clocksource
>>> and clockevent.
>>> This patch also forbids to use 16 bits timers because they are
>>> not enough accurate.
>>> Do some clean up in structures and functions names too.
>>>
>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>>
>> Hi Benjamin,
>>
>> I have a few comments below. Can you when reposting split this patch
>> into smaller changes ?
> 
> Not so easy because I change the way of how the hardware is used to be able
> to provide clocksource and clockevent on the same hardware block.
> 
>>
>> Also, can you consider using the timer-of API ?
> 
> Is it just about using TIMER_OF_DECLARE ? or do you have something
> else in mind ?

It is something else, see commit dc11bae785.


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
