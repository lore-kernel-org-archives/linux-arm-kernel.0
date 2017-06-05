From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 5 Jun 2017 17:42:28 +0900
Subject: [PATCH 1/4] thermal: uniphier: add UniPhier thermal driver
In-Reply-To: <20170530182141.6865.4A936039@socionext.com>
References: <1496049345-14649-2-git-send-email-hayashi.kunihiko@socionext.com>
 <20170529164816.GA14822@localhost.localdomain>
 <20170530182141.6865.4A936039@socionext.com>
Message-ID: <CAK7LNARtQfhx+854FHZenymX4Em4LYWSWUsH2iPp4fb9D7xXHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-05-30 18:21 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:

>> > +static const struct uniphier_tm_soc_data uniphier_pxs2_tm_data = {
>> > +   .map_base        = 0xe000,
>> > +   .block_base      = 0xe000,
>> > +   .tmod_setup_addr = 0xe904,
>> > +};
>> > +
>> > +static const struct uniphier_tm_soc_data uniphier_ld20_tm_data = {
>> > +   .map_base        = 0xe000,
>> > +   .block_base      = 0xe800,
>> > +   .tmod_setup_addr = 0xe938,
>>
>> Shouldn't these be in your device tree using the register properties?
>> I see at least the map base as possible to be done in DT.

True for simple-bus.

However, the combination of "simple-mfd" and "syscon"
seems a well established strategy when
registers are mixed/interleaved in a syscon block.

(For example, chip-control at ea0000 node of
arch/arm/boot/dts/berlin2.dtsi)


> I think so.
> However, the iomap of this device are included in sysctrl(simple-mfd),
> and I can't find the method to express offset from base-address of sysctrl
> on DT, instead of map_base, in resonable way.
>
> I think that mfd node has register property then the lower node of mfd,
> that is the thermal node, can't have register property.
>
> If the driver gets offset address from DT, I'll define new property
> like 'socionext,reg_offset' in the thermal node. But I'm not sure that.

socionext,uniphier-{pxs2,ld20}-thermal is an SoC-specific compatible string.
The internal-offset is included
in the HW-spec associated with the compatible.
I believe 'socionext,reg_offset' is pointless.


-- 
Best Regards
Masahiro Yamada
