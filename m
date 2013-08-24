From: joelf@ti.com (Joel Fernandes)
Date: Sat, 24 Aug 2013 13:33:16 -0500
Subject: [PATCH] ARM: dts: add AM33XX EDMA support
In-Reply-To: <5218F519.3040409@cogentembedded.com>
References: <1377284808-32412-1-git-send-email-bigeasy@linutronix.de>
 <5218F519.3040409@cogentembedded.com>
Message-ID: <5218FC6C.6000002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updating CC with Matt's current email address.

On 08/24/2013 01:02 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 08/23/2013 11:06 PM, Sebastian Andrzej Siewior wrote:
> 
>> From: Matt Porter <mdp@ti.com>
> 
>> Adds AM33XX EDMA support to the am33xx.dtsi as documented in
>> Documentation/devicetree/bindings/dma/ti-edma.txt
> 
>> Joel: Drop DT entries that are non-hardware-description for now as discussed
>> in [1]
> 
>> [1] https://patchwork.kernel.org/patch/2226761/
> 
>> Signed-off-by: Matt Porter <mporter@ti.com>
>> Signed-off-by: Joel A Fernandes <joelagnel@ti.com>
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>> Could someone please pick this up?
> 
>>   arch/arm/boot/dts/am33xx.dtsi | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
> 
>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>> index 38b446b..784f774 100644
>> --- a/arch/arm/boot/dts/am33xx.dtsi
>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>> @@ -96,6 +96,18 @@
>>               reg = <0x48200000 0x1000>;
>>           };
>>
>> +        edma: edma at 49000000 {
> 
>    The node should be named "dma-controller", not "edma",according to ePAPR
> section 2.2.2:
> 
> http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

So you mean something like the following?

edma: dma-controller at 49000000 {
  ...
}


Thanks,

-Joel
