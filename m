From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 18 Jan 2012 18:50:46 +0000
Subject: [PATCH v2 1/3] ARM: davinci: convert to common sched_clock()
 implementation
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B631794A9F@DBDE01.ent.ti.com>
References: <1326903292-15794-1-git-send-email-marc.zyngier@arm.com>
 <1326903292-15794-2-git-send-email-marc.zyngier@arm.com>
 <DF0F476B391FA8409C78302C7BA518B631794A9F@DBDE01.ent.ti.com>
Message-ID: <4F171486.80105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On 18/01/12 18:36, Nori, Sekhar wrote:
> On Wed, Jan 18, 2012 at 21:44:50, Marc Zyngier wrote:
>> Davinci has its own sched_clock() implementation, which gets in the
>> way of a single zImage. Moving to the common sched_clock framework
>> makes the code slightly cleaner.
>>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Tested this on DaVinci DM365 and works well.

Thanks for giving it a go.

>> diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
>> index e1969ce..187fcda 100644
>> --- a/arch/arm/mach-davinci/time.c
>> +++ b/arch/arm/mach-davinci/time.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/platform_device.h>
>>  
>>  #include <mach/hardware.h>
>> +#include <asm/sched_clock.h>
>>  #include <asm/mach/irq.h>
>>  #include <asm/mach/time.h>
>>  #include <mach/cputype.h>
> 
> I did not like the fact that the asm/ and mach/ headers
> are intermixed in this file so I created a patch to
> fix that while I was doing the common sched_clock() conversion.
> 
> http://www.spinics.net/lists/arm-kernel/msg153506.html
> 
> Can you please rebase your patch on that?

Sure. I can probably merge that patch altogether in mine if you want.

> If you are planning to take this from outside of DaVinci tree,
> feel free to add my:
> 
> Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks. Ideally, I'd like all 3 patches to be kept together, otherwise
we may end up with patch 3 being applied before patch 1, breaking your
platform.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
