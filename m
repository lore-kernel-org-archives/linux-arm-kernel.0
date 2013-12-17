From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Dec 2013 11:20:07 +0100
Subject: [PATCH v6 6/6] ARM: davinci: da850 evm: add GPIO pinumux entries
 DT node
In-Reply-To: <52ADAB0E.4020800@ti.com>
References: <1385057731-4348-1-git-send-email-prabhakar.csengg@gmail.com>
 <1385057731-4348-7-git-send-email-prabhakar.csengg@gmail.com>
 <52ADAB0E.4020800@ti.com>
Message-ID: <CACRpkdZQ9Q1SxXZ4FPpTN_swUBCyZd8CzNzVzEm87vjYZsQ2+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 15, 2013 at 2:13 PM, Sekhar Nori <nsekhar@ti.com> wrote:
> On Thursday 21 November 2013 11:45 PM, Prabhakar Lad wrote:
>> From: KV Sujith <sujithkv@ti.com>

>> +
>> +                     gpio_pins: pinmux_gpio_pins {
>> +                             pinctrl-single,bits = <
>> +                                     /* GPIO2_4 GPIO2_6 */
>> +                                     0x18 0x00008080 0x0000f0f0
>> +                                     /* GPIO2_8 GPIO2_15 */
>> +                                     0x14 0x80000008 0xf000000f
>> +                                     /* GPIO3_12 GPIO3_13 */
>> +                                     0x1C 0x00008800 0x0000ff00
>> +                                     /* GPIO4_0 GPIO4_1 */
>> +                                     0x28 0x88000000 0xff000000
>> +                                     /* GPIO6_9 GPIO6_10 GPIO6_13 */
>> +                                     0x34 0x08800800 0x0ff00f00
>> +                             >;
>> +                     };
>>               };
>
> Shouldn't these pinmux entries be part of actual device
> node which needs them to be muxed this way?

The usual way to do it is to set up as states for the device,
or as a hog (on the pin controller itself).

Yours,
Linus Walleij
