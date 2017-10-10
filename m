From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 10 Oct 2017 13:06:42 +0200
Subject: [PATCH v4 03/12] arm64: dts: mt8173: remove "mediatek, mt8135-mmc"
 from mmc nodes
In-Reply-To: <CAPDyKFrtBr_f2HxsNsLQ1s+-9Toni8pC82gFdVcHY+oQSPqOBA@mail.gmail.com>
References: <1507627831-29323-1-git-send-email-chaotian.jing@mediatek.com>
 <1507627831-29323-4-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFrtBr_f2HxsNsLQ1s+-9Toni8pC82gFdVcHY+oQSPqOBA@mail.gmail.com>
Message-ID: <bbbe8b1e-4ac8-95cf-5e47-24a9cac8cffc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/10/2017 12:49 PM, Ulf Hansson wrote:
> On 10 October 2017 at 11:30, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>> devicetree bindings has been updated to support multi-platforms,
>> so that each platform has its owns compatible name.
>> And, this compatible name may used in driver to distinguish with
>> other platform.
>>
>> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> 
> I assume there is no dependency to the rest or the series on this, so
> this can go via arm soc?
> 


Not in the sense of a merge conflict or something, but mt8173-mmc won't work 
until patch 2/12 is merged as well. If we want to be conservative, we should 
wait for this patch until the next kernel release. In the end it's just a 
cleanup of the dtsi.

Regards,
Matthias

> Kind regards
> Uffe
> 
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 12 ++++--------
>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> index b99a273..26396ef 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> @@ -682,8 +682,7 @@
>>                  };
>>
>>                  mmc0: mmc at 11230000 {
>> -                       compatible = "mediatek,mt8173-mmc",
>> -                                    "mediatek,mt8135-mmc";
>> +                       compatible = "mediatek,mt8173-mmc";
>>                          reg = <0 0x11230000 0 0x1000>;
>>                          interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_LOW>;
>>                          clocks = <&pericfg CLK_PERI_MSDC30_0>,
>> @@ -693,8 +692,7 @@
>>                  };
>>
>>                  mmc1: mmc at 11240000 {
>> -                       compatible = "mediatek,mt8173-mmc",
>> -                                    "mediatek,mt8135-mmc";
>> +                       compatible = "mediatek,mt8173-mmc";
>>                          reg = <0 0x11240000 0 0x1000>;
>>                          interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_LOW>;
>>                          clocks = <&pericfg CLK_PERI_MSDC30_1>,
>> @@ -704,8 +702,7 @@
>>                  };
>>
>>                  mmc2: mmc at 11250000 {
>> -                       compatible = "mediatek,mt8173-mmc",
>> -                                    "mediatek,mt8135-mmc";
>> +                       compatible = "mediatek,mt8173-mmc";
>>                          reg = <0 0x11250000 0 0x1000>;
>>                          interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_LOW>;
>>                          clocks = <&pericfg CLK_PERI_MSDC30_2>,
>> @@ -715,8 +712,7 @@
>>                  };
>>
>>                  mmc3: mmc at 11260000 {
>> -                       compatible = "mediatek,mt8173-mmc",
>> -                                    "mediatek,mt8135-mmc";
>> +                       compatible = "mediatek,mt8173-mmc";
>>                          reg = <0 0x11260000 0 0x1000>;
>>                          interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_LOW>;
>>                          clocks = <&pericfg CLK_PERI_MSDC30_3>,
>> --
>> 1.8.1.1.dirty
>>
