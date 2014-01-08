From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 8 Jan 2014 09:36:14 +0530
Subject: [PATCH v3 0/2] gpio: davinci: reuse for keystone arch
In-Reply-To: <52CC3EDC.7070404@ti.com>
References: <1387885284-8119-1-git-send-email-grygorii.strashko@ti.com>
 <52CC3EDC.7070404@ti.com>
Message-ID: <52CCCEB6.9050006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 January 2014 11:22 PM, Santosh Shilimkar wrote:
> Sekhar,
> 
> On Tuesday 24 December 2013 06:41 AM, Grygorii Strashko wrote:
>> This series is intended to update Davinci GPIO driver and reuse
>> it for Keystone SoCs, because Keystone uses the similar GPIO IP like Davinci.
>> Keystone GPIO IP: supports:
>> - up to 32 GPIO lines;
>> - only unbanked irqs;
>>
>> See Documentation:
>> Keystone - http://www.ti.com/lit/ug/sprugv1/sprugv1.pdf
>>
>> This series based on:
>> https://git.kernel.org/cgit/linux/kernel/git/nsekhar/linux-davinci.git/log/?h=v3.14/gpio
>>
>> Changes in v3:
>> - fixed code, changed by mistake; fixed sparse warning 
>> Changes in v2:
>> - minor comments applied, no functional changes
>>
>> v2: https://lkml.org/lkml/2013/12/18/135
>> v1: https://lkml.org/lkml/2013/12/12/366
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Alexandre Courbot <gnurou@gmail.com>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>
>> Grygorii Strashko (2):
>>   gpio: davinci: don't create irq_domain in case of unbanked irqs
>>   gpio: davinci: reuse for Keystone SoC
>>
>>  .../devicetree/bindings/gpio/gpio-davinci.txt      |    4 +-
>>  drivers/gpio/gpio-davinci.c                        |   82 ++++++++++++++------
>>  2 files changed, 61 insertions(+), 25 deletions(-)
>>
> Have you picked up the $subject series in your queue ?

Not yet, at least on the new compatible introduction, I need an ack from
DT folks.

I am happy with the patches though and have tested them as well, In case
I do not get an ack from 2/2 in time, I can at least send 1/2 for
inclusion after my first gpio pull request to ARM-SoC gets pulled.

Thanks,
Sekhar
