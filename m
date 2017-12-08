From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri, 8 Dec 2017 15:19:24 +0100
Subject: [PATCH v9 4/6] clocksource: stm32: add clocksource support
In-Reply-To: <810270c4-c6b4-ee05-2481-ced52f7d2685@linaro.org>
References: <20171208113250.359-1-benjamin.gaignard@st.com>
 <20171208113250.359-5-benjamin.gaignard@st.com>
 <ac396fdb-1658-d2f3-bd92-b2b9fe04f201@linaro.org>
 <CA+M3ks6uWUQqD-c_FWETDLp097AfUEVs1srpH_C7kK-X8ADQ1Q@mail.gmail.com>
 <810270c4-c6b4-ee05-2481-ced52f7d2685@linaro.org>
Message-ID: <CA+M3ks7DQ7xH8WyKkwjU+=XHFjAE=N7hvsN8Pcxpkz1L5LHqKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-12-08 15:08 GMT+01:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
> On 08/12/2017 15:04, Benjamin Gaignard wrote:
>> 2017-12-08 14:46 GMT+01:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
>>> On 08/12/2017 12:32, Benjamin Gaignard wrote:
>>>> The stm32 timer hardware is currently only used as a clock event device,
>>>> but it can be utilized as a clocksource as well.
>>>>
>>>> Implement this by enabling the free running counter in the hardware block
>>>> and converting the clock event part from a count down event timer to a
>>>> comparator based timer.
>>>
>>>
>>> Split this patch in two:
>>>  - periodic support
>>>  - clocksource support
>>
>> No because the way of implementing periodic support depend of how clocksource
>> part is implemented on the hardware.
>> I don't want to code functions that I will completely remove just after
>
> Sorry, I don't get it. Can you elaborate please ?

To add clocksource support I use the counter part of the hardware
which was before
used for clockevent and make clockevent use the comparator instead.
So implementing periodic on counter side of the hardware is a waste of
time because
I will to remove right after

>
>
> --
>  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
