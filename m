From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 10 Jul 2018 15:35:01 +0530
Subject: [PATCH] ARM: dts: da850: Add power-domains to CPPI 4.1 node
In-Reply-To: <e0fc938e-36f9-655f-4d4a-910527a2cc08@lechnology.com>
References: <20180704094432.5424-1-nsekhar@ti.com>
 <e0fc938e-36f9-655f-4d4a-910527a2cc08@lechnology.com>
Message-ID: <facfdccd-d06a-5286-d740-26cab6ba8e03@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 July 2018 10:32 PM, David Lechner wrote:
> On 07/04/2018 04:44 AM, Sekhar Nori wrote:
>> This adds the power-domains property to CPPI 4.1 node.
>>
>> The CPPI 4.1 DMA driver uses pm_runtime to manage the clocks,
>> so it needs this property in order to find and enable the clock
>> properly.
>>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
>> Applies for v4.19/dt branch of my tree.
>>
>> ? arch/arm/boot/dts/da850.dtsi | 1 +
>> ? 1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
>> index 9e05a5a709c0..07f215e7e5b8 100644
>> --- a/arch/arm/boot/dts/da850.dtsi
>> +++ b/arch/arm/boot/dts/da850.dtsi
>> @@ -637,6 +637,7 @@
>> ????????????????? interrupts = <58>;
>> ????????????????? #dma-cells = <2>;
>> ????????????????? #dma-channels = <4>;
>> +??????????????? power-domains = <&psc1 1>;
>> ????????????????? status = "okay";
>> ????????????? };
>> ????????? };
>>
> 
> Reviewed-by: David Lechner <david@lechnology.com>

Thanks, applied with this and Bartosz's Tested-by.

> Although this has me wondering if we can now remove the clock-ranges
> property in the parent node.

Agree its not really used. But probably leave it there since its correct
anyway and we don't want to add it back if the DMA driver needs access
to clock at some point.

Thanks,
Sekhar
