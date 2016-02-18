From: ddaney@caviumnetworks.com (David Daney)
Date: Thu, 18 Feb 2016 10:37:45 -0800
Subject: [PATCH v4 3/5] arm64: dts: Add Cavium ThunderX specific PMU
In-Reply-To: <20160218173248.GD16883@arm.com>
References: <cover.1455810755.git.jglauber@cavium.com>
 <2b8c963d3e63ecfc412bfd6fab804890a1586b16.1455810755.git.jglauber@cavium.com>
 <20160218173248.GD16883@arm.com>
Message-ID: <56C60F79.5060908@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2016 09:32 AM, Will Deacon wrote:
> On Thu, Feb 18, 2016 at 05:50:12PM +0100, Jan Glauber wrote:
>> Add a compatible string for the Cavium ThunderX PMU.
>
> Stupid question, but is "thunder" the name of the CPU or the SoC or ...?

At a high level Cavium ThunderX (tm) is a family of SoCs.  Since the SoC 
contains many different functional blocks ...

>
> Whatever we use to describe the PMU, should probably also identify the
> CPU uniquely.

... In the context of this patch, "cavium,thunder-pmu" refers to the PMU 
of Cavium's implementation of the ARMv8 Processing Element (PE) 
specification (i.e. the CPU), as found on the CN88XX family of SoCs.

If we think of this in terms of MIDR_EL1, That would be:

    Implementer: 0x43
    PartNum: 0xA1


>
> Will
>
>> Signed-off-by: Jan Glauber <jglauber@cavium.com>
>> ---
>>   Documentation/devicetree/bindings/arm/pmu.txt | 1 +
>>   arch/arm64/boot/dts/cavium/thunder-88xx.dtsi  | 5 +++++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
>> index 5651883..d3999a1 100644
>> --- a/Documentation/devicetree/bindings/arm/pmu.txt
>> +++ b/Documentation/devicetree/bindings/arm/pmu.txt
>> @@ -25,6 +25,7 @@ Required properties:
>>   	"qcom,scorpion-pmu"
>>   	"qcom,scorpion-mp-pmu"
>>   	"qcom,krait-pmu"
>> +	"cavium,thunder-pmu"
>>   - interrupts : 1 combined interrupt or 1 per core. If the interrupt is a per-cpu
>>                  interrupt (PPI) then 1 interrupt should be specified.
>>
>> diff --git a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
>> index 9cb7cf9..2eb9b22 100644
>> --- a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
>> +++ b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
>> @@ -360,6 +360,11 @@
>>   		             <1 10 0xff01>;
>>   	};
>>
>> +	pmu {
>> +		compatible = "cavium,thunder-pmu", "arm,armv8-pmuv3";
>> +		interrupts = <1 7 4>;
>> +	};
>> +
>>   	soc {
>>   		compatible = "simple-bus";
>>   		#address-cells = <2>;
>> --
>> 1.9.1
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
