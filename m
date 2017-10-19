From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 20 Oct 2017 00:34:30 +0800
Subject: [linux-sunxi] [PATCH v2 6/8] ARM: dts: sun8i: a83t: Move mmc1
 pinctrl setting to dtsi file
In-Reply-To: <4a2734fb-71ab-7cd9-2b17-669f2fdf9a2c@riseup.net>
References: <20171018083138.14517-1-wens@csie.org>
 <20171018083138.14517-7-wens@csie.org>
 <f85a30e2-5a9d-a7ba-0010-6602cabaf83e@riseup.net>
 <CAGb2v64O+eyriHG-FirtPKo6hACfbV9JcJRUUZ+rY1QM2w_r1g@mail.gmail.com>
 <4a2734fb-71ab-7cd9-2b17-669f2fdf9a2c@riseup.net>
Message-ID: <CAGb2v64T=z8RefyEcDHJyrJE9ZCRN=c6zVf25JEqSKvDGUE_Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 12:02 AM, Joonas Kylm?l? <joonas.kylmala@iki.fi> wrote:
> Chen-Yu Tsai:
>>> Chen-Yu Tsai:
>>>> mmc1 only has 1 possible pinmux setting.
>>>
>>> What if someone is using the MMC with bus width 1 and then using the
>>> remaining 3 pins for something else?
>>
>> I would very much like to see such a design. Currently the devices
>> we see all follow Allwinner's reference design, with only minor
>> modifications. As such, mmc1 is used exclusively for connecting
>> SDIO-based WiFi modules.
>>
>> If such a radical(?) design is done, the vendor can always add
>> a "mmc1-1bit-pins" setting and override the default.
>
> Alright. So could we then make similar patches for other SoCs that have
> the same situation with the MMC pinmuxing? I.e. let's move the pinctrl
> to the dtsi file from the dts files. With H3 SDC0 and SDC1 nodes could
> be moved then to the dtsi. Can't we also move the SDC0 pinctrl in A83T
> to the dtsi file? Though, in order to do that mmc0_cd_pin node needs to
> be added to the A38T dtsi.

Yes. We are slowly doing this and other cleanups. This is somewhat
boring and tedious, and it's not exactly a high priority item. You
might have noticed Maxime recently sent patches to clean up sun4i
and sun9i.

ChenYu
