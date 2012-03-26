From: robherring2@gmail.com (Rob Herring)
Date: Sun, 25 Mar 2012 20:50:44 -0500
Subject: [PATCH] ARM: tegra: Include assembler.h in sleep.S to fix build
 break
In-Reply-To: <4F6A0D99.2000309@gmail.com>
References: <1332176863-12537-1-git-send-email-swarren@wwwdotorg.org>
 <4F677691.8020307@gmail.com> <4F69FEB5.2020901@wwwdotorg.org>
 <4F6A0999.9020104@gmail.com> <4F6A0A44.3010304@wwwdotorg.org>
 <4F6A0D99.2000309@gmail.com>
Message-ID: <4F6FCB74.7010706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

On 03/21/2012 12:19 PM, Rob Herring wrote:
> On 03/21/2012 12:05 PM, Stephen Warren wrote:
>> On 03/21/2012 11:02 AM, Rob Herring wrote:
>>> On 03/21/2012 11:15 AM, Stephen Warren wrote:
>>>> On 03/19/2012 12:10 PM, Rob Herring wrote:
>>>>> On 03/19/2012 12:07 PM, Stephen Warren wrote:
>>>>>> Commit 6f6f6a7 "ARM: create a common IOMEM definition" moved macro
>>>>>> IOMEM(), and requires users to include <asm/assembler.h>. Fix Tegra's
>>>>>> sleep.S to do so.
>>>>>>
>>>>>> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
>>>>>
>>>>> Acked-by: Rob Herring <rob.herring@calxeda.com>
>>>>
>>>> Arnd,
>>>>
>>>> Can you pick up this fix directly into arm-soc, or do you want me to
>>>> generate a pull request for this kind of thing too?
>>>>
>>>> ARM: tegra: Include assembler.h in sleep.S to fix build break
>>>> http://patchwork.ozlabs.org/patch/147587/
>>>>
>>>> The same goes for:
>>>>
>>>> ARM: tegra: Fix device tree AUXDATA for USB/EHCI
>>>> http://patchwork.ozlabs.org/patch/147616/
>>>
>>> I can take it and send the pull request. I've got a couple of other
>>> fixes as well.
>>
>> That's just for the sleep.S change, right.
> 
> Ah, I missed the 2nd one. So it makes less sense now for me to take it.
> I'm still happy to, but it doesn't really save you anything.

After our irc discussion, I pulled this in and then realized this is a
newly added file that's not in my tree. So you should send this fix to
Arnd/Olof.

Rob
