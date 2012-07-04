From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Jul 2012 00:34:02 +0200
Subject: [PATCH 2/2] ARM: PRIMA2: add PINMUX map for primaII UART1 and
 SPI0/1
In-Reply-To: <CAGsJ_4xg0_aXaE6GXdVK9DYbh2UUzqow=csmsqRGzFyGh7603w@mail.gmail.com>
References: <1341373400-15763-1-git-send-email-Barry.Song@csr.com>
 <1341373400-15763-2-git-send-email-Barry.Song@csr.com>
 <201207041145.28418.arnd@arndb.de>
 <CAGsJ_4xg0_aXaE6GXdVK9DYbh2UUzqow=csmsqRGzFyGh7603w@mail.gmail.com>
Message-ID: <CACRpkdYr6FUynkhXTEEOyZtJzPSngQJDvaCF7NQTQrQDZZCVeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 4, 2012 at 4:25 PM, Barry Song <21cnbao@gmail.com> wrote:
> 2012/7/4 Arnd Bergmann <arnd@arndb.de>:
>> On Wednesday 04 July 2012, Barry Song wrote:

>>>         of_platform_populate(NULL, sirfsoc_of_bus_ids, prima2_auxdata_lookup, NULL);
>>> +       pinctrl_register_mappings(prima2_padmux_map, ARRAY_SIZE(prima2_padmux_map));
>>>  }
>>
>> I haven't been following pinctrl too closely, but isn't this something
>> that would normally be represented by putting the lookup table into the
>> device tree?
>
> i'd like to see that. i am not sure whether i have missed anything
> since i only saw the pinctrl_register_mappings samples.
> would linus clarify?

You can do it either way, but for a DT:ed platform it makes sense to have
it in device tree.

Check drivers/pinctrl/devicetree.c for how that code works, the bindings
are in
Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
There are example usecases in arch/arm/boot/dts/*

This was all implemented by Stephen Warren so he's the reference
to this codepath.

Yours,
Linus Walleij
