From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Tue, 30 Jan 2018 15:55:11 +0530
Subject: [PATCH 1/2] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
In-Reply-To: <20180130094816.GJ28313@codeaurora.org>
References: <20180125163216.29018-1-rnayak@codeaurora.org>
 <20180125163216.29018-2-rnayak@codeaurora.org>
 <20180126221501.GD28313@codeaurora.org>
 <514c49cc-71f9-ee21-250a-04f8fab151c0@codeaurora.org>
 <20180130094816.GJ28313@codeaurora.org>
Message-ID: <3ce97519-bc3d-d234-b10e-bd21b263cc73@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/30/2018 03:18 PM, Stephen Boyd wrote:
>>>> +	};
>>>> +
>>>> +	timer {
>>>> +		compatible = "arm,armv8-timer";
>>>> +		interrupts = <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>>> Are we supposed to use the GIC_CPU_MASK_SIMPLE macros still?
>> Not sure, is there another way?
> Me either. See this thread from Marc[1]. I guess just drop them?
> 
> [1] http://lkml.iu.edu/hypermail/linux/kernel/1702.0/03522.html

thanks, Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt does seem to explain
how to specify PPI CPU affinity for GICv3 using a 4th cell if needed which I hadn't read :/

I'll send in a patch to get rid of them on 8996 as well.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
