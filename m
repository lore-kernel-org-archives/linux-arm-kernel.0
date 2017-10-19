From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 19 Oct 2017 16:24:32 +0800
Subject: [linux-sunxi] [PATCH v2 6/8] ARM: dts: sun8i: a83t: Move mmc1
 pinctrl setting to dtsi file
In-Reply-To: <0e934ef6b4254fc94f613d1305c06cde@aosc.io>
References: <20171018083138.14517-1-wens@csie.org>
 <20171018083138.14517-7-wens@csie.org>
 <f85a30e2-5a9d-a7ba-0010-6602cabaf83e@riseup.net>
 <CAGb2v64O+eyriHG-FirtPKo6hACfbV9JcJRUUZ+rY1QM2w_r1g@mail.gmail.com>
 <0e934ef6b4254fc94f613d1305c06cde@aosc.io>
Message-ID: <CAGb2v66Bje_=PcvWFJo6cXB+qsXmZqiwGoBgLfcFWrzEMOQRMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 4:18 PM,  <icenowy@aosc.io> wrote:
> ? 2017-10-19 14:48?Chen-Yu Tsai ???
>>
>> On Wed, Oct 18, 2017 at 11:00 PM, Joonas Kylm?l? <joonas.kylmala@iki.fi>
>> wrote:
>>>
>>> Hi,
>>>
>>> Chen-Yu Tsai:
>>>>
>>>> mmc1 only has 1 possible pinmux setting.
>>>
>>>
>>> What if someone is using the MMC with bus width 1 and then using the
>>> remaining 3 pins for something else?
>>
>>
>> I would very much like to see such a design. Currently the devices
>> we see all follow Allwinner's reference design, with only minor
>> modifications. As such, mmc1 is used exclusively for connecting
>> SDIO-based WiFi modules.
>>
>> If such a radical(?) design is done, the vendor can always add
>> a "mmc1-1bit-pins" setting and override the default.
>
>
> I think this kind of thing happened on A13 -- the MMC2 of A13 is
> 8-bit, but Lichee Pi One wires it to a SD card slot (4-bit); then
> the remaining 4 data lines are wired out as GPIO. (Lichee Pi's
> do not like obeying reference design ;-) )

For MMC2 we have mmc2_pins (4-bit) and mmc2_8bit_emmc_pins (8-bit
+ emmc reset pin).

ChenYu

>
> But I think a MMC/SDIO device under 1-bit mode is too slow that
> maybe no one will use such a setup.
>
>>
>> ChenYu
>
>
> --
> You received this message because you are subscribed to the Google Groups
> "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
