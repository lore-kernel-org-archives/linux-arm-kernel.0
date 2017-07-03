From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 03 Jul 2017 15:35:05 +0200
Subject: [PATCH] ARM64: dts: marvell: armada37xx: Fix timer interrupt
 specifiers
In-Reply-To: <871sqazxc3.fsf@free-electrons.com> (Gregory CLEMENT's message of
 "Fri, 23 Jun 2017 14:45:48 +0200")
References: <20170621214508.7810-1-marc.zyngier@arm.com>
 <871sqazxc3.fsf@free-electrons.com>
Message-ID: <877ezpve2e.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On ven., juin 23 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Marc,
>  
>  On mer., juin 21 2017, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
>> Contrary to popular belief, PPIs connected to a GICv3 to not have
>> an affinity field similar to that of GICv2. That is consistent
>> with the fact that GICv3 is designed to accomodate thousands of
>> CPUs, and fitting them as a bitmap in a byte is... difficult.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>
> Applied on mvebu/fixes

As I missed the end of the merge window for 4.12, I've just moved this
patch on mvebu/dt64 wit the hope that it can be applied on a late dt
branch on arm-soc for 4.13.

I also added the "Fixes" and "CC: stable" tags in order to propagate the
fix on older kernel.

Gregory

>
>> ---
>>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
>> index 4d495ec39202..bc179efb10ef 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
>> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
>> @@ -75,14 +75,10 @@
>>  
>>  	timer {
>>  		compatible = "arm,armv8-timer";
>> -		interrupts = <GIC_PPI 13
>> -			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
>> -			     <GIC_PPI 14
>> -			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
>> -			     <GIC_PPI 11
>> -			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
>> -			     <GIC_PPI 10
>> -			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
>> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
>>  	};
>>  
>>  	soc {
>> -- 
>> 2.11.0
>>
>
> -- 
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
