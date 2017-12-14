From: robh@kernel.org (Rob Herring)
Date: Thu, 14 Dec 2017 15:02:19 -0600
Subject: DT dtc warnings
In-Reply-To: <CAJKOXPc7M3jeV_hNBBRJKGs3vtNzdrGbW_YETw2n0fXxhqjZ_g@mail.gmail.com>
References: <CAL_JsqJKCzjx3zNigu_0T=Ku=_P2SQEjTx=uVbvr_QxJQR7kYg@mail.gmail.com>
 <CAJKOXPc7M3jeV_hNBBRJKGs3vtNzdrGbW_YETw2n0fXxhqjZ_g@mail.gmail.com>
Message-ID: <CAL_JsqJBpDce=ZTOuY+3_kwPEj+2-yOCrX6GDgMMLKbd9Z3hFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2017 at 2:40 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Dec 14, 2017 at 7:21 PM, Rob Herring <robh@kernel.org> wrote:
>> Hi all,
>>
>> Below is a current list of ARM boards with more than 40 dtc warnings
>> when building with W=1. There's a treewide patch in flight to fix some
>> unit-address warnings[1], so those aren't included here. The list is
>> grouped by maintainer. AT91, Exynos, and Allwinner continue to be at
>> the top of the list and have been for some time (though having
>> multiple boards for an SoC can cause lots of duplicated warnings).
>>
>> 50 - arch/arm/boot/dts/exynos5250-arndale.dts
>> 50 - arch/arm/boot/dts/exynos5250-smdk5250.dts
>> 50 - arch/arm/boot/dts/exynos5250-snow.dts
>> 50 - arch/arm/boot/dts/exynos5250-snow-rev5.dts
>> 50 - arch/arm/boot/dts/exynos5250-spring.dts
>> 71 - arch/arm/boot/dts/exynos5420-arndale-octa.dts
>> 71 - arch/arm/boot/dts/exynos5420-peach-pit.dts
>> 71 - arch/arm/boot/dts/exynos5420-smdk5420.dts
>> 71 - arch/arm/boot/dts/exynos5422-odroidhc1.dts
>> 71 - arch/arm/boot/dts/exynos5422-odroidxu3.dts
>> 71 - arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
>> 71 - arch/arm/boot/dts/exynos5422-odroidxu4.dts
>> 71 - arch/arm/boot/dts/exynos5800-peach-pi.dts
>>
>
> Sure, I can take care of this but in such case it would be better if
> Mathieu's (+Cc) patch would be split per-subarch maintainer. I can
> base my patch on top of his... but there might be conflicts when
> applying to my tree.
>
> Different topic - why not enabling these warnings by default?

Because the warning police don't like lots of warnings. Neither did
Linus, but he only sees the unittest ones[1]. The ones that are actual
binding errors rather than best practice are on by default.

The plan is to enable once the warnings are all gone.

Rob

[1] https://www.spinics.net/lists/devicetree/msg202057.html
