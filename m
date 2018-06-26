From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 26 Jun 2018 10:27:21 +0200
Subject: [PATCH 1/9] clk: davinci: psc-dm365: use two lookup entries for
 the aemif clock
In-Reply-To: <c8d28664-e0fb-5a02-3c5b-b78684f87648@lechnology.com>
References: <20180625152920.11549-1-brgl@bgdev.pl>
 <20180625152920.11549-2-brgl@bgdev.pl>
 <241fed6e-b414-feac-8e6c-39713c5e665e@lechnology.com>
 <CAMRc=MdTdoL9qsrMAxhCTaQM7HGrAPpTVjDuHQ81Q5O-QMNcYQ@mail.gmail.com>
 <c8d28664-e0fb-5a02-3c5b-b78684f87648@lechnology.com>
Message-ID: <CAMRc=MfDmQxiy+jX4kW1A8vvP4xVXjKDo8VpgRZ-2AsTNik-0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-06-25 18:06 GMT+02:00 David Lechner <david@lechnology.com>:
> On 06/25/2018 11:01 AM, Bartosz Golaszewski wrote:
>>
>> 2018-06-25 17:53 GMT+02:00 David Lechner <david@lechnology.com>:
>>>
>>> On 06/25/2018 10:29 AM, Bartosz Golaszewski wrote:
>>>>
>>>>
>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>
>>>> We want to be able to get the clock both from the board file by its
>>>> con_id and from the aemif driver by dev_id.
>>>
>>>
>>>
>>> What about the other SoCs? Don't they need this change as well?
>>>
>>
>> So I double checked and turns out I missed one other board that's
>> affected by this series and calls clk_get() from machine code:
>> dm644x-evm.
>>
>> I'll fix it in v2.
>
>
> The ti-aemif platform driver also does clk_get(). Don't you need
> lookups to make that work as well? For example, DA830 doesn't have
> a clock lookup for aemif at all.
>

This seems like a bug: in arch/arm/mach-davinci/aemif.c in current
mainline we do call clk_get() for 'aemif' and it's called indirectly
from board-da830-evm.c via davinci_aemif_setup().

I'll address this too in v2.

Bart
