From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 1 Aug 2014 08:09:31 +0300
Subject: [PATCH 2/6] ARM: DTS: da850: Add node for edma0
In-Reply-To: <53DA5230.1050200@cogentembedded.com>
References: <1406801934-23334-1-git-send-email-peter.ujfalusi@ti.com>
 <1406801934-23334-3-git-send-email-peter.ujfalusi@ti.com>
 <53DA5230.1050200@cogentembedded.com>
Message-ID: <53DB210B.5010204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2014 05:26 PM, Sergei Shtylyov wrote:
> On 07/31/2014 02:18 PM, Peter Ujfalusi wrote:
> 
>> Add DT node for edma0.
> 
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>   arch/arm/boot/dts/da850.dtsi | 6 ++++++
>>   1 file changed, 6 insertions(+)
> 
>> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
>> index b695548dbb4e..41ce4e8bf227 100644
>> --- a/arch/arm/boot/dts/da850.dtsi
>> +++ b/arch/arm/boot/dts/da850.dtsi
>> @@ -150,6 +150,12 @@
>>               };
>>
>>           };
>> +        edma0: edma at 01c00000 {
>> +            compatible = "ti,edma3";
>> +            reg =    <0x0 0x10000>;
> 
>    Why the mismatch between the unit-address part of the node name and the
> "reg" property?

For some reason the whole da850 uses offset from 0x01c00000 for the SoC IPs.
The nodes are under 'soc' and that has the ranges attribute.
I do not really like this either.

> 
>> +            interrupts = <11 13 12>;
>> +            #dma-cells = <1>;
>> +        };
> 
> WBR, Sergei
> 

-- 
P?ter
