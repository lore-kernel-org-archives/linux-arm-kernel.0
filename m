From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 21 May 2015 17:34:06 +0200
Subject: [PATCH 5/5] ARM64: MediaTek MT8173: Add SCPSYS device node
In-Reply-To: <CAGS+omDHEY54TzhNTJcFOeHkGbXAQwiTh9gxc=PsbzjwmpHEDA@mail.gmail.com>
References: <1432131540-2523-1-git-send-email-s.hauer@pengutronix.de>
 <1432131540-2523-6-git-send-email-s.hauer@pengutronix.de>
 <CAGS+omDHEY54TzhNTJcFOeHkGbXAQwiTh9gxc=PsbzjwmpHEDA@mail.gmail.com>
Message-ID: <CABuKBeKmdjhmUprdibJHsKo4JfQ4vzX2SsCnobfpKSQn_PsGHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-21 16:32 GMT+02:00 Daniel Kurtz <djkurtz@chromium.org>:
> On Wed, May 20, 2015 at 10:19 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> This adds the SCPSYS device node to the MT8173 dtsi file.
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> ---
>>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> index 924fdb6..12430f0 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> @@ -125,6 +125,16 @@
>>                                                 <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
>>                 };
>>
>> +               scpsys: scpsys at 10006000 {
>> +                       compatible = "mediatek,mt8173-scpsys";
>> +                       #power-domain-cells = <1>;
>> +                       reg = <0 0x10006000 0 0x1000>;
>> +                       clocks = <&clk26m>,
>
> Why is mfg using <&clk26m> and not <&topckgen CLK_TOP_MFG_SEL>?
> I saw another patch set on the list today from James Liao that adds more clocks.
> Perhaps we can move the SCPSYS set on top of that one and include more clocks?
>
>> +                                <&topckgen CLK_TOP_MM_SEL>;
>
> FYI: the devicetree changes in this set depend on your other patch set
> starting with:
>
> https://patchwork.kernel.org/patch/6446341/
> "arm64: dts: mt8173: Add clock controller device nodes"
>
> This patch isn't based on top of the other set, though, so it may lead
> to a small merge conflict when folding in the .dtsi device nodes (ie,
> placing scpsys at 10006000 after pwrap at 1000d000).
>
> I'm not sure how people usually resolve this or manage the ordering of
> co-dependent patch sets upstream.

At the moment I suppose that patch-sets are based on -rc1 if not
stated different.

-- 
motzblog.wordpress.com
