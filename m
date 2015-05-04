From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 4 May 2015 23:25:18 +0800
Subject: [PATCH v2 4/5] ARM: dts: sun9i: Add A80 PRCM clocks and reset
 control nodes
In-Reply-To: <20150504130546.GC3274@lukather>
References: <1430410206-4410-1-git-send-email-wens@csie.org>
 <1430410206-4410-5-git-send-email-wens@csie.org>
 <20150504130546.GC3274@lukather>
Message-ID: <CAGb2v676gpGKm+9vHLnfvhJ=tCyRAkE2G7Pi87oNsWmJJ5+ROg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 4, 2015 at 9:05 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, May 01, 2015 at 12:10:05AM +0800, Chen-Yu Tsai wrote:
>> This adds the PRCM clocks and reset controls to the A80 dtsi.
>>
>> The list of apbs clock gates is incomplete. Tests show that bits 0~20
>> are mutable. We will need documents from Allwinner to complete the
>> support.
>>
>> Also update clock and reset phandles for r_uart.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/boot/dts/sun9i-a80.dtsi | 64 +++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
>> index d3dece2eea72..f0869ff8006f 100644
>> --- a/arch/arm/boot/dts/sun9i-a80.dtsi
>> +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
>> @@ -169,6 +169,14 @@
>>                                            "usb_phy2", "usb_hsic_12M";
>>               };
>>
>> +             pll3: clk at 06000008 {
>> +                     /* placeholder until implemented */
>> +                     #clock-cells = <0>;
>> +                     compatible = "fixed-clock";
>> +                     clock-rate = <0>;
>> +                     clock-output-names = "pll3";
>> +             };
>> +
>>               pll4: clk at 0600000c {
>>                       #clock-cells = <0>;
>>                       compatible = "allwinner,sun9i-a80-pll4-clk";
>> @@ -751,13 +759,67 @@
>>                       interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>>               };
>>
>> +             prcm at 08001400 {
>> +                     compatible = "allwinner,sun9i-a80-prcm";
>> +                     reg = <0x08001400 0x200>;
>> +
>> +                     cpus_clk: cpus_clk {
>
> I wonder whether it would not be more readable to have this as
> clk@<prcm_offset>, just like all the other clocks?

I agree it is more readable, though it is purely aesthetics. What offset
did you have in mind? Offset from PRCM base (0x08001400)? Or the complete
address?

Since I'm sending a new version anyway, I can make this change.

ChenYu
