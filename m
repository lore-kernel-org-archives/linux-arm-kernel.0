From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Mon, 1 Feb 2016 11:39:31 +0100
Subject: [PATCH v4 4/9] pinctrl: Add STM32 MCUs support
In-Reply-To: <2151471.Wut3mQ9SS7@wuerfel>
References: <1452773795-24216-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1452773795-24216-5-git-send-email-mcoquelin.stm32@gmail.com>
 <CACRpkdaBcP6fC5Oxn+d1WPdHq1FtwMkf8Ap5VDLQFg-5UwEBAw@mail.gmail.com>
 <2151471.Wut3mQ9SS7@wuerfel>
Message-ID: <CALszF6DTpcU8jFwA0HL8LpkxfO5ZOdFmpHBUxA7WfYgAj_uFhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-02-01 11:21 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 27 January 2016 14:16:32 Linus Walleij wrote:
>> On Thu, Jan 14, 2016 at 1:16 PM, Maxime Coquelin
>> <mcoquelin.stm32@gmail.com> wrote:
>>
>> > This patch adds pinctrl and GPIO support to STMicroelectronic's STM32
>> > family of MCUs.
>> >
>> > While it only supports STM32F429 for now, it has been designed to enable
>> > support of other MCUs of the family (e.g. STM32F746).
>> >
>> > Acked-by: Patrice Chotard <patrice.chotard@st.com>
>> > Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>>
>> This patch applied for kernel v4.6.
>>
>
> This breaks the kernel build, please revert:
>
> drivers/pinctrl/stm32/pinctrl-stm32.c:26:47: fatal error: dt-bindings/pinctrl/pinctrl-stm32.h: No such file or directory

Right, I missed to notify this dependency to Linus, sorry about that.
This dependency is no more needed, so I could just move the macros to
the driver side.

Note that I also noticed a breakage at build time due to field
renaming in gpio_chip structure (dev -> parent).

I propose to rebase the series and move the defines into the driver.
Is it ok for you?

Regards,
Maxime
