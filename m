From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Mar 2012 17:05:44 +0100
Subject: [PATCH 05/10] ARM: ux500: db8500: list most devices in the
 snowball device tree
In-Reply-To: <201203141359.46109.arnd@arndb.de>
References: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
 <1331730306-11461-6-git-send-email-lee.jones@linaro.org>
 <201203141359.46109.arnd@arndb.de>
Message-ID: <CACRpkdanB7A55DV5TkADdWDmaySC4ZjZMgP74tF8WdN7gNQ7EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 2:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 14 March 2012, Lee Jones wrote:
>> + ? ? ? ? ? ? ? pmu {
>> + ? ? ? ? ? ? ? ? ? ? ? compatible = "arm,cortex-a9-pmu";
>> + ? ? ? ? ? ? ? ? ? ? ? interrupts = <7>;
>> + ? ? ? ? ? ? ? };
>> +
>> + ? ? ? ? ? ? ? rtc at 80154000 {
>> + ? ? ? ? ? ? ? ? ? ? ? compatible = "stericsson,db8500-rtc";
>> + ? ? ? ? ? ? ? ? ? ? ? reg = <0x80154000 0x1000>;
>> + ? ? ? ? ? ? ? ? ? ? ? interrupts = <18>;
>> + ? ? ? ? ? ? ? };
>> +
>> + ? ? ? ? ? ? ? gpio0: gpio at 8012e000 {
>> + ? ? ? ? ? ? ? ? ? ? ? compatible = "stericsson,db8500-gpio",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "stmicroelectronics,nomadik-gpio";
>> + ? ? ? ? ? ? ? ? ? ? ? reg = ?<0x8012e000 0x80>;
>> + ? ? ? ? ? ? ? ? ? ? ? interrupts = <119>;
>> + ? ? ? ? ? ? ? ? ? ? ? supports-sleepmode;
>> + ? ? ? ? ? ? ? ? ? ? ? gpio-controller;
>> + ? ? ? ? ? ? ? };
>
> Reading through it one more time, I realized that all the interrupt
> numbers are incorrect here and you fix them up one by one in the
> later patches. I think it would be more logical if you could just
> fix correct them here and then later just add the additional properties
> and enable the device.

Lee, fix up the IRQs and it's
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
