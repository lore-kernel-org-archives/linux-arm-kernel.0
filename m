From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Jul 2016 10:18:08 -0600
Subject: [PATCH V2 03/10] Documentation: dt-bindings: firmware: tegra: add
 bindings of the BPMP
In-Reply-To: <578C88EC.10706@nvidia.com>
References: <20160705090431.5852-1-josephl@nvidia.com>
 <20160705090431.5852-4-josephl@nvidia.com>
 <20160711142238.GA30600@rob-hp-laptop> <5783C3DE.3080708@wwwdotorg.org>
 <578C88EC.10706@nvidia.com>
Message-ID: <578D0140.6070004@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2016 01:44 AM, Joseph Lo wrote:
> Hi Rob,
>
> Thanks for your reviewing.
>
> On 07/12/2016 12:05 AM, Stephen Warren wrote:
>> On 07/11/2016 08:22 AM, Rob Herring wrote:
>>> On Tue, Jul 05, 2016 at 05:04:24PM +0800, Joseph Lo wrote:
>>>> The BPMP is a specific processor in Tegra chip, which is designed for
>>>> booting process handling and offloading the power management, clock
>>>> management, and reset control tasks from the CPU. The binding document
>>>> defines the resources that would be used by the BPMP firmware driver,
>>>> which can create the interprocessor communication (IPC) between the CPU
>>>> and BPMP.
>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
>>>> b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
>>
>>>> +NVIDIA Tegra Boot and Power Management Processor (BPMP)
>>>> +
>>>> +The BPMP is a specific processor in Tegra chip, which is designed for
>>>> +booting process handling and offloading the power management, clock
>>>> +management, and reset control tasks from the CPU. The binding document
>>>> +defines the resources that would be used by the BPMP firmware driver,
>>>> +which can create the interprocessor communication (IPC) between the
>>>> CPU
>>>> +and BPMP.
>>>> +
>>>> +Required properties:
>>>> +- name : Should be bpmp
>>>> +- compatible
>>>> +    Array of strings
>>>> +    One of:
>>>> +    - "nvidia,tegra186-bpmp"
>>>> +- mboxes : The phandle of mailbox controller and the mailbox
>>>> specifier.
>>>> +- shmem : List of the phandle of the TX and RX shared memory area that
>>>> +      the IPC between CPU and BPMP is based on.
>>>
>>> I think you can use memory-region here.
>>
>> Isn't memory-region intended for references into the /reserved-memory
>> node. If so, that isn't appropriate in this case since this property
>> typically points at on-chip SRAM that isn't included in the OS's view of
>> "system RAM".
> Agree with that.
>
>>
>> Or, should /reserved-memory be used even for (e.g. non-DRAM) memory
>> regions that aren't represented by the /memory/reg property?
>>
>
> For shmem, I follow the same concept of the binding for arm,scpi
> (.../arm/arm,scpi.txt) that is currently using in mainline. Do you think
> that is more appropriate here?

Personally I think the shmem property name used by the current patch is 
fine. Still, if Rob feels strongly about changing it, that's fine too.
