From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Dec 2017 16:49:19 +0100
Subject: [PATCH net-next 2/2 v8] net: ethernet: Add a driver for Gemini
 gigabit ethernet
In-Reply-To: <20171211.141651.2190843744682664766.davem@davemloft.net>
References: <20171210224558.27122-1-linus.walleij@linaro.org>
 <20171210224558.27122-2-linus.walleij@linaro.org>
 <20171211.141651.2190843744682664766.davem@davemloft.net>
Message-ID: <CACRpkdbVBanr9fxJY0ShJmZ-AMcjUJEoKbOUs=MMua04HpoCXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 8:16 PM, David Miller <davem@davemloft.net> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>

>> +if NET_VENDOR_CORTINA
>> +
>> +config GEMINI_ETHERNET
>> +     tristate "Gemini Gigabit Ethernet support"
>> +     depends on ARCH_GEMINI
>> +     depends on OF
>> +     select PHYLIB
>> +     select CRC32
>> +     ---help---
>> +       This driver supports StorLink SL351x (Gemini) dual Gigabit Ethernet.
>
> Make this driver buildable anywhere, you don't use any platform architecture
> specific features.

I pushed the recent v9 set where I remove the dep on ARCH_GEMINI
and the autobuilders complain a lot about the use of dma_to_pfn()
which turns out to be a ARM thing from <asm/dma-mapping.h>
included from <linux/dma-mapping.h>.

I will try switching to functions from the generic dma-mapping API
and fix it up and send a v10.

Yours,
Linus Walleij
