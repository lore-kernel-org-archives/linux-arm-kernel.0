From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue, 29 Apr 2014 13:33:59 +0530
Subject: [PATCH-RESEND] ARM: dts: Add arm-pmu node for exynos4412
In-Reply-To: <00f501cf6378$2efd6ee0$8cf84ca0$@samsung.com>
References: <1376044914-1759-1-git-send-email-chanho61.park@samsung.com>
 <535F41B1.70404@linaro.org> <00f501cf6378$2efd6ee0$8cf84ca0$@samsung.com>
Message-ID: <535F5CEF.10504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2014 12:26 PM, Chanho Park wrote:
> Hi Tushar,
> 
>> -----Original Message-----
>> From: Tushar Behera [mailto:tushar.behera at linaro.org]
>> Sent: Tuesday, April 29, 2014 3:08 PM
>> To: Chanho Park; kgene.kim at samsung.com
>> Cc: linux-samsung-soc at vger.kernel.org; thomas.abraham at linaro.org; linux-
>> arm-kernel at lists.infradead.org; Kyungmin Park
>> Subject: Re: [PATCH-RESEND] ARM: dts: Add arm-pmu node for exynos4412
>>
>> On 08/09/2013 04:11 PM, Chanho Park wrote:
>>> The Exynos4412 has 4 cpus and each has a performance counter.
>>> Thus, we should define 4 interrupts which are combined by irq-combiner
>> for arm
>>> pmu.
>>>
>>> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>> ---
>>>  arch/arm/boot/dts/exynos4412.dtsi |    6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos4412.dtsi
>> b/arch/arm/boot/dts/exynos4412.dtsi
>>> index e743e67..cfad655 100644
>>> --- a/arch/arm/boot/dts/exynos4412.dtsi
>>> +++ b/arch/arm/boot/dts/exynos4412.dtsi
>>> @@ -35,6 +35,12 @@
>>>  			     <0 107 0>, <0 108 0>, <0 48 0>, <0 42 0>;
>>>  	};
>>>
>>> +	pmu {
>>> +		compatible = "arm,cortex-a9-pmu";
>>> +		interrupt-parent = <&combiner>;
>>> +		interrupts = <2 2>, <3 2>, <18 2>, <19 2>;
>>> +	};
>>> +
>>>  	mct at 10050000 {
>>>  		compatible = "samsung,exynos4412-mct";
>>>  		reg = <0x10050000 0x800>;
>>>
>>
>> Tested on Exynos4412 based Origen-Quad board. You would required to
>> rebase it on latest code though.
>>
>> Tested-by: Tushar Behera <tushar.behera@linaro.org>
> 
> You took old patch which I cannot remember now:) Actually, arm-pmu support
> for exynos4412 was already merged in the latest code.[1]. I sent a clean-up
> patch recently[2]. It could be more readable for exynos4412.
> Thanks.
> 

I realized that a little late. I have replied to the new patch with my
Tested-by.

> [1] : https://lkml.org/lkml/2014/3/12/27
> [2] : http://www.spinics.net/linux/lists/arm-kernel/msg325565.html
> 
> Best Regards,
> Chanho Park
> 


-- 
Tushar Behera
