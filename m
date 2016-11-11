From: anurupvasu@gmail.com (Anurup M)
Date: Fri, 11 Nov 2016 17:29:05 +0530
Subject: [RESEND PATCH v1 02/11] dt-bindings: hisi: Add Hisilicon
 HiP05/06/07 Sysctrl and Djtag dts bindings
In-Reply-To: <20161111115346.GC11945@leverpostej>
References: <1478151727-20250-1-git-send-email-anurup.m@huawei.com>
 <1478151727-20250-3-git-send-email-anurup.m@huawei.com>
 <20161110172320.GA10137@leverpostej> <5825A927.2000202@gmail.com>
 <20161111115346.GC11945@leverpostej>
Message-ID: <5825B289.9020606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 11 November 2016 05:23 PM, Mark Rutland wrote:
> On Fri, Nov 11, 2016 at 04:49:03PM +0530, Anurup M wrote:
>> On Thursday 10 November 2016 10:53 PM, Mark Rutland wrote:
>>> On Thu, Nov 03, 2016 at 01:41:58AM -0400, Anurup M wrote:
>>>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>>>> +Example:
>>>> +	/* for Hisilicon HiP05 djtag for CPU sysctrl */
>>>> +	djtag0: djtag at 80010000 {
>>>> +		compatible = "hisilicon,hip05-cpu-djtag-v1";
>>>> +		reg = <0x0 0x80010000 0x0 0x10000>;
>>>> +
>>>> +		/* For L3 cache PMU */
>>>> +		pmul3c0 {
>>>> +			compatible = "hisilicon,hisi-pmu-l3c-v1";
>>>> +			scl-id = <0x02>;
>>>> +			num-events = <0x16>;
>>>> +			num-counters = <0x08>;
>>>> +			module-id = <0x04>;
>>>> +			num-banks = <0x04>;
>>>> +			cfgen-map = <0x02 0x04 0x01 0x08>;
>>>> +			counter-reg = <0x170>;
>>>> +			evctrl-reg = <0x04>;
>>>> +			event-en = <0x1000000>;
>>>> +			evtype-reg = <0x140>;
>>>> +		};
>>> This sub-node needs a binding document.
>>>
>>> These properties are completely opaque
>> The L3 cache PMU bindings are defined @bindings/arm/hisilicon/pmu.txt.
>> Is it OK that I document here(hisilicon/djtag.txt), a reference to
>> the PMU bindings doc ?
> At this point in the series, that file does not exist yet, and this is
> an undocumented beinding.
>
> Please introduce this sub-node long with the PMU bindings, later in the
> series.
Thanks, I got your suggestion. Will add this later in series.
> Thanks,
> Mark.
