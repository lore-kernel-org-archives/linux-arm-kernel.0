From: aford173@gmail.com (Adam Ford)
Date: Thu, 4 Jan 2018 13:26:47 -0600
Subject: [PATCH v4 6/7] ARM: davinci: convert to common clock framework
In-Reply-To: <f09641b7-a9e9-24d1-ce13-1b627d077ce5@lechnology.com>
References: <1514763588-31560-1-git-send-email-david@lechnology.com>
 <1514763588-31560-7-git-send-email-david@lechnology.com>
 <e36250ba-3f76-71d9-206f-475738d19e36@ti.com>
 <f09641b7-a9e9-24d1-ce13-1b627d077ce5@lechnology.com>
Message-ID: <CAHCN7x+N7KThCXsqrKiSetNeyaEW3BzwVBH_8KSqJVtb8hXFNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 4, 2018 at 11:50 AM, David Lechner <david@lechnology.com> wrote:
>
>
> On 1/4/18 6:39 AM, Sekhar Nori wrote:
>>
>> On Monday 01 January 2018 05:09 AM, David Lechner wrote:
>>>
>>> This converts all of arch/arm/mach-davinci to the common clock framework.
>>> The clock drivers from clock.c and psc.c have been moved to drivers/clk,
>>> so these files are removed.
>>>
>>> There is one subtle change in the clock trees. AUX, BPDIV and OSCDIV
>>> clocks now have "ref_clk" as a parent instead of the PLL clock. These
>>> clocks are part of the PLL's MMIO block, but they bypass the PLL and
>>> therefore it makes more sense to have "ref_clk" as their parent since
>>> "ref_clk" is the input clock of the PLL.
>>>
>>> CONFIG_DAVINCI_RESET_CLOCKS is removed since the common clock frameworks
>>> takes care of disabling unused clocks.
>>>
>>> Known issue: This breaks CPU frequency scaling on da850.
>>
>>
>> This functionality needs to be restored as part of this series since we
>> cannot commit anything with regressions.
>>
>
> Do you have a suggestion on how to accomplish this? I don't have a board for
> testing, so I don't have a way of knowing if my changes will work or not.

I work for Logic PD who makes the original da850-evm.  I can help if
you want to send me patches.  It would be better if you had a git repo
setup where I could just clone the repo and tests.

Having a larger collection of smaller the patches would also give me
the ability to bisect down to help determine what actually breaks the
da850-evm vs a few large patches.

Do you still need me to run the board with some of the extra debugging
enabled, or should I wait for the next round of patches?

adam

>
>>>
>>> Also, the order of #includes are cleaned up in files while we are
>>> touching
>>> this code.
>>>
>>> Signed-off-by: David Lechner <david@lechnology.com>
>>
>>
>> This is a pretty huge patch again and I hope it can be broken down.
>> Ideally one per SoC converted and then the unused code removal.
>>
>
> Will do.
