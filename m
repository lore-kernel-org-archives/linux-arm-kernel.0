From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Aug 2011 12:20:39 +0200
Subject: [PATCH] amba: consolidate PrimeCell magic
In-Reply-To: <20110815100037.GD26827@n2100.arm.linux.org.uk>
References: <1313402104-27024-1-git-send-email-linus.walleij@stericsson.com>
	<20110815100037.GD26827@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZ7jZ-o_MqY9E56JZZyiZW21Prj0ear5q9Y4_Y=yW9rBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 12:00 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Aug 15, 2011 at 11:55:04AM +0200, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> Since two drivers use the PrimeCell scheme without using the
>> amba_bus driver logic, let's break the magic lookups out as
>> static inlines in the <linux/amba/bus.h> header so we get
>> some consolidation anyway.
>
> Why not convert these to use the amba_bus driver?

The PL330 bit is already a backend for the drivers/dma/pl330.c
driver which is amba_bus. However it can also be used in
isolation (IIRC), but I think Boojin is consolidating that driver
and once the common/pl330.c code can be moved to
drivers/dma/* it will be converted and these ID checks
dropped I guess.

As for drivers/dma/ste_dma40.c I think it has some
dependencies to the platform bus but I will look into it.

I fear there is a lot of stuff out there that have PrimeCell
ID's and could be using amba_bus actually :-(

Linus Walleij
