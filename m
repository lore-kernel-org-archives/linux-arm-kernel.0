From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 May 2013 13:55:56 +0200
Subject: [PATCH 31/39] ARM: u300: add syscon node
In-Reply-To: <14733989.vf3LkZC316@wuerfel>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
 <1369991954-17406-32-git-send-email-linus.walleij@stericsson.com>
 <14733989.vf3LkZC316@wuerfel>
Message-ID: <CACRpkdaPXLuyXWSrMipZs6L973-8C=iaeOWYZ_zCKCSZNn2cQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 12:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 31 May 2013 11:19:06 Linus Walleij wrote:

>>  compatible="stericsson,u300";
>>
>> +Required node: syscon
>> +This contains the system controller.
>> +- compatible: must be "stericsson,u300-syscon".
>> +- reg: the base address and size of the system controller.
>> +
>
> Any reason why you are not making it compatible with "syscon", to use
> the drivers/mfd/syscon.c driver?

For the first lookup at irq_init() we cannot use it.

This is because that needs to be initialized at irq_init() time
to set up the clocks, which are needed by the interrupt controller,
it cannot use device matching, as the platform devices are not
probed yet.

However I can make it compatible for the board power snippet
to make use of it for sure.

But I find no good examples in the kernel on how to grab a
referenced syscon node and use the regmap API to read/write
registers :-(

Dong: do you have some example to point at for this?

Yours,
Linus Walleij
