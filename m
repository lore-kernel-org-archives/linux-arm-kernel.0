From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 27 Jan 2015 13:38:09 +0100
Subject: [PATCH v5 1/5] ARM: mediatek: Add config options for mediatek
 SoCs.
In-Reply-To: <1422354858.14015.39.camel@x220>
References: <1421818097-9281-1-git-send-email-hongzhou.yang@mediatek.com>
 <1421818097-9281-2-git-send-email-hongzhou.yang@mediatek.com>
 <CABuKBeJGigY5ym9cJy=PYK8jbdsOLLtkmovHq6xho4gYseCAWg@mail.gmail.com>
 <1422353800.14015.35.camel@x220>
 <1422354400.32212.25.camel@mtksdaap41>
 <1422354858.14015.39.camel@x220>
Message-ID: <CABuKBeLPN74fiLduvswHfPrgAoQCFXCtdLZhhoha8Q=0xBSjpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-01-27 11:34 GMT+01:00 Paul Bolle <pebolle@tiscali.nl>:
> Hi Joe,
>
> On Tue, 2015-01-27 at 18:26 +0800, Yingjoe Chen wrote:
>> On Tue, 2015-01-27 at 11:16 +0100, Paul Bolle wrote:
>> > On Thu, 2015-01-22 at 13:54 +0100, Matthias Brugger wrote:
>> > > 2015-01-21 6:28 GMT+01:00 Hongzhou Yang <hongzhou.yang@mediatek.com>:
>> > > > From: Yingjoe Chen <yingjoe.chen@mediatek.com>
>> > > >
>> > > > The upcoming MTK pinctrl driver have a big pin table for each SoC
>> > > > and we don't want to bloat the kernel binary if we don't need it.
>> > > > Add config options so we can build for one SoC only.
>> > > >
>> > > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> > > > Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
>> > > > Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
>> > >
>> > > Applied to v3.20-next/soc
>> >
>> > This became commit ad8a221e1f49 ("ARM: mediatek: Add config options for
>> > mediatek SoCs.") in today's linux-next (ie, next-20150127). I noticed
>> > because a script I use to check linux-next spotted a problem with it.
>> >
>> > > > ---
>> > > >  arch/arm/mach-mediatek/Kconfig | 22 +++++++++++++++++++++-
>> > > >  1 file changed, 21 insertions(+), 1 deletion(-)
>> > > >
>> > > > diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
>> > > > index f73f588..f7e463c 100644
>> > > > --- a/arch/arm/mach-mediatek/Kconfig
>> > > > +++ b/arch/arm/mach-mediatek/Kconfig
>> > > > @@ -1,6 +1,26 @@
>> > > > -config ARCH_MEDIATEK
>> > > > +menuconfig ARCH_MEDIATEK
>> > > >         bool "Mediatek MT65xx & MT81xx SoC" if ARCH_MULTI_V7
>> > > >         select ARM_GIC
>> > > >         select MTK_TIMER
>> > > >         help
>> > > >           Support for Mediatek MT65xx & MT81xx SoCs
>> > > > +
>> > > > +if ARCH_MEDIATEK
>> > > > +
>> > > > +config MACH_MT6589
>> > > > +       bool "MediaTek MT6589 SoCs support"
>> > > > +       default ARCH_MEDIATEK
>> > > > +
>> > > > +config MACH_MT6592
>> > > > +       bool "MediaTek MT6592 SoCs support"
>> > > > +       default ARCH_MEDIATEK
>> > > > +
>> > > > +config MACH_MT8127
>> > > > +       bool "MediaTek MT8127 SoCs support"
>> > > > +       default ARCH_MEDIATEK
>> > > > +
>> > > > +config MACH_MT8135
>> > > > +       bool "MediaTek MT8135 SoCs support"
>> > > > +       default ARCH_MEDIATEK
>> > > > +
>> > > > +endif
>> >
>> > None of these four new MACH_MT* Kconfig symbols are currently used in
>> > linux-next. I assume that patches that actually use them (either as a
>> > Kconfig symbol or as a CONFIG_* macro) are still pending. Is that
>> > correct?
>>
>> Yes, it is used in patch 3 in this series[1], and is discussed in [2].
>>
>> Joe.C
>>
>> [1]
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/318453.html
>
> That only seems to add a user for MACH_MT8135, not for the other three
> symbols. The other three symbols will be used too, won't they?
>
>> [2]
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315616.html
>
> (For the record, that is a message regarding v4 of this patch.)
>
>
> Paul Bolle
>

Yes, this symbols are needed when we implement the pinctrl driver for
the other platforms.
I will implement mt6589 as soon as the pinctrl driver got merged.
I suppose Howard will go for the mt6592.

Cheers,
Matthias

-- 
motzblog.wordpress.com
