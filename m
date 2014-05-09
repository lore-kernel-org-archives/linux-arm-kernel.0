From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 09 May 2014 10:01:39 +0200
Subject: [PATCHv4 7/7] ARM: dts: Add device tree sources for Exynos3250
In-Reply-To: <536C7F65.50503@samsung.com>
References: <1398388572-30239-1-git-send-email-cw00.choi@samsung.com>
 <1398388572-30239-8-git-send-email-cw00.choi@samsung.com>
 <535B0324.50705@gmail.com> <536C2A1C.6030807@samsung.com>
 <536C6175.5000302@gmail.com> <536C7F65.50503@samsung.com>
Message-ID: <536C8B63.3000400@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09.05.2014 09:10, Chanwoo Choi wrote:
> Hi Tomasz,
> 
> On 05/09/2014 02:02 PM, Tomasz Figa wrote:
>> Hi Chanwoo,
>>
>> On 09.05.2014 03:06, Chanwoo Choi wrote:
>>> On 04/26/2014 09:51 AM, Tomasz Figa wrote:
>>>> On 25.04.2014 03:16, Chanwoo Choi wrote:
>>
>> [snip]
>>
>>>>> +    cpus {
>>>>> +        #address-cells = <1>;
>>>>> +        #size-cells = <0>;
>>>>> +
>>>>> +        cpu at 0 {
>>>>> +            device_type = "cpu";
>>>>> +            compatible = "arm,cortex-a7";
>>>>> +            reg = <0>;
>>>>> +            clock-frequency = <1000000000>;
>>>>> +        };
>>>>
>>>> Why only one CPU? I believe Exynos3250 is dual core.
>>>
>>> I'll add cpu1 information.
>>>
>>>> Also are physical IDs of the cores really 0 and 1? On Exynos4210 for example they are 0x900 and 0x901, while on Exynos4212 they are 0xa00 and 0xa01. Please check this.
>>>
>>> The 'reg' property means only hardware id(hwid) of CPU.
>>> You can check it on arm_dt_init_cpu_maps() in arch/arm/kernel/devtree.c.h.
>>> or Documentation/devicetree/bindings/arm/cpus.txt.
>>>
>>
>> Well, as described in Documentation/devicetree/bindings/arm/cpus.txt, on 32-bit ARM v7 or later CPUs the "reg" property should be equal to the lower 24-bits of MPIDR value of given CPU, which in addition to core ID includes also cluster ID, which can be non-zero, even on single cluster SoCs (like it is on Exynos4210 and 4x12).
> 
> I checked the lower 24-bit of MPIDR value for Exynos3250 in arm_dt_init_cpu_maps().
> - the lower 24-bit of MPIDR for CPU0 is '0x0'.

Fair enough. Thanks.

Best regards,
Tomasz
