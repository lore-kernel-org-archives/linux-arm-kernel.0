From: caesar.upstream@gmail.com (Caesar Wang)
Date: Wed, 12 Jul 2017 17:16:29 +0800
Subject: [PATCH 2/4] arm64: dts: rockchip: add ARM Mali GPU node for
 RK3399 SoCs
In-Reply-To: <4066931.s766IOqHgB@phil>
References: <1499840971-20392-1-git-send-email-wxt@rock-chips.com>
 <1499840971-20392-3-git-send-email-wxt@rock-chips.com>
 <4066931.s766IOqHgB@phil>
Message-ID: <3c3a2e24-7cb1-dc31-6532-1d6182bdf3ee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017?07?12? 15:19, Heiko Stuebner ??:
> Hi Caesar,
>
> Am Mittwoch, 12. Juli 2017, 14:29:28 CEST schrieb Caesar Wang:
>> Add Mali GPU device tree node for the RK3399 SoCs, with devfreq
>> opp table.
>>
>> RK3399 and RK3399-OP1 SoCs have a different recommendation table with
>> gpu opp. As the ARM's mali driver found on
>> https://developer.arm.com/products/software/mali-drivers/midgard-kernel.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> ---
>>
>>   arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi | 33 ++++++++++++++++++++++++
>>   arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi     | 33 ++++++++++++++++++++++++
>>   arch/arm64/boot/dts/rockchip/rk3399.dtsi         | 16 ++++++++++++
>>   3 files changed, 82 insertions(+)
> [...]
>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> index 1cbd7a2..8c6438b 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> @@ -1443,6 +1443,22 @@
>>   		status = "disabled";
>>   	};
>>   
>> +	gpu: gpu at ff9a0000 {
>> +		compatible = "arm,rk3399-mali",
>> +			     "arm,malit860",
>> +			     "arm,malit86x",
>> +			     "arm,malit8xx";
> no wildcards and correct compatibles please.
> The binding specifies arm,mali-t860 for your chip and the soc
> specific compatible needs a rockchip vendor, so you need
>
> 	compatible = "rockchip,rk3399-mali", "arm,mali-t860";
>

Okay,  sound resonable.

>> +		reg = <0x0 0xff9a0000 0x0 0x10000>;
>> +		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH 0>,
>> +			     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH 0>,
>> +			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH 0>;
>> +		interrupt-names = "GPU", "JOB", "MMU";
> interrupt names are job, mmu, gpu in lower case. The out-of-tree driver
> will need to conform to that.

Okay, we need update the ARM's mali driver to follow up.

>> +		clocks = <&cru ACLK_GPU>;
>> +		clock-names = "clk_mali";
> no clock-names property, as midgard malis only have one clock input

Sorry, I seem to be reference for the MAILI's document, not the Linux 
document.

Update these for patches v2.

Thanks your comments.

-Caesar

>
> Heiko
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
