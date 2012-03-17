From: lee.jones@linaro.org (Lee Jones)
Date: Sat, 17 Mar 2012 08:49:58 +0000
Subject: [GIT PULL] [for v3.4] Pull request containing ux500 DT enablement
In-Reply-To: <201203162009.48239.arnd@arndb.de>
References: <4F62220D.1090106@linaro.org> <201203162009.48239.arnd@arndb.de>
Message-ID: <4F645036.2030900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/03/12 20:09, Arnd Bergmann wrote:
> On Thursday 15 March 2012, Lee Jones wrote:
>> The following changes since commit fff9a13341312c8d0f06e04c1345e855528b03da:
>>
>>   ARM: ux500: CONFIG: Enable Device Tree support for future endeavours (2012-03-15 16:33:54 +0000)
>>
>> are available in the git repository at:
>>   git://git.linaro.org/people/ljones/linux-3.0-ux500.git device-tree-snowball-ux500
>>
>> Arnd Bergmann (3):
>>       ARM: ux500: Initial Device Tree support for Snowball
>>       ARM: ux500: combine the board init functions for DT boot
>>       ARM: ux500: split dts file for snowball into generic part
>>
>> Lee Jones (5):
>>       ARM: ux500: db8500: list most devices in the snowball device tree
>>       ARM: ux500: Enable Cortex-A9 GIC (Generic Interrupt Controller) in Device Tree
>>       ARM: ux500: Enable PL011 AMBA UART Controller for Device Tree
>>       ARM: ux500: Enable PL310 Level 2 Cache Controller in Device Tree
>>       ARM: ux500: Enable PL022 SSP Controller in Device Tree
> 
> I've pulled this into next/dt2, not next/dt for now. I had to rebase the patches
> as we discussed and then did some build tests to make sure nothing broke. I found
> one bug with your patches and CONFIG_OF disabled, which I fixed in the patch itself,

I did test the patch-set with CONFIG_OF disabled, but it looks like I
wasn't diligent enough to deselect CONFIG_MACH_UX500_DT, which selects
USE_OF.

Thanks for fixing though.

> and found some build warnings that you should take a look at in the for-next
> branch. 

Okay, that patch is actually going in via the drivers/base tree. I have
a patch to fix the compile errors. It's only a single character change.
Can you apply it through your tree? I'll send it up to the ML and CC
Greg and yourself.

> Also the patch "CONFIG: Enable Device Tree support for future endeavours"
> seems essential for the entire series, so I applied it as well, along with 
> your localtime patch.

Yes it is. It should have been part of the pull-request. That's my error
for rushing, sorry.

> I still think we can make it for v3.4, but I'll let this sit in linux-next for a
> few days longer than the other pull requests and if we find more problems it's out
> and gets postponed till v3.5.

I'm sure it will be fine now. :)

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
