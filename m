From: tthayer@opensource.altera.com (Thor Thayer)
Date: Tue, 8 Mar 2016 09:59:51 -0600
Subject: [PATCHv2 11/11] ARM: dts: Add Altera Arria10 L2 Cache EDAC
 devicetree entry
In-Reply-To: <56DEE6AE.100@opensource.altera.com>
References: <1457379787-8327-1-git-send-email-tthayer@opensource.altera.com>
 <1457379787-8327-12-git-send-email-tthayer@opensource.altera.com>
 <56DEE6AE.100@opensource.altera.com>
Message-ID: <56DEF6F7.1030100@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

On 03/08/2016 08:50 AM, Dinh Nguyen wrote:
>
>
> On 03/07/2016 01:43 PM, tthayer at opensource.altera.com wrote:
>> From: Thor Thayer <tthayer@opensource.altera.com>
>>
>> Add the device tree entries needed to support the Altera L2
>> cache EDAC on the Arria10 chip.
>>
>> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
>> ---
>> v2 Match register value (l2-ecc at ffd06010)
>> ---
>>   arch/arm/boot/dts/socfpga_arria10.dtsi |   14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
>> index cce9e50..44aeb3f 100644
>> --- a/arch/arm/boot/dts/socfpga_arria10.dtsi
>> +++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
>> @@ -599,6 +599,20 @@
>>   			reg = <0xffe00000 0x40000>;
>>   		};
>>
>> +		eccmgr: eccmgr at ffd06090 {
>> +			compatible = "altr,socfpga-ecc-manager";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +
>> +			l2-ecc at ffd06010 {
>> +				compatible = "altr,socfpga-a10-l2-ecc";
>> +				reg = <0xffd06010 0x4>;
>> +				interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>,
>> +					     <0 0 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +		};
>> +
>
> Just checking if these addresses are correct. The eccmgr is at
> 0xffd06090, but the l2-ecc is at 0xffd06010? I would have thought from
> the placement the l2-ecc address would be inside the eccmgr's address?
>
> Dinh
>

Yes, this is confusing and I'll clarify/reorganize in the next series. 
The eccmgr is pointing to the ECC IRQ mask bits. These registers and the 
L2 ECC registers are organized in different areas within the system manager.

I'm actually redoing the series since the Arria10 IRQ handling is 
significantly different.

Since this change will affect the bindings and dti (the eccmgr will have 
the IRQs), please disregard this series.

Sorry for the noise.

Thor
