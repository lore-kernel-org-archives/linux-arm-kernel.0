From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 Nov 2017 23:21:44 +0100
Subject: [PATCH] pinctrl: armada-37xx: remove unused variable
In-Reply-To: <CAK8P3a2eL_PDic4J_5oMNeLBYU1698TsCBbDaWLxuP+wS30FzA@mail.gmail.com>
References: <20171102142932.774199-1-arnd@arndb.de>
 <CACRpkdbAfBXMbgiG3avQ7CUwZdoY1_qGJt-tq-sDLoR4z0zOew@mail.gmail.com>
 <CAK8P3a2eL_PDic4J_5oMNeLBYU1698TsCBbDaWLxuP+wS30FzA@mail.gmail.com>
Message-ID: <CACRpkdYzT9Gn747gj4U5inBDFBk30mtENctSbuBRYkjxHpNv1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 3, 2017 at 10:11 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Nov 3, 2017 at 8:46 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Thu, Nov 2, 2017 at 3:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>>> A cleanup left behind a temporary variable that is now unused:
>>>
>>> drivers/pinctrl/mvebu/pinctrl-armada-37xx.c: In function 'armada_37xx_irq_startup':
>>> drivers/pinctrl/mvebu/pinctrl-armada-37xx.c:693:20: error: unused variable 'chip' [-Werror=unused-variable]
>>>
>>> This removes the declarations as well.
>>>
>>> Fixes: 3ee9e605caea ("pinctrl: armada-37xx: Stop using struct gpio_chip.irq_base")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> It is used on the head of development, so it's fixed in -next.
>>
>> Is it such a big issue for v4.14 that you think I should send it
>> to Torvalds as a fix at this point or can I just leave it?
>
> I'm confused. The build warning showed up in linux-next yesterday after
> 3ee9e605caea got merged, which removes the user of that variable.
> In v4.14 it is still used.

I just confused myself by trying to apply it to the pin control
tree while the refactorings were in the GPIO tree.

Applied it to the right tree now, thanks!

Linus Walleij
