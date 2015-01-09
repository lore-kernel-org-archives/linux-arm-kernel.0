From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Jan 2015 08:10:36 +0100
Subject: [PATCH 5/9] dts: versatile: add sysregs nodes
In-Reply-To: <CAL_JsqKBLx03E1w0NMH8CH+Pm_L8yQvnR6VTTDxqnpOwAoDhXg@mail.gmail.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
 <1419967718-26909-6-git-send-email-robherring2@gmail.com>
 <CACRpkdbinR3Uvi5zZmQJFxJgnWfvE6JZouMVxxRRGVtMNXkBQQ@mail.gmail.com>
 <CAL_JsqKBLx03E1w0NMH8CH+Pm_L8yQvnR6VTTDxqnpOwAoDhXg@mail.gmail.com>
Message-ID: <CACRpkdZFxToT5L0sJXap-NQGtjkryn4KTZVnweKCxXL9WvFLEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 9, 2015 at 12:53 AM, Rob Herring <robherring2@gmail.com> wrote:
> On Thu, Jan 8, 2015 at 1:44 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

>> On Tue, Dec 30, 2014 at 8:28 PM, Rob Herring <robherring2@gmail.com> wrote:
>> compatible = "syscon";
>
> maybe? VExpress is missing that then...

I don't like the way some vexpress stuff has been done I think, just
not enough reviewing power :(

I've tried to make an as clean separation as possible in the Integrator
as it has been refactored with a minimum of time pressure and
I tried to make it as reusable as possible. But it doesn't necessarily
mean I did the right thing all the time ...

>>> +                               reg = <0x00000 0x1000>;
>>> +
>>> +                               v2m_led_gpios: sys_led at 08 {
>>> +                                       compatible = "arm,vexpress-sysreg,sys_led";
>>> +                                       gpio-controller;
>>> +                                       #gpio-cells = <2>;
>>> +                               };
>>
>> These are not GPIOs. These are LED registers really.
>
> A register bit that controls an i/o signal sounds like a GPIO to me.

Are they described as general purpose in the manual for the
board?

In the ARM reference design manuals I've seen these bits are
described as for one purpose only. I mean you can claim the
memory RE signal is "a bit that controls an I/O signal" as well,
but we have to think about the abstraction here.

>> see how to use LEDs from drivers/leds/leds-syscon.c and bindings.
>> example in:
>> arch/arm/boot/dts/integrator.dtsi
>>
>> Very straight-forward I think.
>
> So we have 2 implementations and bindings for roughly the same hardware? Great!

The syscon stuff is designed to be reusable for machines outside
the Versatile and ARM reference families.

Yours,
Linus Walleij
