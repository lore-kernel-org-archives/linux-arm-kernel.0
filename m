From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 7 Nov 2017 11:13:23 +0800
Subject: AXP803 I2C support / AXP devicetree-bindings
In-Reply-To: <CAFBinCAm8pA-dh3+T4Ui+DvLv5C17Zup-FN8pvi0cUa5PgwJJw@mail.gmail.com>
References: <CAFBinCAm8pA-dh3+T4Ui+DvLv5C17Zup-FN8pvi0cUa5PgwJJw@mail.gmail.com>
Message-ID: <CAGb2v642n4puXqKOjG0QxhFgFFW2nJKrpU4KV2ZRPNb6_zF4pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 7, 2017 at 6:39 AM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> Hello,
>
> recently I discovered that there are some X-Powers AXP chips that
> support both, Allwinner's own "RSB" as well as the I2C ("TWSI" in the
> datasheet) busses.
>
> one chip that supports both interfaces is the AXP803
> the datasheet is linked in the public PINE64 wiki: [1] (direct link: [0])

All the RSB based PMICs support both modes. They start in I2C mode
when cold booted.

>
> currently the "x-powers,axp803" binding is "RSB" bus specific as it's
> currently only listed in drivers/mfd/axp20x-rsb.c
>
> was there a discussion about supporting both, the "RSB" and I2C bus
> for one chip (for example the AXP803) in the past (I couldn't find
> anything online)?

No. None of the boards actually use I2C instead of RSB. RSB mode is
initialized by the boot loader. There is no easy way for the kernel to
switch it back.

> what about the device-tree bindings in this case?

We can deal with it if someone actually comes up with a practical
case needing it. Otherwise things go untested, which is not what
we want.

ChenYu

>
>
> Regards
> Martin
>
>
> [0] http://files.pine64.org/doc/datasheet/pine64/AXP803_Datasheet_V1.0.pdf
> [1] http://wiki.pine64.org/index.php/PINE_A64_Main_Page#Datasheets_for_Components_and_Peripherals
