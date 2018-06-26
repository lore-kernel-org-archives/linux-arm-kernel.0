From: david@lechnology.com (David Lechner)
Date: Tue, 26 Jun 2018 10:34:32 -0500
Subject: =?UTF-8?Q?Re:_[PATCH_v11_00/27]_ARM:_davinci:_convert_to_common_clo?=
 =?UTF-8?B?Y2sgZnJhbWV3b3Jr4oCL?=
In-Reply-To: <a45f20fe-61f1-6c10-c44d-655f9960d824@ti.com>
References: <20180518164829.27052-1-david@lechnology.com>
 <850a0ec9-53aa-02a5-ecbd-e068b13b2764@ti.com>
 <9ca9d240-f556-cb4f-1a58-4a55c379a02f@lechnology.com>
 <a45f20fe-61f1-6c10-c44d-655f9960d824@ti.com>
Message-ID: <33875d5b-6e99-fa38-20aa-9701e2c851d6@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2018 07:56 AM, Sekhar Nori wrote:
> On Friday 25 May 2018 11:51 PM, David Lechner wrote:
>> On 05/22/2018 04:38 AM, Sekhar Nori wrote:
>>> Hi David,
>>>
>>> On Friday 18 May 2018 10:18 PM, David Lechner wrote:
>>>> This series converts mach-davinci to use the common clock framework.
>>>>
>>>> The series works like this, the first 3 patches fix some issues with
>>>> the clock
>>>> drivers that have already been accepted into the mainline kernel.
>>>>
>>>> Then, starting with "ARM: davinci: pass clock as parameter to
>>>> davinci_timer_init()", we get the mach code ready for the switch by
>>>> adding the
>>>> code needed for the new clock drivers and adding #ifndef
>>>> CONFIG_COMMON_CLK
>>>> around the legacy clocks so that we can switch easily between the old
>>>> and the
>>>> new.
>>>>
>>>> "ARM: davinci: switch to common clock framework" actually flips the
>>>> switch
>>>> to start using the new clock drivers. Then the next 8 patches remove all
>>>> of the old clock code.
>>>>
>>>> The final four patches add device tree clock support to the one SoC that
>>>> supports it.
>>>>
>>>> This series has been tested on TI OMAP-L138 LCDK (both device tree
>>>> and legacy
>>>> board file).
>>>
>>> If you do end up sending a v12, you can leave out the mach-davinci
>>> portions unless there are any changes you need to make. I will pick them
>>> up from this series once the driver dependencies are merged.
>>>
>>> I do hope the drivers/clk/* changes can be merged from v4.18.
>>>
>>
>> I have resent all of the clk patches (including all of the ones I listed as
>> dependencies in addition to the three remaining in this series) under the
>> cover "clk: davinci: outstanding fixes?".
>>
>> I also found that we need to add power-domains properties to the PWM nodes
>> in "ARM: dts: da850: Add clocks". I probably should just take your advice
>> and just globally added them even if they are not documented for some types
>> ofnodes.
> 
> I think doing it en masse will be controversial. Just add it to PWM
> nodes for now (I am assuming the binding documentation agrees).
> 
> I have applied this series so please send any more changes as follow-on
> patches.
> 
> Thanks
> Sekhar
> 

FYI, there are some CPU frequency scaling patches that I was playing around
with, but I don't plan on submitting them since they aren't much use to me
at the moment. If anyone would like to pick them up, you can find them at
https://github.com/dlech/linux/tree/da850-dt-cpufreq.
