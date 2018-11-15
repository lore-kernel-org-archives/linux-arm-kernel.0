From: pn@denx.de (Parthiban Nallathambi)
Date: Thu, 15 Nov 2018 13:51:59 +0100
Subject: [PATCH] arm64: dts: actions: s700: Add I2C controller nodes
In-Reply-To: <20181115111217.GC15537@Mani-XPS-13-9360>
References: <20181113133235.37754-1-pn@denx.de>
 <20181115111217.GC15537@Mani-XPS-13-9360>
Message-ID: <f3364954-d1af-af41-2619-449b401140b8@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/15/18 12:12 PM, Manivannan Sadhasivam wrote:
> Hi Parthiban,
> 
> On Tue, Nov 13, 2018 at 02:32:35PM +0100, Parthiban Nallathambi wrote:
>> Add I2C controller nodes for Actions Semiconductor S700 SoC.
>>
>> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
>> ---
>>   arch/arm64/boot/dts/actions/s700.dtsi | 40 +++++++++++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
>> index 192c7b39c8c1..573c844d7afe 100644
>> --- a/arch/arm64/boot/dts/actions/s700.dtsi
>> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
>> @@ -174,6 +174,46 @@
>>   			#clock-cells = <1>;
>>   		};
>>   
>> +		i2c0: i2c at e0170000 {
>> +			compatible = "actions,s900-i2c";
> 
> Why don't you add a compatible for S700? Also, please add the pinctrl
> nodes for these busses and enable the ones exposed on board. These could
> go in a separate patch.

Makes sense as pinctrl is already fine. Will do in v2 as series!

Thanks,
Parthi
> 
> Thanks,
> Mani
> 
>> +			reg = <0 0xe0170000 0 0x1000>;
>> +			clocks = <&cmu CLK_I2C0>;
>> +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		i2c1: i2c at e0174000 {
>> +			compatible = "actions,s900-i2c";
>> +			reg = <0 0xe0174000 0 0x1000>;
>> +			clocks = <&cmu CLK_I2C1>;
>> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		i2c2: i2c at e0178000 {
>> +			compatible = "actions,s900-i2c";
>> +			reg = <0 0xe0178000 0 0x1000>;
>> +			clocks = <&cmu CLK_I2C2>;
>> +			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		i2c3: i2c at e017c000 {
>> +			compatible = "actions,s900-i2c";
>> +			reg = <0 0xe017c000 0 0x1000>;
>> +			clocks = <&cmu CLK_I2C3>;
>> +			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>>   		sps: power-controller at e01b0100 {
>>   			compatible = "actions,s700-sps";
>>   			reg = <0x0 0xe01b0100 0x0 0x100>;
>> -- 
>> 2.17.2
>>
> 

-- 
Thanks,
Parthiban N

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-22 Fax: (+49)-8142-66989-80 Email: pn at denx.de
