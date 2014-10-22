From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 22 Oct 2014 19:18:19 -0300
Subject: [PATCH 6/7] ARM: mvebu: Enable Performance Monitor Unit on Armada
 380/385 SoC
In-Reply-To: <20141022140616.GM22642@leverpostej>
References: <1413985427-20918-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1413985427-20918-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141022140616.GM22642@leverpostej>
Message-ID: <54482D2B.8030107@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2014 11:06 AM, Mark Rutland wrote:
> On Wed, Oct 22, 2014 at 02:43:46PM +0100, Ezequiel Garcia wrote:
>> The Armada 380 and 385 SoCs have a Cortex-A9 CPU, so the PMU is available
>> to be used. This commit enables it in the devicetree.
>>
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>> ---
>>  arch/arm/boot/dts/armada-38x.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
>> index 242d0ec..bba3c90 100644
>> --- a/arch/arm/boot/dts/armada-38x.dtsi
>> +++ b/arch/arm/boot/dts/armada-38x.dtsi
>> @@ -30,6 +30,11 @@
>>  		eth2 = &eth2;
>>  	};
>>  
>> +	pmu {
>> +		compatible = "arm,cortex-a9-pmu";
>> +		interrupts-extended = <&mpic 3>;
>> +	};
> 
> Is there not a separate interrupt for CPU1 on Armada 385?
> 

As I explained in my reply to PATCH 5/7, this is a per cpu interrupt.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
