From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 18 Dec 2017 18:46:51 +0800
Subject: [linux-sunxi] [PATCH v3 2/3] dt-bindings: media: Add Allwinner
 V3s Camera Sensor Interface (CSI)
In-Reply-To: <20171218174309.9170c971c5acac0d14dd782d@magewell.com>
References: <1510558344-45402-1-git-send-email-yong.deng@magewell.com>
 <CAGb2v67JhMfba8Ao7WyrYikkxvTxX8WaBRqu3GkrhOCWndresg@mail.gmail.com>
 <20171218164921.227b82349c778283f5e5eba8@magewell.com>
 <20171218092437.ksczam5h7hirmpcv@flea.lan>
 <20171218174309.9170c971c5acac0d14dd782d@magewell.com>
Message-ID: <CAGb2v67P9Vu7b=c0N5G7B7xNuP9s=oMwdixie6ba-qU35b4+xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 5:43 PM, Yong <yong.deng@magewell.com> wrote:
> Hi,
>
> On Mon, 18 Dec 2017 10:24:37 +0100
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
>
>> Hi,
>>
>> On Mon, Dec 18, 2017 at 04:49:21PM +0800, Yong wrote:
>> > > > +               compatible = "allwinner,sun8i-v3s-csi";
>> > > > +               reg = <0x01cb4000 0x1000>;
>> > > > +               interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
>> > > > +               clocks = <&ccu CLK_BUS_CSI>,
>> > > > +                        <&ccu CLK_CSI1_SCLK>,
>> > >
>> > > CSI also has an MCLK. Do you need that one?
>> >
>> > MCLK is not needed if the front end is not a sensor (like adv7611).
>> > I will add it as an option.
>>
>> I guess this should always be needed then. And the driver will make
>> the decision to enable it or not.
>
> But how the driver to know if it should be enabled?
> I think MCLK should be added in DT just if the subdev need it.

Looking around the docs, there doesn't seem to be anything related
to MCLK within the CSI section.

Furthermore, camera sensor bindings, such as for the OV5640, in fact
do have a property for a reference clock, which is called XCLK or
XVCLK.

Since the clock is already exported from the CCU, I suppose it's
just a matter of referencing the clock from the camera node, with
the proper pinctrl for that pin.

So to summarize, just ignore my comment about the missing MCLK. :)

ChenYu
