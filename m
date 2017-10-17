From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 17 Oct 2017 19:53:32 +0200
Subject: [PATCH v4 1/4] clocksource: stm32: convert driver to timer_of
In-Reply-To: <CA+M3ks5CBOXfQCMmUZnkVUNwSGCnzaqdzDZa9ap6NYgDTVspsw@mail.gmail.com>
References: <1506959513-16851-1-git-send-email-benjamin.gaignard@linaro.org>
 <1506959513-16851-2-git-send-email-benjamin.gaignard@linaro.org>
 <88c8f124-4cb1-a982-d4a2-c029ab0dcd2a@linaro.org>
 <CA+M3ks5CBOXfQCMmUZnkVUNwSGCnzaqdzDZa9ap6NYgDTVspsw@mail.gmail.com>
Message-ID: <28b1df26-8375-1a38-b918-39b80390ef7d@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/10/2017 19:34, Benjamin Gaignard wrote:
> 2017-10-17 19:09 GMT+02:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
>> On 02/10/2017 17:51, Benjamin Gaignard wrote:
>>> Convert driver to use timer_of helpers. This allow to remove
>>> custom proprietary structure.
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>>> ---
>>
>> [ ... ]
>>
>>> -     clockevents_config_and_register(&data->evtdev,
>>> -                                     DIV_ROUND_CLOSEST(rate, prescaler),
>>> -                                     0x1, max_delta);
>>> -
>>> -     ret = request_irq(irq, stm32_clock_event_handler, IRQF_TIMER,
>>> -                     "stm32 clockevent", data);
>>> -     if (ret) {
>>> -             pr_err("%pOF: failed to request irq.\n", np);
>>> -             goto err_get_irq;
>>> -     }
>>> +     clockevents_config_and_register(&to->clkevt,
>>> +                                     timer_of_period(to), 0x60, max_delta);
>>
>>
>> Why 0x1 -> 0x60 ?
> 
> Because if the min delta is too small it could generate too much interrupts
> and the system will not be able to catch all of them.

You did a change not related to what is described in the log.

Shame on you! 50 push-ups! Reply to this email when it is done.


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
