From: icenowy@aosc.io (icenowy at aosc.io)
Date: Thu, 19 Oct 2017 16:18:04 +0800
Subject: [linux-sunxi] [PATCH v2 6/8] ARM: dts: sun8i: a83t: Move mmc1
 pinctrl setting to dtsi file
In-Reply-To: <CAGb2v64O+eyriHG-FirtPKo6hACfbV9JcJRUUZ+rY1QM2w_r1g@mail.gmail.com>
References: <20171018083138.14517-1-wens@csie.org>
 <20171018083138.14517-7-wens@csie.org>
 <f85a30e2-5a9d-a7ba-0010-6602cabaf83e@riseup.net>
 <CAGb2v64O+eyriHG-FirtPKo6hACfbV9JcJRUUZ+rY1QM2w_r1g@mail.gmail.com>
Message-ID: <0e934ef6b4254fc94f613d1305c06cde@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-10-19 14:48?Chen-Yu Tsai ???
> On Wed, Oct 18, 2017 at 11:00 PM, Joonas Kylm?l? 
> <joonas.kylmala@iki.fi> wrote:
>> Hi,
>> 
>> Chen-Yu Tsai:
>>> mmc1 only has 1 possible pinmux setting.
>> 
>> What if someone is using the MMC with bus width 1 and then using the
>> remaining 3 pins for something else?
> 
> I would very much like to see such a design. Currently the devices
> we see all follow Allwinner's reference design, with only minor
> modifications. As such, mmc1 is used exclusively for connecting
> SDIO-based WiFi modules.
> 
> If such a radical(?) design is done, the vendor can always add
> a "mmc1-1bit-pins" setting and override the default.

I think this kind of thing happened on A13 -- the MMC2 of A13 is
8-bit, but Lichee Pi One wires it to a SD card slot (4-bit); then
the remaining 4 data lines are wired out as GPIO. (Lichee Pi's
do not like obeying reference design ;-) )

But I think a MMC/SDIO device under 1-bit mode is too slow that
maybe no one will use such a setup.

> 
> ChenYu
