From: djw@t-chip.com.cn (djw at t-chip.com.cn)
Date: Wed, 25 Jul 2018 12:01:43 +0800
Subject: [PATCH v0] arm64: dts: rockchip: add support for ROC-RK3399-PC
 board
In-Reply-To: <CAFqH_52baP9yt35yfAdU5wk8DiK67_etPALsmb5K1JPmnW_kqQ@mail.gmail.com>
 (Enric Balletbo Serra's message of "Tue, 24 Jul 2018 11:53:40 +0200")
References: <1532161826-2537-1-git-send-email-djw@t-chip.com.cn>
 <139327780.KNaNigg5Hs@phil>
 <CAFqH_52baP9yt35yfAdU5wk8DiK67_etPALsmb5K1JPmnW_kqQ@mail.gmail.com>
Message-ID: <87effsgdzs.fsf@archiso.i-did-not-set--mail-host-address--so-tickle-me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enric Balletbo Serra <eballetbo@gmail.com> writes:

> Hi Levin,
>
> Missatge de Heiko Stuebner <heiko@sntech.de> del dia dt., 24 de jul.
> 2018 a les 11:29:
>>
>> Hi Levin,
>>
>> Am Samstag, 21. Juli 2018, 10:30:26 CEST schrieb djw at t-chip.com.cn:
>> > From: Levin Du <djw@t-chip.com.cn>
>> >
>> > ROC-RK3399-PC is the first power efficient 4GB DDR4 single board
>>
>> maybe "is a power efficient" instead of "the first" ;-)
>>
>> [...]
>>
>> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
>> > new file mode 100644
>> > index 0000000..207f2e3
>> > --- /dev/null
>> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
>> > @@ -0,0 +1,717 @@
>> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> > +/*
>> > + * Copyright (c) 2017 T-Chip Intelligent Technology Co., Ltd
>> > + */
>> > +
>> > +/dts-v1/;
>> > +#include <dt-bindings/pwm/pwm.h>
>> > +#include "rk3399.dtsi"
>> > +#include "rk3399-opp.dtsi"
>> > +
>> > +/ {
>> > +     model = "Firefly ROC-RK3399-PC Board";
>> > +     compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
>> > +
>> > +     chosen {
>> > +             bootargs = "earlycon=uart8250,mmio32,0xff1a0000 swiotlb=1";
>>
>> I don't think we want to hard-code linux bootargs in the generic devicetree
>>
>> > +             stdout-path = "serial2:1500000n8";
>> > +     };
>> > +
>> > +     backlight: backlight {
>> > +             compatible = "pwm-backlight";
>> > +             enable-gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
>> > +             pwms = <&pwm0 0 25000 0>;
>> > +             brightness-levels = <
>> > +                       0   1   2   3   4   5   6   7
>>
>> As Rob noted in the px30 evb patch, there is now a property helping
>> to drop these long lists of brightness levels, see
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=1e5e7cc794b5a332c23216dade0a2e937d694b7f
>
> Adding to the Heiko information. Did you try to just remove brightness-levels?
> Without this property, the driver computes a default table with the
> brightness levels filled with the numbers provided by the CIE 1931
> algorithm. That algorithm is used to dim a led for human perception.
>
> Note that the patches needed did not land yet, are in linux-next, and
> you will also be interested in apply this patch [1].
>
> [1] https://lkml.org/lkml/2018/7/24/116
>
>
> Best regards,
>  Enric
>

Thanks you for the note, Enric. I'll test that later.

Regards,
Levin
