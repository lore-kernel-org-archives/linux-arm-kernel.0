From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 Apr 2012 09:38:17 +0200
Subject: [PATCH 5/9 v2] gpio/nomadik: use ioremap() instead of static
 mappings
In-Reply-To: <20120423113425.GN24211@n2100.arm.linux.org.uk>
References: <1335180632-21381-1-git-send-email-linus.walleij@stericsson.com>
 <20120423113425.GN24211@n2100.arm.linux.org.uk>
Message-ID: <CACRpkda=aUFyZ2M3wAWSNzuk4EwGNRbo-qqtxLA26PeRKRtTog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 1:34 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Apr 23, 2012 at 01:30:32PM +0200, Linus Walleij wrote:
>> diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
>> index 7b45d88..bddc3dd 100644
>> --- a/drivers/gpio/gpio-nomadik.c
>> +++ b/drivers/gpio/gpio-nomadik.c
>> @@ -28,7 +28,6 @@
>>
>> ?#include <plat/pincfg.h>
>> ?#include <plat/gpio-nomadik.h>
>> -#include <mach/hardware.h>
>> ?#include <asm/gpio.h>
>
> While you're here, please replace this with linux/gpio.h - which will give
> us one less direct dependency on asm/ or mach/ includes from drivers.

OK I just deleted it, <linux/gpio.h> was included further up, so
this was just some dangling include anyway.

Yours,
Linus Walleij
