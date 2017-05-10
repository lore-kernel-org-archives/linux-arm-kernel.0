From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 May 2017 16:31:09 +0100
Subject: [PATCH] irqchip/bcm2836: Move SMP startup code to arch/arm
In-Reply-To: <27076f41-1616-ea16-6422-11692f95bdec@raspberrypi.org>
References: <20170510132620.19685-1-marc.zyngier@arm.com>
 <2c3f16ea-8806-9ae8-9bae-02e198a59092@arm.com>
 <27076f41-1616-ea16-6422-11692f95bdec@raspberrypi.org>
Message-ID: <9334afc8-ddf1-b3ec-6560-ff720f8b82dc@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/17 16:07, Phil Elwell wrote:
> On 10/05/2017 14:32, Marc Zyngier wrote:
>> On 10/05/17 14:26, Marc Zyngier wrote:
>>> One of the RPi-2/3 irqchip's key features is that it contains some
>>> SMP startup code for the 32bit ARM architecture version. The only
>>> reason I can imagine for this is "RPi is special".
>>>
>>> Let's move this code where it belongs (in the platform support code),
>>> creating a shared include file for this purpose.
>>>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>
>> Also:
>> Fixes: 41f4988cc287 ("irqchip/bcm2836: Add SMP support for the 2836")
>>
>> 	M.
>>
> 
> The patch has some checkpatch warnings, but otherwise:

Bah...

WARNING: line over 80 characters
#51: FILE: arch/arm/mach-bcm/board_bcm2835.c:30:
+static int bcm2836_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#194: 
new file mode 100644

Yup, the checkpatch stamp of approval. My screen has stopped being 
limited to 80 chars at some point between 1989 and 1991. As for the
MAINTAINERS file, that's probably for the maintainers to pick it up.

> Reviewed-by: Phil Elwell <phil@raspberrypi.org>
> Tested-by: Phil Elwell <phil@raspberrypi.org>

Thanks. I assume you'll respin your DSB/SEV fix on top of this?

	M.
-- 
Jazz is not dead. It just smells funny...
