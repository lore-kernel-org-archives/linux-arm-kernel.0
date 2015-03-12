From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 12 Mar 2015 14:54:15 -0500
Subject: [PATCH v3 2/4] arm64: dts: Add Qualcomm MSM8916 SoC and
 evaluation board dts
In-Reply-To: <20150312182508.GF30145@leverpostej>
References: <1426107080-29079-1-git-send-email-galak@codeaurora.org>
 <1426107080-29079-2-git-send-email-galak@codeaurora.org>
 <20150312170541.GE30145@leverpostej>
 <E114AF0E-5DA9-412A-B3E2-DDD95D224C66@codeaurora.org>
 <20150312182508.GF30145@leverpostej>
Message-ID: <F0B0524B-AC0E-4E60-9A21-1208C4A978F5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mar 12, 2015, at 1:25 PM, Mark Rutland <mark.rutland@arm.com> wrote:

>>>> +	cpus {
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <0>;
>>>> +
>>>> +		CPU0: cpu at 0 {
>>>> +			device_type = "cpu";
>>>> +			compatible = "arm,cortex-a53", "arm,armv8";
>>>> +			reg = <0x0>;
>>>> +		};
>>>> +
>>>> +		CPU1: cpu at 1 {
>>>> +			device_type = "cpu";
>>>> +			compatible = "arm,cortex-a53", "arm,armv8";
>>>> +			reg = <0x1>;
>>>> +		};
>>>> +
>>>> +		CPU2: cpu at 2 {
>>>> +			device_type = "cpu";
>>>> +			compatible = "arm,cortex-a53", "arm,armv8";
>>>> +			reg = <0x2>;
>>>> +		};
>>>> +
>>>> +		CPU3: cpu at 3 {
>>>> +			device_type = "cpu";
>>>> +			compatible = "arm,cortex-a53", "arm,armv8";
>>>> +			reg = <0x3>;
>>>> +		};
>>>> +	};
>>> 
>>> The secondary CPUs need an enable-method. Are you using PSCI or
>>> spin-table?
>> 
>> This is on purpose.  We aren?t using either PSCI or spin-table.  Right
>> now the dts is for booting on a single core.  I can drop CPU1..CPU3 if
>> that helps.
> 
> We won't poke the CPUs without an enable-method, so personally I'm not
> too worried either way about having the CPUs listed.

That was my thinking, so left them in.

> Which of spin-table/psci are you planning on using for SMP support, and
> when would that be likely to appear?

We have a qcom specific SMP enablement method for this device.  This was one of our first devices so it utilized as much from arm 32-bit as possible.

> Which exception level do CPUs enter the kernel? Even without a
> virt-capable GIC booting at EL2 is less work for the FW and gives the
> kernel a better chance of fixing things up (e.g. CNTVOFF).

I think the enter in EL1.

- k
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
