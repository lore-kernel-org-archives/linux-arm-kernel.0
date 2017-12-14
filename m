From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 14 Dec 2017 12:42:21 -0600
Subject: [PATCH] arm64: dts: Remove leading 0x and 0s from bindings
 notation
In-Reply-To: <1513276199.27409.75.camel@perches.com>
References: <20171214165352.27902-1-malat@debian.org>
 <98a7dc30-e736-eaf8-204f-2ac2b3ea79b9@gmail.com>
 <1513276199.27409.75.camel@perches.com>
Message-ID: <CAL_JsqJrjb9xDD5b65LXVVroEOGf9R1iAHZXZT0Ym6ApchLeig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2017 at 12:29 PM, Joe Perches <joe@perches.com> wrote:
> On Thu, 2017-12-14 at 19:03 +0100, Matthias Brugger wrote:
>>
>> On 12/14/2017 05:53 PM, Mathieu Malaterre wrote:
>> [...]
>> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> > index 26396ef53bde..0446b122a6e2 100644
>> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> > @@ -249,7 +249,7 @@
>> >                     reg = <0 0x10005000 0 0x1000>;
>> >             };
>> >
>> > -           pio: pinctrl at 0x10005000 {
>> > +           pio: pinctrl at 10005000 {
>> >                     compatible = "mediatek,mt8173-pinctrl";
>> >                     reg = <0 0x1000b000 0 0x1000>;
>> >                     mediatek,pctl-regmap = <&syscfg_pctl_a>;
>>
>> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
>
> Should all of these be fixed?
>
> $ git grep -P "^\s*\w+:\s*[\w\-]+ at 0[xX]" -- "*.dts*" | wc -l
> 69

Yes, there's patches for all arches.

>
> Is this a pattern that should be added to checkpatch?

No, because dtc provides the warnings.

Rob
