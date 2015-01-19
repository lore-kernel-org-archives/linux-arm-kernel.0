From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Jan 2015 11:25:35 +0100
Subject: [PATCH 5/9] dts: versatile: add sysregs nodes
In-Reply-To: <20150115160635.GA1576@red-moon>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
 <1419967718-26909-6-git-send-email-robherring2@gmail.com>
 <CACRpkdbinR3Uvi5zZmQJFxJgnWfvE6JZouMVxxRRGVtMNXkBQQ@mail.gmail.com>
 <CAL_JsqKBLx03E1w0NMH8CH+Pm_L8yQvnR6VTTDxqnpOwAoDhXg@mail.gmail.com>
 <20150115160635.GA1576@red-moon>
Message-ID: <CACRpkdbLdtXeVYWvd5DSmEVkMBT8YGs0kXPC+fktiNtgJhpp=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 5:06 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Thu, Jan 08, 2015 at 11:53:15PM +0000, Rob Herring wrote:
>> On Thu, Jan 8, 2015 at 1:44 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> > On Tue, Dec 30, 2014 at 8:28 PM, Rob Herring <robherring2@gmail.com> wrote:

>> >> +                               reg = <0x00000 0x1000>;
>> >> +
>> >> +                               v2m_led_gpios: sys_led at 08 {
>> >> +                                       compatible = "arm,vexpress-sysreg,sys_led";
>> >> +                                       gpio-controller;
>> >> +                                       #gpio-cells = <2>;
>> >> +                               };
>> >
>> > These are not GPIOs. These are LED registers really.
>>
>> A register bit that controls an i/o signal sounds like a GPIO to me.
>
> To me too. I agree that definining a gpio-controller for every possible
> gpio pin would soon get unwieldy, but hey, the choice made for vexpress
> leds makes perfect sense to me, after all they are gpio signals
> connected to leds, and there is a driver for that in the kernel:
>
> drivers/leds/leds-gpio.c
>
> we could move this stuff to syscon-leds, but honestly I think is one of those
> things we could argue forever about that.

OK it's just so that the GPIO maintainer disagrees with the way
gpio-controller is being used here, and I consequently NACK it
so for the record add my:

Nacked-by: Linus Walleij <linus.walleij@linaro.org>

To this patch if/when merging it through ARM SoC.

If the DT people think it is a good way to describe the hardware
and override this then I will live with it I guess...

Yours,
Linus Walleij
