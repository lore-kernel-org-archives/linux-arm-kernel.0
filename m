From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 19 May 2014 16:44:41 +0300
Subject: [PATCH 2/2] ARM: DTS: omap54xx-clocks: Correct abe_iclk clock node
In-Reply-To: <5360ED2A.5070605@ti.com>
References: <1398858096-32144-1-git-send-email-peter.ujfalusi@ti.com>
 <1398858096-32144-2-git-send-email-peter.ujfalusi@ti.com>
 <5360ED2A.5070605@ti.com>
Message-ID: <537A0AC9.7040607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2014 03:31 PM, Tero Kristo wrote:
> On 04/30/2014 02:41 PM, Peter Ujfalusi wrote:
>> abe_iclk's parent is aess_fclk and not abe_clk.
>> Also correct the parameters for clock rate calculation as used for OMAP4
>> since in PRCM level there's no difference between the two platform
>> regarding to AESS/ABE clocking.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>
> Acked-by: Tero Kristo <t-kristo@ti.com>

Queued also for 3.15-rc/clk-dt.

-Tero

>
>> ---
>>   arch/arm/boot/dts/omap54xx-clocks.dtsi | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi
>> b/arch/arm/boot/dts/omap54xx-clocks.dtsi
>> index d784ff5d3904..86fc507a0567 100644
>> --- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
>> +++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
>> @@ -143,10 +143,11 @@
>>
>>       abe_iclk: abe_iclk {
>>           #clock-cells = <0>;
>> -        compatible = "fixed-factor-clock";
>> -        clocks = <&abe_clk>;
>> -        clock-mult = <1>;
>> -        clock-div = <2>;
>> +        compatible = "ti,divider-clock";
>> +        clocks = <&aess_fclk>;
>> +        ti,bit-shift = <24>;
>> +        reg = <0x0528>;
>> +        ti,dividers = <2>, <1>;
>>       };
>>
>>       abe_lp_clk_div: abe_lp_clk_div {
>>
>
