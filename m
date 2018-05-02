From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 02 May 2018 19:34:21 +0800
Subject: [linux-sunxi] Re: [PATCH 02/21] arm64: dts: allwinner: a64: Add
 DE2 CCU
In-Reply-To: <20180502113250.5i2eyzv237t5oyl6@flea>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-3-jagan@amarulasolutions.com>
 <20180502113250.5i2eyzv237t5oyl6@flea>
Message-ID: <DF02AB5F-D4A5-4198-B455-FEE880CF83CE@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?5?2? GMT+08:00 ??7:32:50, Maxime Ripard <maxime.ripard@bootlin.com> ??:
>On Mon, Apr 30, 2018 at 05:10:39PM +0530, Jagan Teki wrote:
>> DE2 in A64 has clock control unit and behavior is
>> same like H3/H5, so reuse the same in A64.
>> 
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> ---
>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> index 1b2ef28c42bd..67b80bbe5bf5 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> @@ -43,9 +43,11 @@
>>   */
>>  
>>  #include <dt-bindings/clock/sun50i-a64-ccu.h>
>> +#include <dt-bindings/clock/sun8i-de2.h>
>>  #include <dt-bindings/clock/sun8i-r-ccu.h>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  #include <dt-bindings/reset/sun50i-a64-ccu.h>
>> +#include <dt-bindings/reset/sun8i-de2.h>
>>  
>>  / {
>>  	interrupt-parent = <&gic>;
>> @@ -168,6 +170,19 @@
>>  		#size-cells = <1>;
>>  		ranges;
>>  
>> +		display_clocks: clock at 1000000 {
>> +			compatible = "allwinner,sun50i-a64-de2-clk",
>> +				     "allwinner,sun50i-h5-de2-clk";
>
>The A64 was released before the H5, so that should be the other way
>around.
>
>> +			reg = <0x01000000 0x100000>;
>> +			clocks = <&ccu CLK_DE>,
>> +				 <&ccu CLK_BUS_DE>;
>> +			clock-names = "mod",
>> +				      "bus";
>> +			resets = <&ccu RST_BUS_DE>;
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +		};
>> +
>
>So it turns out we don't need the SRAM to access the CCU driver?

As now U-Boot claims SRAM, people may forget thus :-(

>
>Maxime
