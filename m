From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 8 Mar 2017 00:09:36 +0200
Subject: [PATCH DO NOT MERGE 5/6] ARM: dts: omap4: add some sample clkctrl
 data
In-Reply-To: <20170307144500.GE10239@codeaurora.org>
References: <1486992157-10673-1-git-send-email-t-kristo@ti.com>
 <1486992157-10673-6-git-send-email-t-kristo@ti.com>
 <20170307144500.GE10239@codeaurora.org>
Message-ID: <91fb553a-41fd-9290-0890-dc6cce400404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/17 16:45, Stephen Boyd wrote:
> On 02/13, Tero Kristo wrote:
>> Adds clkctrl nodes for cm_l4per and cm_abe as example. Peripherals using
>> @@ -131,27 +132,61 @@
>>  			ranges = <0 0x4a000000 0x1000000>;
>>
>>  			cm1: cm1 at 4000 {
>> -				compatible = "ti,omap4-cm1";
>> +				compatible = "ti,omap4-cm1", "simple-bus";
>>  				reg = <0x4000 0x2000>;
>> +				#address-cells = <1>;
>> +				#size-cells = <1>;
>> +				ranges = <0 0x4000 0x2000>;
>>
>>  				cm1_clocks: clocks {
>>  					#address-cells = <1>;
>>  					#size-cells = <0>;
>>  				};
>>
>> +				cm_abe: cm_abe at 0 {
>
> The unit address should be 500 here.

True.

>> +					compatible = "ti,omap4-cm";
>> +					reg = <0x500 0x100>;
>> +					#address-cells = <1>;
>> +					#size-cells = <1>;
>> +					ranges = <0 0x500 0x100>;
>> +
>> +					cm_abe_clkctrl: cm_abe_clkctrl at 20 {
>> +						compatible = "ti,omap4-clkctrl";
>> +						reg = <0x20 0x6c>;
>> +						#clock-cells = <2>;
>> +					};
>> +				};
>> +
>>  				cm1_clockdomains: clockdomains {
>>  				};
>>  			};
>>
>>  			cm2: cm2 at 8000 {
>> -				compatible = "ti,omap4-cm2";
>> +				compatible = "ti,omap4-cm2", "simple-bus";
>>  				reg = <0x8000 0x3000>;
>> +				#address-cells = <1>;
>> +				#size-cells = <1>;
>> +				ranges = <0 0x8000 0x3000>;
>>
>>  				cm2_clocks: clocks {
>>  					#address-cells = <1>;
>>  					#size-cells = <0>;
>>  				};
>>
>> +				cm_l4per: cm_l4per at 0 {
>
> and 1400 here.

Yeah, these two are obviously wrong as noted before. Will be fixed in 
the full patch I will provide hopefully next week.

-Tero

>
>> +					compatible = "ti,omap4-cm";
>> +					reg = <0x1400 0x200>;
>> +					#address-cells = <1>;
>> +					#size-cells = <1>;
>> +					ranges = <0 0x1400 0x200>;
>> +
>> +					cm_l4per_clkctrl: cm_l4per_clkctrl at 20 {
>
