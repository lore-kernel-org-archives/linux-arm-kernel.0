From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 24 Nov 2011 21:31:37 +0800
Subject: bug of gpio transition in pinmux driver
In-Reply-To: <CACRpkdYQaXtYBwgmovJwz4Kg=zcV=s7RZ0XJJkdgiW0Qnf9dcw@mail.gmail.com>
References: <CAN1soZyX-jJAw4UcQUkgaYC9YosB1znbcFwiijjkyvidPXgp4w@mail.gmail.com>
 <CACRpkdYQaXtYBwgmovJwz4Kg=zcV=s7RZ0XJJkdgiW0Qnf9dcw@mail.gmail.com>
Message-ID: <CAN1soZwaCsUThecBMDLjRrUj5NR6ajo3EyGQo+jGRGtWF=ZfsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 6:16 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Nov 23, 2011 at 2:13 PM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>
>> There's a bug in pinmux driver. We can request gpio via
>> pinmux_request_gpio(@gpio). @gpio is the gpio number.
>>
>> In pinmux_request_gpio():
>> ? ?pin = @gpio - range->base;
>> ? ?pin_request(pin);
>>
>> This pin is the index of pinctrl_pin_desc[]. What's the definition of
>> pinctrl_pin_desc's index? It's the index of PAD, not GPIO. Since the
>> goal of pinmux_request_gpio() is to avoid define too much gpio groups.
>> We need to add the transition between gpio and pad. It's clear that
>> the transition of "pin = @gpio - range->base" can't fit every silicon.
>> Especially, one gpio can be routed to two pads in PXA silicon.
>
> I think this issue is addressed in the patch named
> "pinctrl: add a pin_base for sparse gpio-ranges"
> from Chanho Park.
>
> I have this patch included in linux-next, and the patch named
> "pinctrl: GPIO direction support for muxing" is also
> related.
>
> You can also find this in my "for-next" branch of the
> pinctrl git here:
> http://git.linaro.org/gitweb?p=people/triad/linux-pinctrl.git;a=summary
>

Yes, it's fixed by this patch.

Thanks
Haojian
