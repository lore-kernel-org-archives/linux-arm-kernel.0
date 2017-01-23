From: xuwei5@hisilicon.com (Wei Xu)
Date: Mon, 23 Jan 2017 14:03:27 +0000
Subject: [V2 2/2] arm64: dts: Add dts files for Hisilicon Hi3660 SoC
In-Reply-To: <20170123134656.GC16286@leverpostej>
References: <1484034915-48879-1-git-send-email-puck.chen@hisilicon.com>
 <1484034915-48879-2-git-send-email-puck.chen@hisilicon.com>
 <20170123134656.GC16286@leverpostej>
Message-ID: <58860D2F.6070007@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 2017/1/23 13:46, Mark Rutland wrote:
> On Tue, Jan 10, 2017 at 03:55:15PM +0800, Chen Feng wrote:
>> +	memory at 0 {
>> +		device_type = "memory";
>> +		reg = <0x0 0x00400000 0x0 0xbfe00000>;
>> +	};
> 
> The unit-address here is incorrect. The base address of this memory is
> not zero.
> 
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupt-parent = <&gic>;
>> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
>> +		clock-frequency = <1920000>;
>> +	};
> 
> This clock-frequency property should not be required; please remove it.
> 
> Your FW should program CNTFRQ_EL0 with the timer frequency.

Thanks!

Hi Chen Feng,

Can you send out the v3 to address above comments?
And I will pick up it soon.

Best Regards,
Wei

> 
> Thanks,
> Mark.
> 
> .
> 
