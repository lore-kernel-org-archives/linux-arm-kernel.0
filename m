From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 7 Dec 2014 09:11:17 +0800
Subject: [PATCH 02/10] ARM: dts: sun9i: Add mmc module clock nodes for A80
In-Reply-To: <20141206172449.GC12434@lukather>
References: <1417588565-26215-1-git-send-email-wens@csie.org>
 <1417588565-26215-3-git-send-email-wens@csie.org>
 <20141206172449.GC12434@lukather>
Message-ID: <CAGb2v64S7Wa5La5gS3yR2uvhc+y5szrUvapMK=cCZvHHRAPT0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Dec 7, 2014 at 1:24 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Wed, Dec 03, 2014 at 02:35:57PM +0800, Chen-Yu Tsai wrote:
>> The mmc module clocks are A80 specific module 0 (storage) type clocks.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  arch/arm/boot/dts/sun9i-a80.dtsi | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
>> index 494714f..33d18dc 100644
>> --- a/arch/arm/boot/dts/sun9i-a80.dtsi
>> +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
>> @@ -215,6 +215,38 @@
>>                       clock-output-names = "cci400";
>>               };
>>
>> +             mmc0_clk: clk at 06000410 {
>> +                     #clock-cells = <0>;
>> +                     compatible = "allwinner,sun9i-a80-mod0-clk";
>> +                     reg = <0x06000410 0x4>;
>> +                     clocks = <&osc24M>, <&pll4>;
>> +                     clock-output-names = "mmc0";
>> +             };
>> +
>> +             mmc1_clk: clk at 06000414 {
>> +                     #clock-cells = <0>;
>> +                     compatible = "allwinner,sun9i-a80-mod0-clk";
>> +                     reg = <0x06000414 0x4>;
>> +                     clocks = <&osc24M>, <&pll4>;
>> +                     clock-output-names = "mmc1";
>> +             };
>> +
>> +             mmc2_clk: clk at 06000418 {
>> +                     #clock-cells = <0>;
>> +                     compatible = "allwinner,sun9i-a80-mod0-clk";
>> +                     reg = <0x06000418 0x4>;
>> +                     clocks = <&osc24M>, <&pll4>;
>> +                     clock-output-names = "mmc2";
>> +             };
>> +
>> +             mmc3_clk: clk at 0600041c {
>> +                     #clock-cells = <0>;
>> +                     compatible = "allwinner,sun9i-a80-mod0-clk";
>> +                     reg = <0x0600041c 0x4>;
>> +                     clocks = <&osc24M>, <&pll4>;
>> +                     clock-output-names = "mmc3";
>> +             };
>> +
>
> How is the phase stuff supposed to work? Is this still used on the A80?

It is. This time, the register bits are actually documented.

> Also, wasn't the mux supposed to have 4 bits (so something like at
> least 9 parent clocks?) given your previous patch?

The mux has 4 bits of valid settings. But only the first 2 have
valid parent clocks. I suppose I should make it clear in the bindings?

Some of the other module clocks have parents on the first 2 and last
2 valid settings, so we'll need to use a mux table for them.


ChenYu
