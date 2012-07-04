From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 4 Jul 2012 22:15:28 +0800
Subject: [PATCH 1/2] ARM: PRIMA2: add of_dev_auxdata table for I2C, SPI,
 UART and PINCTRL
In-Reply-To: <201207041310.49861.arnd@arndb.de>
References: <1341373400-15763-1-git-send-email-Barry.Song@csr.com>
 <201207041143.04942.arnd@arndb.de>
 <CAGsJ_4zU8p8sVweoUWbuggLfetUuD1Ooem=Ku5i1t9p8CX0hgA@mail.gmail.com>
 <201207041310.49861.arnd@arndb.de>
Message-ID: <CAGsJ_4yAc7M=TVVvLSQ7vAQTo8VmDdgiziK-CUOAiSa1HzfxNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/7/4 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 04 July 2012, Barry Song wrote:
>> > If it's about the pinctrl and clock parts, can't you just uses the
>> > generate names like "b0050000.uart" directly?
>>
>> yes. names like "b0050000.uart"  really work, and i have enabled and
>> tested names like that in clock driver.
>> but would people think them ugly?
>
> No, that's fine.
>
>> and what would the clock driver support two SoCs whose uarts have
>> different map base address?
>
> If they are different SoCs, then it would be likely be a different clock
> that is connected to the UART.
>
> A better solution is to use the new DT clock bindings to replace the
> clock lookup in the source code. Have a look at
> git://git.linaro.org/people/mturquette/linux.git to see how others
> do this in new kernels.

ok. thanks. recently i have missed many threads due to some other work issues.
i'll look into Rob Herring's "clk: add DT clock binding support".

>
>         Arnd

-barry
