From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed, 16 Dec 2015 19:22:04 +0800
Subject: [PATCH v5 2/3] arm64: dts: mt8173: Add thermal zone node.
In-Reply-To: <1450260553.7981.14.camel@mtksdaap41>
References: <1450238356-36319-1-git-send-email-dawei.chien@mediatek.com>
 <1450238356-36319-3-git-send-email-dawei.chien@mediatek.com>
 <CAGS+omDDfJb9dfWWPaMKs=MkO4Pf3RF9SUD==i7sgHsrDhFDxA@mail.gmail.com>
 <1450260553.7981.14.camel@mtksdaap41>
Message-ID: <CAGS+omCWJo6Q933tRigMsxPvOmD3-cxe337_spAMKhYSUdTUKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 6:09 PM, dawei chien <dawei.chien@mediatek.com> wrote:
> On Wed, 2015-12-16 at 16:34 +0800, Daniel Kurtz wrote:
>> On Wed, Dec 16, 2015 at 11:59 AM, Dawei Chien <dawei.chien@mediatek.com> wrote:
>> >
>> > This adds thermal zone node to Mediatek MT8173 dtsi file.
>> >
>> > Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
>> > ---
>> > This patch is base on patchset:
>> > https://lkml.org/lkml/2015/11/30/239
>> > ---
>> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi |   43 ++++++++++++++++++++++++++++++
>> >  1 file changed, 43 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> > index fda805d..4114cee 100644
>> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> > @@ -188,6 +188,49 @@
>> >                 clock-output-names = "cpum_ck";
>> >         };
>> >
>> > +       thermal-zones {
>> > +               cpu_thermal: cpu_thermal {
>> > +                       polling-delay-passive = <1000>; /* milliseconds */
>> > +                       polling-delay = <1000>; /* milliseconds */
>> > +
>> > +                       thermal-sensors = <&thermal 0>;
>>
>> This should be <&thermal> with the MTK temp sensor node in
>> https://lkml.org/lkml/2015/11/30/239 patch series.
>>
>> -Dan
>
> Hi Dan,
> Sascha's thermal driver V12 only register sensor id as 0, so we need to
> register sensor id as 0 to device tree as well.
>
> Either <&thermal 0> or <&thermal>, sensor id should be 0 for two cases.
> I try this two case, function all work fine for two cases. May I have
> any misunderstand? Please kindly give your comment.
> I will re-send this patch again once you tell me the reason, thank you.

In the new patchset, Sascha changed it to:
#thermal-sensor-cells = <0>;

Which means the <&thermal> phandle no longer has any arguments.

Thanks!
-Dan
