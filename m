From: vigneshr@ti.com (Vignesh R)
Date: Mon, 3 Aug 2015 10:36:44 +0530
Subject: [RFC PATCH 4/5] ARM: dts: DRA7: Add memory map region entries
 for qspi
In-Reply-To: <20150731212847.GH10676@google.com>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
 <1438072876-16338-5-git-send-email-vigneshr@ti.com>
 <20150731212847.GH10676@google.com>
Message-ID: <55BEF6E4.2000905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/01/2015 02:58 AM, Brian Norris wrote:
> On Tue, Jul 28, 2015 at 02:11:15PM +0530, Vignesh R wrote:
>> Add qspi memory mapped region entries for DRA7xx based SoCs.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>  arch/arm/boot/dts/am4372.dtsi | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
>> index ade28c790f4b..5317a0f24ab9 100644
>> --- a/arch/arm/boot/dts/am4372.dtsi
>> +++ b/arch/arm/boot/dts/am4372.dtsi
>> @@ -902,7 +902,9 @@
>>  
>>  		qspi: qspi at 47900000 {
>>  			compatible = "ti,am4372-qspi";
>> -			reg = <0x47900000 0x100>;
>> +			reg = <0x47900000 0x100>,
>> +			      <0x30000000 0x3ffffff>;
> 
> Are you sure this region is 1 byte shy of 64MB in length? Same question
> for patch 5.
> 

Oops, my bad... Its 64MB in length, I entered offset of last byte
instead of length. Will correct this in the actual patch.

>> +			reg-names = "qspi_base", "qspi_mmap";
>>  			#address-cells = <1>;
>>  			#size-cells = <0>;
>>  			ti,hwmods = "qspi";
>> -- 
>> 2.4.6
>>

-- 
Regards
Vignesh
