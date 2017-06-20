From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Jun 2017 19:03:23 -0700
Subject: [GIT PULL] ARM: Medaitek armv7 DTS for v4.13
In-Reply-To: <1497924044.22079.3.camel@mtkswgap22>
References: <5056d433-90b3-a3ca-4df7-9ff02ab6027b@gmail.com>
 <20170619023437.GV30022@localhost> <1497924044.22079.3.camel@mtkswgap22>
Message-ID: <CAOesGMihRCAySi38X1Ncx3G0WwW71m9ZBMTo7MghXJx8t0D2mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 19, 2017 at 7:00 PM, Sean Wang <sean.wang@mediatek.com> wrote:
> On Sun, 2017-06-18 at 19:34 -0700, Olof Johansson wrote:
>> On Mon, Jun 12, 2017 at 12:31:47PM +0200, Matthias Brugger wrote:
>> > Hi Arnd and Olof,
>> >
>> > Please find below my merge request for armv7 device tree changes.
>> >
>> > Regards,
>> > Matthias
>> >
>> > ---
>> >
>> > The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
>> >
>> >   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
>> >
>> > are available in the git repository at:
>> >
>> >   https://github.com/mbgg/linux-mediatek.git tags/v4.12-next-dts32
>> >
>> > for you to fetch changes up to aac5e972d4c7bc728df605f5427d9c2458c34ea9:
>> >
>> >   arm: dts: mediatek: Add audio driver node for MT2701 (2017-06-07 10:47:25
>> > +0200)
>>
>> Thanks, merged. Comment below:
>>
>> >
>> > ----------------------------------------------------------------
>> > Add device tree nodes for
>> > mt7623:
>> > - clocks
>> > - power domain
>> > - pmic-wrapper
>> > - pinctrl
>> > - i2c
>> > - spi
>> > - nand
>> > - mmc
>> > - usb
>> > - pwm
>> > - ethernet
>> > - crypto engine
>> > - infared remote control
>> > - audio controller
>> > - ADC
>> > - efuse
>> > - thermal driver
>> > - HW random generator
>> >
>> > mt2701:
>> > - NOR flash
>> > - JPEG decoder
>> > - i2c
>> > - audio controller
>> >
>> > ----------------------------------------------------------------
>> > Garlic Tseng (1):
>> >       arm: dts: mediatek: Add audio driver node for MT2701
>> >
>> > Guochun Mao (1):
>> >       arm: dts: mt2701: add nor flash node
>> >
>> > John Crispin (9):
>> >       arm: dts: mt7623: add clock controller device nodes
>> >       arm: dts: mt7623: add subsystem clock controller device nodes
>> >       arm: dts: mt7623: add power domain controller device node
>> >       arm: dts: mt7623: add pinctrl nodes to the mt7623 dtsi file
>> >       arm: dts: mt7623: add pmic wrapper nodes to the mt7623 dtsi file
>> >       arm: dts: mt7623: add i2c nodes to the mt7623.dtsi file
>> >       arm: dts: mt7623: add nand nodes to the mt7623.dtsi file
>> >       arm: dts: mt7623: add mmc nodes to the mt7623.dtsi file
>> >       arm: dts: mt7623: add usb nodes to the mt7623.dtsi file
>> >
>> > Jun Gao (1):
>> >       arm: dts: Add Mediatek MT2701 i2c device node
>> >
>> > Rick Chang (1):
>> >       arm: dts: mt2701: Add node for Mediatek JPEG Decoder
>> >
>> > Sean Wang (11):
>> >       arm: dts: mt7623: add spi nodes to the mt7623.dtsi file
>> >       arm: dts: mt7623: add pwm nodes to the mt7623.dtsi file
>> >       arm: dts: mt7623: add ethernet nodes to the mt7623.dtsi file
>> >       arm: dts: mt7623: add crypto engine nodes to the mt7623.dtsi file
>> >       arm: dts: mt7623: add ir nodes to the mt7623.dtsi file
>> >       arm: dts: mt7623: add afe nodes to the mt7623.dtsi file
>> >       arm: dts: mt7623: add rng nodes to the mt7623.dtsi file
>> >       arm: dts: mt7623: add auxadc nodes to the mt7623.dtsi file
>> >       arm: dts: mt7623: add efuse nodes to the mt7623.dtsi file
>> >       arm: dts: mt7623: add thermal nodes to the mt7623.dtsi file
>> >       arm: dts: mt7623: add Sean as one of authors for mt7623.dtsi files
>>
>> This excessive patch splitting probably isn't warranted. In the future,
>> especially for new and major updates like this, a single patch (or one per
>> author) should do just fine.
>>
>
> Hi Olof,
>
> Got it. I will make a single patch for new SoC supported.

Of course, use your judgement if there's something special or new
(especially complex bindings) that you want to highlight in a separate
patch, but for the basic setup just adding the basic nodes, doing that
in one file is usually the way we do it.

Thanks!


-Olof
