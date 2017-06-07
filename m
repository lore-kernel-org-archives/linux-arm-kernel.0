From: thor.thayer@linux.intel.com (Thor Thayer)
Date: Wed, 7 Jun 2017 15:45:50 -0500
Subject: [PATCHv3 1/4] ARM: dts: socfpga: Add Altera I2C Controller to
 CycloneV
In-Reply-To: <73vao9vcsq.fsf@pengutronix.de>
References: <1496447559-19782-1-git-send-email-thor.thayer@linux.intel.com>
 <1496447559-19782-2-git-send-email-thor.thayer@linux.intel.com>
 <73vao9vcsq.fsf@pengutronix.de>
Message-ID: <b5b5dd02-9c07-1ecd-086d-ef668f280514@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steffen,

On 06/06/2017 01:40 AM, Steffen Trumtrar wrote:
> 
> Hi!
> 
> thor.thayer at linux.intel.com writes:
> 
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> Add the Altera I2C Controller to the CycloneV SoCFPGA device tree.
>>
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>> ---
>> v2  Remove altr, from fifo-size.
>>      Rename compatible string to "altr,softip-i2c"
>> v3  Add version to commpatible string "altr,softip-i2c-v1.0"
>> ---
>>   arch/arm/boot/dts/socfpga.dtsi               | 13 ++++++++++---
>>   arch/arm/boot/dts/socfpga_cyclone5_socdk.dts | 28 +++++++++++++++++++++++++++-
>>   2 files changed, 37 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>> index b2674bd..d69c13d 100644
>> --- a/arch/arm/boot/dts/socfpga.dtsi
>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>> @@ -133,6 +133,13 @@
>>   					#address-cells = <1>;
>>   					#size-cells = <0>;
>>   
>> +					clk_0: clk_0 {
>> +						compatible = "fixed-clock";
>> +						#clock-cells = <0>;
>> +						clock-frequency = <50000000>;
>> +						clock-output-names = "clk_0-clk";
>> +					};
>> +
>>   					osc1: osc1 {
>>   						#clock-cells = <0>;
>>   						compatible = "fixed-clock";
>> @@ -529,11 +536,11 @@
>>   				};
>>   		};
>>   
>> -		fpga_bridge0: fpga_bridge at ff400000 {
>> +		fpga_bridge0: fpga_bridge at ff200000 {
>>   			compatible = "altr,socfpga-lwhps2fpga-bridge";
>> -			reg = <0xff400000 0x100000>;
>> +			reg = <0xff200000 0x00200000>;
>>   			resets = <&rst LWHPS2FPGA_RESET>;
>> -			clocks = <&l4_main_clk>;
>> +			clocks = <&clk_0>;
>>   		};
>>
> 
> Why this change? This looks wrong and unrelated. The LWHPS2FPGA bridge
> is at 0xff400000, so it is correct the way it is or not?
> 
Yes, good point. I was using the LWHPS2FPGA slave bus so I shouldn't 
change this one. I'll add the slave version.

Thanks,

Thor
>>   		fpga_bridge1: fpga_bridge at ff500000 {
>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
>> index 155829f..f99576b 100644
>> --- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
>> +++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
>> @@ -68,6 +68,7 @@
>>   		regulator-min-microvolt = <3300000>;
>>   		regulator-max-microvolt = <3300000>;
>>   	};
>> +
>>   };
> 
> ???
> 
Whoops. I should remove the extra space. Thanks!

> 
> (...)
> 
> 
> Best regards,
> Steffen
> 
