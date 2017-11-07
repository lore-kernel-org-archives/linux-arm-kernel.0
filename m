From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Tue, 7 Nov 2017 23:32:23 +0100
Subject: AXP803 I2C support / AXP devicetree-bindings
In-Reply-To: <CAGb2v642n4puXqKOjG0QxhFgFFW2nJKrpU4KV2ZRPNb6_zF4pw@mail.gmail.com>
References: <CAFBinCAm8pA-dh3+T4Ui+DvLv5C17Zup-FN8pvi0cUa5PgwJJw@mail.gmail.com>
 <CAGb2v642n4puXqKOjG0QxhFgFFW2nJKrpU4KV2ZRPNb6_zF4pw@mail.gmail.com>
Message-ID: <CAFBinCDVh2DpuQBx-x2OC_n9GJyYF8E84V1muYYvMJp2FYxjTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ChenYu,

On Tue, Nov 7, 2017 at 4:13 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Tue, Nov 7, 2017 at 6:39 AM, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>> Hello,
>>
>> recently I discovered that there are some X-Powers AXP chips that
>> support both, Allwinner's own "RSB" as well as the I2C ("TWSI" in the
>> datasheet) busses.
>>
>> one chip that supports both interfaces is the AXP803
>> the datasheet is linked in the public PINE64 wiki: [1] (direct link: [0])
>
> All the RSB based PMICs support both modes. They start in I2C mode
> when cold booted.
I did not know that - thank you for that info!

>>
>> currently the "x-powers,axp803" binding is "RSB" bus specific as it's
>> currently only listed in drivers/mfd/axp20x-rsb.c
>>
>> was there a discussion about supporting both, the "RSB" and I2C bus
>> for one chip (for example the AXP803) in the past (I couldn't find
>> anything online)?
>
> No. None of the boards actually use I2C instead of RSB. RSB mode is
> initialized by the boot loader. There is no easy way for the kernel to
> switch it back.
I'm not trying to change this on an existing board

>> what about the device-tree bindings in this case?
>
> We can deal with it if someone actually comes up with a practical
> case needing it. Otherwise things go untested, which is not what
> we want.
OK, thank you for this information

if there is a valid use-case for this: would you like to see a RfC
patch-series (along with a description why it's needed) or discuss
this further before sending any patches?


Regards
Martin
