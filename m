From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Fri, 6 Apr 2018 11:45:01 -0700
Subject: [BUG] Fix drivers/memory O= build
In-Reply-To: <20180406164615.GL5700@atomide.com>
References: <20180406102519.GN16141@n2100.armlinux.org.uk>
 <20180406164615.GL5700@atomide.com>
Message-ID: <06568f5b-3e4a-f761-7242-85dcc8aeb6a5@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/6/2018 9:46 AM, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@armlinux.org.uk> [180406 03:27]:
>> When building a kernel with split object directories, the following
>> failure occurs:
>>
>> .../drivers/memory/emif-asm-offsets.c:1:0: fatal error: can't open drivers/memory/emif-asm-offsets.s for writing: No such file or directory
>> compilation terminated.
>> drivers/memory/Makefile.asm-offsets:2: recipe for target 'drivers/memory/emif-asm-offsets.s' failed
>> make[2]: *** [drivers/memory/emif-asm-offsets.s] Error 1
>> .../Makefile:1060: recipe for target 'arch/arm/mach-omap2' failed
>> make[1]: *** [arch/arm/mach-omap2] Error 2
>>
>> This prevents any kernel being built that includes decending into
>> arch/arm/mach-omap2 with split object directories.
>>
>> This is a regression.
> 
> Dave, I presume you're looking into this already?
> 
Fix is already posted by 'Anders Roxell <anders.roxell@linaro.org>'
You are copied on the email Tony.

Regards,
Santosh
