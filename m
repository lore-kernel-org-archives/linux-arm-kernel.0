From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 14 Dec 2017 22:01:10 +0100
Subject: DT dtc warnings
In-Reply-To: <CAJKOXPc7M3jeV_hNBBRJKGs3vtNzdrGbW_YETw2n0fXxhqjZ_g@mail.gmail.com>
References: <CAL_JsqJKCzjx3zNigu_0T=Ku=_P2SQEjTx=uVbvr_QxJQR7kYg@mail.gmail.com>
 <CAJKOXPc7M3jeV_hNBBRJKGs3vtNzdrGbW_YETw2n0fXxhqjZ_g@mail.gmail.com>
Message-ID: <CAJKOXPfCDT+7wPkz3g6AiKgLvFp4rnicYQgYn8A_yaPe4YhD5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2017 at 9:40 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
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
>> Please help fix these. More checks are being added[2].
>>
>> Rob
>>
>> [1] https://patchwork.kernel.org/patch/10112725/
>> [2] https://www.spinics.net/lists/devicetree-compiler/msg01620.html
>>
>>
>> 77 - arch/arm/boot/dts/prima2-evb.dts
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

Can anyone help why this W=1 triggers warning like these:
arch/arm/boot/dts/exynos3250-artik5-eval.dtb: Warning
(simple_bus_reg): Node /soc/syscon-poweroff missing or empty
reg/ranges property
arch/arm/boot/dts/exynos3250-artik5-eval.dtb: Warning
(simple_bus_reg): Node /soc/syscon-reboot missing or empty reg/ranges
property

For a node without unit address?
http://elixir.free-electrons.com/linux/v4.15-rc3/source/arch/arm/boot/dts/exynos-syscon-restart.dtsi

AFAIR, if node does not have unit-address then it should not have
reg/ranges property. Or maybe it is coming from parent's simple-bus?

Best regards,
Krzysztof
