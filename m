From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 29 Oct 2013 10:46:55 -0700
Subject: [PATCH v5 0/3] ARM: S5PV210: move to common clk framework
In-Reply-To: <526FD849.9050000@samsung.com>
References: <1380027009-2239-1-git-send-email-m.krawczuk@partner.samsung.com>
 <5264425E.4040301@samsung.com> <20131021121605.11944.74007@quantum>
 <1823897.8rOixkM4PW@amdc1227> <526FD849.9050000@samsung.com>
Message-ID: <CAPtuhTgQ1M7Z3PCFCPVTKT-uY+JE6cGSdbEfJrLMmbRr+C9MZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 8:46 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> On 10/29/13 04:42, Tomasz Figa wrote:
>>
>> Hi Kukjin, Mike,
>>
>> On Monday 21 of October 2013 05:16:05 Mike Turquette wrote:
>>>
>>> Quoting Kukjin Kim (2013-10-20 13:51:42)
>>>>
>>>> On 10/20/13 01:03, Tomasz Figa wrote:
>>>>>
>>>>> Hi Mike, Kukjin, Rafael,
>>>>>
>>>>> On Tuesday 24 of September 2013 14:50:06 Mateusz Krawczuk wrote:
>>>>>>
>>>>>> This patch series is the new s5pv210 clock implementation
>>>>>> (using common clk framework).
>>>>>>
>>>>>> This implementation is compatible with device tree definition and
>>>>>> board
>>>>>> files.
>>>>>>
>>>>>> This patch series is based on linux-next and has been tested on goni
>>>>>> and
>>>>>> aquila
>>>>>> boards using board file.
>>>>>>
>>>>>> Since v4:
>>>>>> Corrected mux flags for finpll.
>>>>>>
>>>>>> Since v3:
>>>>>>
>>>>>> Replace s5pv210_clk_register_finpll, by creating mux finpll
>>>>>> with xusbxti and xxti as parrents.
>>>>>>
>>>>>>
>>>>>> Mateusz Krawczuk (3):
>>>>>>     clk: samsung: Add clock driver for s5pc110/s5pv210
>>>>>>     Cpufreq: s5pv210 cpufreq fixes for CCF
>>>>>>     ARM: s5pv210: Migrate clock handling to Common Clock Framework
>>>>>>
>>>>>>    .../bindings/clock/samsung,s5pv210-clock.txt       |  75 +++
>>>>>>    arch/arm/mach-s5pv210/Kconfig                      |   9 +
>>>>>>    arch/arm/mach-s5pv210/Makefile                     |   4 +-
>>>>>>    arch/arm/mach-s5pv210/common.c                     |  17 +
>>>>>>    arch/arm/mach-s5pv210/common.h                     |  10 +
>>>>>>    arch/arm/mach-s5pv210/mach-goni.c                  |   2 +-
>>>>>>    arch/arm/mach-s5pv210/mach-smdkv210.c              |   2 +-
>>>>>>    arch/arm/plat-samsung/Kconfig                      |   2 +-
>>>>>>    drivers/clk/samsung/Makefile                       |   3 +
>>>>>>    drivers/clk/samsung/clk-s5pv210.c                  | 673
>>>>>> +++++++++++++++++++++ drivers/cpufreq/s5pv210-cpufreq.c
>>>>>>    |   6 +-
>>>>>>    include/dt-bindings/clock/samsung,s5pv210-clock.h  | 224 +++++++
>>>>>>    12 files changed, 1019 insertions(+), 8 deletions(-)
>>>>>>    create mode 100644
>>>>>> Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.txt
>>>>>> create mode 100644 drivers/clk/samsung/clk-s5pv210.c
>>>>>>    create mode 100644
>>>>>> include/dt-bindings/clock/samsung,s5pv210-clock.h
>>>>>
>>>>>
>>>>> I believe this series is reasonable to be applied. Could we agree on
>>>>> the tree it would go through and get all tne required acks?
>>>>>
>>>>> Best regards,
>>>>> Tomasz
>>>>
>>>>
>>>> I agree.
>>>>
>>>> Mike, how do you think the common clk stuff for s5pv210?
>>>
>>>
>>> Clock code looks good to me. Which tree do you want to take it through?
>>
>>
>> Seems like we just missed another kernel release. It's a bit sad that it's
>> happening so often for Samsung patches...
>>
>
> Tomasz, sorry about that, I couldn't end up the stuff before attending ARM
> Kernel Summit, but in my opinion, this series would be merged for upcoming
> merge window via clk tree if Mike is fine because there is no conflicts with
> Samsung tree.
>
> Mike, how do you think? If you're OK, please pick this into your tree with
> my ack.

I'll pull this in later today with your Ack.

Regards,
Mike

>
> Thanks,
> Kukjin
