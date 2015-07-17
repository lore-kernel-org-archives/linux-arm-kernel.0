From: jonathanh@nvidia.com (Jon Hunter)
Date: Fri, 17 Jul 2015 08:58:03 +0100
Subject: [RESEND PATCH v3] ARM: tegra124: pmu support
In-Reply-To: <20150715093511.GA10239@leverpostej>
References: <1436808945-14524-1-git-send-email-khuey@kylehuey.com>
 <20150715093511.GA10239@leverpostej>
Message-ID: <55A8B58B.3040104@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15/07/15 10:35, Mark Rutland wrote:
> On Mon, Jul 13, 2015 at 06:35:45PM +0100, Kyle Huey wrote:
>> This patch modifies the device tree for tegra124 based devices to enable
>> the Cortex A15 PMU.  The interrupt numbers are taken from NVIDIA TRM
>> DP-06905-001_v03p.  This patch was tested on a Jetson TK1.
>>
>> Updated for proper ordering and to add interrupt-affinity values.
>>
>> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> 
> This looks sane to me, and as you've tested it the values seem to be
> valid:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

FWIW ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>


Stephen, Thierry, Alex,

Can we pick this up now?

Jon

>> ---
>>  arch/arm/boot/dts/tegra124.dtsi | 17 +++++++++++++----
>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
>> index 13cc7ca..de07d7e 100644
>> --- a/arch/arm/boot/dts/tegra124.dtsi
>> +++ b/arch/arm/boot/dts/tegra124.dtsi
>> @@ -918,31 +918,40 @@
>>  		#address-cells = <1>;
>>  		#size-cells = <0>;
>>  
>> -		cpu at 0 {
>> +		A15_0: cpu at 0 {
>>  			device_type = "cpu";
>>  			compatible = "arm,cortex-a15";
>>  			reg = <0>;
>>  		};
>>  
>> -		cpu at 1 {
>> +		A15_1: cpu at 1 {
>>  			device_type = "cpu";
>>  			compatible = "arm,cortex-a15";
>>  			reg = <1>;
>>  		};
>>  
>> -		cpu at 2 {
>> +		A15_2: cpu at 2 {
>>  			device_type = "cpu";
>>  			compatible = "arm,cortex-a15";
>>  			reg = <2>;
>>  		};
>>  
>> -		cpu at 3 {
>> +		A15_3: cpu at 3 {
>>  			device_type = "cpu";
>>  			compatible = "arm,cortex-a15";
>>  			reg = <3>;
>>  		};
>>  	};
>>  
>> +	pmu {
>> +		compatible = "arm,cortex-a15-pmu";
>> +		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-affinity = <&A15_0>, <&A15_1>, <&A15_2>, <&A15_3>;
>> +	};
>> +
>>  	thermal-zones {
>>  		cpu {
>>  			polling-delay-passive = <1000>;
>> -- 
>> 1.9.1
>>
