From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Jun 2013 22:24:25 +0200
Subject: [PATCH 31/39] ARM: u300: add syscon node
In-Reply-To: <14733989.vf3LkZC316@wuerfel>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
 <1369991954-17406-32-git-send-email-linus.walleij@stericsson.com>
 <14733989.vf3LkZC316@wuerfel>
Message-ID: <CACRpkdYWU2g0iK=kJO2E-Lj_0MRszUOVbfgFZN6s33KE8v02oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 12:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:

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

I've proposed a patch for this and also altered the board
power code to make use of it (it's the only instance that can
use the syscon regmap do do its work so far).

Yours,
Linus Walleij
