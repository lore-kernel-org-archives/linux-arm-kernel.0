From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 30 Sep 2015 23:40:33 +0200
Subject: [PATCH 0/4] memory: pl17x: add support of PL175 and PL176
 controllers
In-Reply-To: <560B028D.1040402@mleia.com>
References: <1443459043-24144-1-git-send-email-vz@mleia.com>
 <CAGhQ9VzUwkkXqRQ-WZ_cjRKCrE=co1LNwFaQfGmBbuEOsVZ6_A@mail.gmail.com>
 <560B028D.1040402@mleia.com>
Message-ID: <CAGhQ9Vxbz1dGacYay6qM80_ysgR6TVKeJQDX5W0W0D6q7qOyvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 September 2015 at 23:28, Vladimir Zapolskiy <vz@mleia.com> wrote:
> Hi Joachim,
>
> On 29.09.2015 23:39, Joachim Eastwood wrote:
>> Hi Vladimir,
>>
>> On 28 September 2015 at 18:50, Vladimir Zapolskiy <vz@mleia.com> wrote:
>>> The change adds support of ARM PrimeCell PL175 MPMC and PL176 MPMC,
>>> the static memory controllers on devices are similar to one found on
>>> ARM PrimeCell PL172, add support to the existing driver.
>>>
>>> Vladimir Zapolskiy (4):
>>>   memory: pl172: correct MPMC peripheral ID register bits
>>>   memory: pl172: add ARM PrimeCell PL175 MPMC support
>>>   memory: pl172: add ARM PrimeCell PL176 MPMC support
>>>   doc: dt: arm,pl172: add description of PL175 and PL176 controllers
>>
>> Changes look good to me.
>>
>> What LPC32xx board did you test this on, btw?
>
> I tested PL175 on Timll Devkit3250 board with 4Mb NOR.

Okey, good.

I have now tested your changes on my two lpc18xx boards here and
everything seems fine.


>> Also if you have added the controller to lpc32xx.dtsi it would be
>> great if you could also submit those changes to the lpc32xx
>> maintainer.
>>
>
> Right, this is in my plans. To avoid any mess in the controller driver,
> mach-lpc32xx must be converted to common clock framework firstly, that's
> what I'm doing at the moment, then I'll send the corresponding EMC
> updates in lpc32xx.dtsi.

Nice to hear that you are working on a clk driver lpc32xx!


> By the way I've tested your clocksource driver on LPC32xx and it works
> fine, but again clean switching to it is not possible until LPC32xx
> clocks are out of the common clock framework.

ah, good, then we could eventually get rid of the timer driver in mach-lpc32xx.


regards,
Joachim Eastwood
