From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 4 Dec 2015 10:32:12 +0200
Subject: [PATCH v2 13/14] ARM: DTS: am33xx: Use the new DT bindings for
 the eDMA3
In-Reply-To: <20151204005440.GE23396@atomide.com>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
 <1444979892-31626-14-git-send-email-peter.ujfalusi@ti.com>
 <20151204005440.GE23396@atomide.com>
Message-ID: <56614F8C.9080106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/2015 02:54 AM, Tony Lindgren wrote:
> Hi Peter,
> 
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [151016 00:23]:
> 
> I noticed something while changing dm81xx to use the edma_xbar..
> 
>> --- a/arch/arm/boot/dts/am33xx.dtsi
>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>> +
>> +		edma_xbar: dma-router at 44e10f90 {
>> +			compatible = "ti,am335x-edma-crossbar";
>> +			reg = <0x44e10f90 0x40>;
>> +
>> +			#dma-cells = <3>;
>> +			dma-requests = <32>;
>> +
>> +			dma-masters = <&edma>;
>>  		};
> 
> The edma_xbar should now be just a child at offset 0xf90 under the
> scm: scm at 210000. Can you please check the other patches too?

Thanks Tony,

I'll make sure they are in the correct place when resending them.

-- 
P?ter
