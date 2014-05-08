From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 May 2014 12:27:50 +0200
Subject: [PATCH] ARM: realview: basic device tree implementation
In-Reply-To: <CAL_JsqKYR1aujNhOASivsg-ED6xDPCsSCcGVnQn5vy4sD1PhAQ@mail.gmail.com>
References: <1395826060-26662-1-git-send-email-linus.walleij@linaro.org>
 <CAL_JsqKYR1aujNhOASivsg-ED6xDPCsSCcGVnQn5vy4sD1PhAQ@mail.gmail.com>
Message-ID: <CACRpkdZ7WoBMBMJjpKcsOeOA5E1erSioOeSDt1xOG=W04RoeCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 6:59 AM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Mar 26, 2014 at 4:27 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

>> +       if (of_machine_is_compatible("arm,realview-eb"))
>> +               /*
>> +                * 1MB (128KB/way), 8-way associativity,
>> +                * evmon/parity/share enabled
>> +                * Bits:  .... ...0 0111 1001 0000 .... .... ....
>> +                */
>> +               l2x0_of_init(0x00790000, 0xfe000fff);
>> +       else if (of_machine_is_compatible("arm,realview-pb1176"))
>> +               /*
>> +                * 128Kb (16Kb/way) 8-way associativity.
>> +                * evmon/parity/share enabled.
>> +                */
>> +               l2x0_of_init(0x00730000, 0xfe000fff);
>> +       else if (of_machine_is_compatible("arm,realview-pb11mp"))
>> +               /*
>> +                * 1MB (128KB/way), 8-way associativity,
>> +                * evmon/parity/share enabled
>> +                * Bits:  .... ...0 0111 1001 0000 .... .... ....
>> +                */
>> +               l2x0_of_init(0x00730000, 0xfe000fff);
>> +       else if (of_machine_is_compatible("arm,realview-pbx"))
>> +               /*
>> +                * 16KB way size, 8-way associativity, parity disabled
>> +                * Bits:  .. 0 0 0 0 1 00 1 0 1 001 0 000 0 .... .... ....
>> +                */
>> +               l2x0_of_init(0x02520000, 0xc0000fff);
>> +#endif
>
> As Arnd pointed out, see Russell's recent L2x0 emails. Since these are
> L220s, you do need the way size and associativity to be initialized at
> least. There are standard ePAPR definitions for these which should be
> used.
>
> Documenting the initial and final aux ctrl values on these platforms
> would be helpful for Russell's clean-up.

The PB1176 board has the initial value:
L2X0_AUX_CTRL = 0x02020fff

I don't know how I can help out best here unfortunately, it's a little
bit of a moving target I guess and admittedly my understanding of
l2x0 is pretty shallow. :-/

Yours,
Linus Walleij
