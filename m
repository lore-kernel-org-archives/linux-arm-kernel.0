From: david@lechnology.com (David Lechner)
Date: Fri, 4 May 2018 09:26:02 -0500
Subject: [PATCH v9 07/27] ARM: davinci: dm355: add new clock init using
 common clock framework
In-Reply-To: <093052da-08b8-fe68-d319-254ae1da4d0d@ti.com>
References: <20180427001745.4116-1-david@lechnology.com>
 <20180427001745.4116-8-david@lechnology.com>
 <d9633747-0c50-2934-d3b2-ba745f021077@ti.com>
 <18b7b217-7ccb-d2dd-8f2c-ba3ba0e5d893@lechnology.com>
 <093052da-08b8-fe68-d319-254ae1da4d0d@ti.com>
Message-ID: <8e248f88-4a21-0862-28f4-fb03f90493ae@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2018 05:01 AM, Sekhar Nori wrote:
> On Thursday 03 May 2018 09:14 PM, David Lechner wrote:
>> On 05/03/2018 10:34 AM, Sekhar Nori wrote:
>>> On Friday 27 April 2018 05:47 AM, David Lechner wrote:
>>>> This adds the new board-specific clock init in mach-davinci/dm355.c
>>>> using the new common clock framework drivers.
>>>>
>>>> The #ifdefs are needed to prevent compile errors until the entire
>>>> ARCH_DAVINCI is converted.
>>>>
>>>> Also clean up the #includes since we are adding some here.
>>>>
>>>> Signed-off-by: David Lechner <david@lechnology.com>
>>>
>>> I am having trouble booting DM355 EVM with the series applied.
>>> Still to debug what is going wrong.
>>
>> Can you dump the PLL registers using /sys/kernel/debug/clk/... ?
> 
> I was able to get to ramdisk shell if I set clk_ignore_unused. Here is
> the dump:
> 

...

> I didn't have time today to analyze these myself. Hope it helps.
> 

I just sent out a patch to fix this: "clk: davinci: pll-dm355: fix
SYSCLKn parent names".
